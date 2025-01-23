defmodule Protobuf.Text do
  alias Protobuf.FieldProps
  alias Protobuf.MessageProps
  alias Inspect.Algebra

  @doc """
  Encodes a protobuf struct to text.

  Accepts the following options:

  - `:max_line_width` - maximum line width, in columns. Defaults to 80.

  Doesn't perform type validations. If input data is invalid, it produces
  undecodable output.
  """
  @spec encode(struct(), Keyword.t()) :: binary()
  def encode(struct, opts \\ []) do
    max_line_width = Keyword.get(opts, :max_line_width, 80)
    message_props = struct.__struct__.__message_props__()

    struct
    |> transform_module(struct.__struct__)
    |> encode_struct(message_props)
    |> Algebra.format(max_line_width)
    |> IO.iodata_to_binary()
  end

  @spec encode_struct(struct() | nil, MessageProps.t()) :: Algebra.t()
  defp encode_struct(%_{} = struct, message_props) do
    %{syntax: syntax} = message_props

    fields =
      struct
      |> Map.from_struct()
      |> Map.drop([:__unknown_fields__, :__struct__, :__pb_extensions__])
      |> Enum.sort()

    fun = fn value, _opts ->
      encode_struct_field(value, syntax, message_props)
    end

    Algebra.container_doc("{", fields, "}", inspect_opts(), fun, break: :strict)
  end

  defp encode_struct(nil, _) do
    "{}"
  end

  @spec encode_struct_field({atom(), term()}, :proto2 | :proto3, MessageProps.t()) :: Algebra.t()
  defp encode_struct_field({name, value}, syntax, message_props) do
    case Enum.find(message_props.field_props, fn {_, prop} -> prop.name_atom == name end) do
      {_fnum, field_prop} ->
        if skip_field?(syntax, value, field_prop) do
          Algebra.empty()
        else
          Algebra.concat([
            to_string(name),
            ": ",
            encode_value(value, syntax, field_prop)
          ])
        end

      nil ->
        if Enum.any?(message_props.oneof, fn {oneof_name, _} -> name == oneof_name end) do
          case value do
            {field_name, field_value} ->
              encode_struct_field({field_name, field_value}, syntax, message_props)

            nil ->
              Algebra.empty()

            _ ->
              raise "Invalid value for oneof `#{inspect(name)}`: #{inspect(value)}"
          end
        else
          raise "unknown field #{inspect(name)}"
        end
    end
  end

  @spec encode_value(term(), :proto2 | :proto3, FieldProps.t()) :: Algebra.t()
  defp encode_value(value, syntax, %{repeated?: true} = field_prop) when is_list(value) do
    fun = fn val, _opts -> encode_value(val, syntax, field_prop) end
    Algebra.container_doc("[", value, "]", inspect_opts(), fun, break: :strict)
  end

  defp encode_value(value, syntax, %{map?: true, repeated?: false} = field_prop) do
    as_list =
      Enum.map(value, fn {k, v} -> struct(field_prop.type, key: k, value: v) end)

    encode_value(as_list, syntax, %{field_prop | repeated?: true})
  end

  defp encode_value(value, _syntax, %{embedded?: true, type: mod}) do
    value
    |> transform_module(mod)
    |> encode_struct(mod.__message_props__())
  end

  defp encode_value(nil, :proto2, %FieldProps{required?: true, name_atom: name}) do
    raise "field #{inspect(name)} is required"
  end

  defp encode_value(value, _, _) when is_atom(value) do
    to_string(value)
  end

  defp encode_value(value, _, _) do
    inspect(value)
  end

  defp transform_module(message, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(message, module)
    else
      message
    end
  end

  defp skip_field?(_syntax, [], _prop), do: true
  defp skip_field?(_syntax, val, _prop) when is_map(val), do: map_size(val) == 0
  defp skip_field?(:proto2, nil, %FieldProps{optional?: optional?}), do: optional?
  defp skip_field?(:proto2, value, %FieldProps{default: value, oneof: nil}), do: true
  defp skip_field?(:proto3, val, %FieldProps{proto3_optional?: true}), do: is_nil(val)

  defp skip_field?(:proto3, nil, _prop), do: true
  defp skip_field?(:proto3, 0, %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, +0.0, %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, "", %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, false, %FieldProps{oneof: nil}), do: true

  # This is actually new. Should it be ported to Protobuf.Encoder?
  defp skip_field?(:proto3, value, %FieldProps{type: {:enum, enum_mod}}) do
    enum_props = enum_mod.__message_props__()
    [first_tag | _] = enum_props.ordered_tags
    %{name_atom: name_atom, fnum: fnum} = enum_props.field_props[first_tag]
    value == name_atom or value == fnum
  end

  defp skip_field?(_, _, _), do: false

  defp inspect_opts(), do: %Inspect.Opts{limit: :infinity}
end
