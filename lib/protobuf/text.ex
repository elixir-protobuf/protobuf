defmodule Protobuf.Text do
  @moduledoc """
  Text encoding of Protobufs

  Compliant with the
  [textproto spec](https://protobuf.dev/reference/protobuf/textformat-spec/),
  but without extensions or `Google.Protobuf.Any` support (yet).

  Useful for inspecting Protobuf data.
  """

  alias Protobuf.FieldProps
  alias Protobuf.MessageProps
  alias Inspect.Algebra

  @doc """
  Encodes a Protobuf struct to text.

  Accepts the following options:

  - `:max_line_width` - maximum line width, in columns. Defaults to 80. Lines
  may still be bigger than the limit, depending on the data.
  - `:print_unknown_fields?` - if `true`, prints unknown fields. Notice this makes
  the output impossible to decode, per current Protobuf spec. Defaults to `false`.

  Doesn't perform type validations. If input data is invalid, it produces
  undecodable output.
  """
  @spec encode(struct(), Keyword.t()) :: binary()
  def encode(%mod{} = struct, opts \\ []) do
    max_line_width = Keyword.get(opts, :max_line_width, 80)
    message_props = mod.__message_props__()
    print_unknown? = Keyword.get(opts, :print_unknown_fields?, false)

    struct
    |> transform_module(mod)
    |> encode_struct(message_props, true, print_unknown?)
    |> Algebra.format(max_line_width)
    |> IO.iodata_to_binary()
  end

  @spec encode_struct(struct(), MessageProps.t(), boolean(), boolean()) ::
          Algebra.t()
  defp encode_struct(%_{} = struct, message_props, root?, print_unknown?) do
    %{syntax: syntax} = message_props

    fields = prepare_fields(struct, print_unknown?)

    if root? do
      empty = Algebra.empty()

      fields
      |> Enum.reduce([], fn value, acc ->
        case encode_struct_field(value, syntax, message_props, print_unknown?) do
          ^empty -> acc
          doc -> [Algebra.break(", "), doc | acc]
        end
      end)
      |> safe_tail()
      |> Enum.reverse()
      |> Algebra.concat()
      |> Algebra.group()
    else
      fun = fn value, _opts ->
        encode_struct_field(value, syntax, message_props, print_unknown?)
      end

      Algebra.container_doc("{", fields, "}", inspect_opts(), fun, break: :strict)
    end
  end

  defp prepare_fields(struct, print_unknown?) do
    unknown_fields =
      if print_unknown? do
        Enum.map(struct.__unknown_fields__, fn {field_number, _wire_type, value} ->
          {field_number, value}
        end)
      else
        []
      end

    struct
    |> Map.drop([:__unknown_fields__, :__struct__, :__pb_extensions__])
    |> Enum.sort()
    |> Kernel.++(unknown_fields)
  end

  defp safe_tail([]), do: []
  defp safe_tail([_head | tail]), do: tail

  @spec encode_struct_field(
          {atom() | integer(), term()},
          :proto2 | :proto3,
          MessageProps.t(),
          boolean()
        ) :: Algebra.t()
  defp encode_struct_field({name, value}, syntax, message_props, print_unknown?)
       when is_atom(name) do
    case Enum.find(message_props.field_props, fn {_, prop} -> prop.name_atom == name end) do
      {_fnum, field_prop} ->
        if skip_field?(syntax, value, field_prop) do
          Algebra.empty()
        else
          Algebra.concat([
            to_string(name),
            ": ",
            encode_value(value, syntax, field_prop, print_unknown?)
          ])
        end

      nil ->
        if Enum.any?(message_props.oneof, fn {oneof_name, _} -> name == oneof_name end) do
          case value do
            {field_name, field_value} ->
              encode_struct_field(
                {field_name, field_value},
                syntax,
                message_props,
                print_unknown?
              )

            nil ->
              Algebra.empty()

            _ ->
              raise "invalid value for oneof `#{inspect(name)}`: #{inspect(value)}"
          end
        else
          raise "unknown field #{inspect(name)}"
        end
    end
  end

  # unknown fields
  defp encode_struct_field({number, value}, _syntax, _, _) when is_integer(number) do
    Algebra.concat([to_string(number), ": ", inspect(value)])
  end

  @spec encode_value(term(), :proto2 | :proto3, FieldProps.t(), boolean()) :: Algebra.t()
  defp encode_value(value, syntax, %{repeated?: true} = field_prop, print_unknown?)
       when is_list(value) do
    fun = fn val, _opts -> encode_value(val, syntax, field_prop, print_unknown?) end
    Algebra.container_doc("[", value, "]", inspect_opts(), fun, break: :strict)
  end

  defp encode_value(value, syntax, %{map?: true, repeated?: false} = field_prop, print_unknown?) do
    as_list =
      Enum.map(value, fn {k, v} -> struct(field_prop.type, key: k, value: v) end)

    encode_value(as_list, syntax, %{field_prop | repeated?: true}, print_unknown?)
  end

  defp encode_value(value, _syntax, %{embedded?: true, type: mod}, print_unknown?) do
    value
    |> transform_module(mod)
    |> encode_struct(mod.__message_props__(), false, print_unknown?)
  end

  defp encode_value(nil, :proto2, %FieldProps{required?: true, name_atom: name}, _) do
    raise "field #{inspect(name)} is required"
  end

  defp encode_value(value, _, _, _) when is_atom(value) do
    to_string(value)
  end

  defp encode_value(value, _, _, _) do
    inspect(value)
  end

  defp transform_module(message, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(message, module)
    else
      message
    end
  end

  # Copied from Protobuf.Encoder. Should it be shared?
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
  defp skip_field?(:proto3, value, %FieldProps{type: {:enum, enum_mod}, oneof: nil}) do
    enum_props = enum_mod.__message_props__()
    %{name_atom: name_atom, name: name, json_name: name_json} = enum_props.field_props[0]

    value == name_atom or value == name or value == name_json
  end

  defp skip_field?(_, _, _), do: false

  defp inspect_opts(), do: %Inspect.Opts{limit: :infinity}
end
