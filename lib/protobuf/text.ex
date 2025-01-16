defmodule Protobuf.Text do
  @moduledoc """
  Text encoding of protobufs

  According to https://protobuf.dev/reference/protobuf/textformat-spec/, without
  extensions or `Google.Protobuf.Any` support.

  Useful for inspecting/debugging protobuf-encoded data.

  > #### Warning {: .warning}
  >
  > This module doesn't perform any validation in the inputs. If the input data
  > is invalid, it produces undecodable output.

  """

  alias Protobuf.FieldProps
  alias Protobuf.MessageProps

  @typep acc :: %{
           pad: pos_integer(),
           pad_size: pos_integer(),
           current_line_width: pos_integer(),
           max_line_width: pos_integer(),
           newline?: boolean(),
           should_pad?: boolean()
         }

  @default_acc %{
    pad: 0,
    pad_size: 2,
    current_line_width: 0,
    max_line_width: 80,
    newline?: false,
    should_pad?: true
  }

  @doc """
  Encodes a protobuf struct to text.

  Accepts the following options:

  - `:pad_size` - indentation size, in number of spaces
  - `:max_line_width` - maximum line width, in columns

  Doesn't perform any validations. If input data is invalid, it produces
  undecodable output.
  """
  def encode(struct, opts \\ []) do
    %{syntax: syntax} = message_props = struct.__struct__.__message_props__()

    opts_map =
      opts
      |> Keyword.take([:pad_size, :max_line_width])
      |> Map.new()

    struct
    |> transform_module(struct.__struct__)
    |> encode_struct(syntax, message_props, Map.merge(@default_acc, opts_map))
    |> IO.iodata_to_binary()
  end

  @spec encode_field(
          {atom(), term()},
          :proto2 | :proto3,
          MessageProps.t(),
          acc()
        ) :: iodata()
  defp encode_field({name, value}, syntax, message_props, acc) do
    case Enum.find(message_props.field_props, fn {_, prop} -> prop.name_atom == name end) do
      {_fnum, field_prop} ->
        if skip_field?(syntax, value, field_prop) do
          []
        else
          enc_name = to_string(name)
          acc = incr_width(acc, String.length(enc_name) + 3)

          [
            pad(acc),
            to_string(name),
            ?:,
            ?\s,
            encode_value(value, syntax, field_prop, %{acc | should_pad?: false}),
            newline(acc)
          ]
        end

      nil ->
        if Enum.any?(message_props.oneof, fn {oneof_name, _} -> name == oneof_name end) do
          case value do
            {field_name, field_value} ->
              encode_field({field_name, field_value}, syntax, message_props, acc)

            nil ->
              []

            _ ->
              raise "Invalid value for oneof `#{inspect(name)}`: #{inspect(value)}"
          end
        else
          raise "unknown field #{inspect(name)}"
        end
    end
  end

  @spec encode_value(term(), :proto2 | :proto3, FieldProps.t(), acc()) :: iodata()
  defp encode_value(value, syntax, %{repeated?: true} = field_prop, acc) when is_list(value) do
    preencoded =
      value
      |> Enum.map(&encode_value(&1, syntax, field_prop, %{acc | should_pad?: false}))
      |> Enum.intersperse([?,, ?\s])

    # For []
    acc = incr_width(acc, 2)

    # If the first attempt at encoding would break maximum line size, we re-encode
    # breaking into multiple lines
    if exceeding_max_width?(preencoded, acc) do
      nacc = set_newline(acc)

      encoded =
        value
        |> Enum.map(&encode_value(&1, syntax, field_prop, nacc))
        |> Enum.intersperse([?,, ?\n])

      [?[, ?\n, encoded, ?\n, pad(%{acc | should_pad?: true}), ?]]
    else
      [?[, preencoded, ?]]
    end
  end

  defp encode_value(value, syntax, %{map?: true, repeated?: false} = field_prop, acc) do
    as_list =
      Enum.map(value, fn {k, v} -> struct(field_prop.type, key: k, value: v) end)

    encode_value(as_list, syntax, %{field_prop | repeated?: true}, acc)
  end

  defp encode_value(value, syntax, %{embedded?: true, type: mod}, acc) do
    value
    |> transform_module(mod)
    |> encode_struct(syntax, mod.__message_props__(), acc)
  end

  defp encode_value(nil, :proto2, %FieldProps{required?: true, name_atom: name}, _) do
    raise "field #{inspect(name)} is required"
  end

  defp encode_value(value, _, _, acc) when is_atom(value) do
    [pad(acc), to_string(value)]
  end

  defp encode_value(value, _, _, acc) do
    [pad(acc), inspect(value)]
  end

  @spec encode_struct(term(), :proto2 | :proto3, MessageProps.t(), acc()) :: iodata()
  defp encode_struct(nil, _, _, _) do
    [?{, ?}]
  end

  defp encode_struct(%_{} = struct, syntax, message_props, acc) do
    fields =
      struct
      |> Map.from_struct()
      |> Map.drop([:__unknown_fields__, :__struct__, :__pb_extensions__])
      |> Enum.sort()

    preencoded_fields =
      fields
      |> Enum.map(
        &encode_field(&1, syntax, message_props, %{acc | should_pad?: false, newline?: false})
      )
      |> Enum.reject(&Enum.empty?/1)
      |> Enum.intersperse([?,, ?\s])

    # For {}
    acc = incr_width(acc, 2)

    # If the first attempt at encoding would break maximum line size, we re-encode
    # breaking into multiple lines
    if exceeding_max_width?(preencoded_fields, acc) do
      nacc = set_newline(acc)

      encoded_fields =
        fields
        |> Enum.map(&encode_field(&1, syntax, message_props, nacc))
        |> Enum.reject(&Enum.empty?/1)

      [pad(acc), ?{, ?\n, encoded_fields, pad(%{acc | should_pad?: true}), ?}]
    else
      [pad(acc), ?{, preencoded_fields, ?}]
    end
  end

  @spec exceeding_max_width?(iodata(), acc()) :: boolean()
  defp exceeding_max_width?(preencoded, acc) do
    IO.iodata_length(preencoded) + acc.current_line_width > acc.max_line_width
  end

  @spec set_newline(acc()) :: acc()
  defp set_newline(acc) do
    %{
      acc
      | newline?: true,
        pad: acc.pad + acc.pad_size,
        should_pad?: true,
        current_line_width: acc.pad + acc.pad_size
    }
  end

  @spec incr_width(acc(), integer()) :: acc()
  defp incr_width(acc, val) do
    %{acc | current_line_width: acc.current_line_width + val}
  end

  @spec pad(acc()) :: iodata()
  defp pad(%{should_pad?: false}), do: []
  defp pad(%{pad: pad}), do: List.duplicate(?\s, pad)

  @spec newline(acc()) :: iodata()
  defp newline(%{newline?: true}), do: ?\n
  defp newline(%{newline?: false}), do: []

  defp transform_module(message, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(message, module)
    else
      message
    end
  end

  # Copied from Protobuf.Encoder. Should this be somewhere else?
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
end
