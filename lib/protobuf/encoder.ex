defmodule Protobuf.Encoder do
  import Protobuf.WireTypes
  import Bitwise, only: [bsr: 2, band: 2, bsl: 2, bor: 2]

  alias Protobuf.{MessageProps, FieldProps}

  @spec encode(struct, keyword) :: iodata
  def encode(%mod{} = struct, opts \\ []) do
    res = encode!(struct, mod.__message_props__())
    res = Enum.reverse(res)

    case Keyword.fetch(opts, :iolist) do
      {:ok, true} -> res
      _ -> IO.iodata_to_binary(res)
    end
  end

  @spec encode!(struct, MessageProps.t()) :: iodata
  def encode!(struct, %{field_props: field_props} = props) do
    syntax = props.syntax
    oneofs = oneof_actual_vals(props, struct)

    Enum.reduce(Map.values(field_props), [], fn prop, acc ->
      try do
        %{name_atom: name, oneof: oneof} = prop

        val = if oneof, do: oneofs[name], else: Map.get(struct, name, nil)

        cond do
          syntax == :proto2 && ((val == nil && prop.optional?) || val == [] || val == %{}) ->
            acc

          syntax == :proto3 && ((empty_val?(val) && !oneof) || (oneof && is_nil(val))) ->
            acc

          true ->
            [encode_field(class_field(prop), val, prop) | acc]
        end
      rescue
        error ->
          stacktrace = System.stacktrace()

          msg =
            "Got error when encoding #{inspect(struct.__struct__)}##{prop.name_atom}: #{
              inspect(error)
            }"

          reraise Protobuf.EncodeError, [message: msg], stacktrace
      end
    end)
  end

  @spec encode_field(atom, any, FieldProps.t()) :: iodata
  def encode_field(:normal, val, %{encoded_fnum: fnum, type: type, repeated?: is_repeated}) do
    repeated_or_not(val, is_repeated, fn v ->
      [fnum, encode_type(type, v)]
    end)
  end

  def encode_field(
        :embedded,
        val,
        %{encoded_fnum: fnum, repeated?: is_repeated, map?: is_map} = prop
      ) do
    repeated = is_repeated || is_map

    repeated_or_not(val, repeated, fn v ->
      v = if is_map, do: struct(prop.type, %{key: elem(v, 0), value: elem(v, 1)}), else: v
      encoded = encode(v, iolist: true)
      byte_size = IO.iodata_length(encoded)
      [fnum, [encode_varint(byte_size), encoded]]
    end)
  end

  def encode_field(:packed, val, %{type: type, encoded_fnum: fnum}) do
    encoded = Enum.map(val, fn v -> encode_type(type, v) end)
    byte_size = IO.iodata_length(encoded)
    [fnum, [encode_varint(byte_size), encoded]]
  end

  @spec class_field(map) :: atom
  def class_field(%{wire_type: wire_delimited(), embedded?: true}) do
    :embedded
  end

  def class_field(%{repeated?: true, packed?: true}) do
    :packed
  end

  def class_field(_) do
    :normal
  end

  @spec encode_fnum(integer, integer) :: iodata
  def encode_fnum(fnum, wire_type) do
    fnum
    |> bsl(3)
    |> bor(wire_type)
    |> encode_varint
  end

  @spec encode_type(atom, any) :: iodata
  def encode_type(:int32, n), do: encode_varint(n)
  def encode_type(:int64, n), do: encode_varint(n)
  def encode_type(:uint32, n), do: encode_varint(n)
  def encode_type(:uint64, n), do: encode_varint(n)
  def encode_type(:sint32, n), do: n |> encode_zigzag |> encode_varint
  def encode_type(:sint64, n), do: n |> encode_zigzag |> encode_varint
  def encode_type(:bool, true), do: encode_varint(1)
  def encode_type(:bool, false), do: encode_varint(0)
  def encode_type(:enum, n), do: encode_varint(n)
  def encode_type(:fixed64, n), do: <<n::64-little>>
  def encode_type(:sfixed64, n), do: <<n::64-signed-little>>
  def encode_type(:double, n), do: <<n::64-float-little>>

  def encode_type(:bytes, n) do
    bin = IO.iodata_to_binary(n)
    len = bin |> byte_size |> encode_varint
    <<len::binary, bin::binary>>
  end

  def encode_type(:string, n) when is_atom(n), do: encode_type(:bytes, to_string(n))
  def encode_type(:string, n), do: encode_type(:bytes, n)
  def encode_type(:fixed32, n), do: <<n::32-little>>
  def encode_type(:sfixed32, n), do: <<n::32-signed-little>>
  def encode_type(:float, n), do: <<n::32-float-little>>

  @spec encode_zigzag(integer) :: integer
  def encode_zigzag(val) when val >= 0, do: val * 2
  def encode_zigzag(val) when val < 0, do: val * -2 - 1

  @spec encode_varint(integer) :: iodata
  def encode_varint(n) when n < 0 do
    <<n::64-unsigned-native>> = <<n::64-signed-native>>
    encode_varint(n)
  end

  def encode_varint(n) when n <= 127 and is_integer(n), do: <<n>>

  def encode_varint(n) when n > 127,
    do: <<1::1, band(n, 127)::7, encode_varint(bsr(n, 7))::binary>>

  @spec wire_type(atom) :: integer
  def wire_type(:int32), do: wire_varint()
  def wire_type(:int64), do: wire_varint()
  def wire_type(:uint32), do: wire_varint()
  def wire_type(:uint64), do: wire_varint()
  def wire_type(:sint32), do: wire_varint()
  def wire_type(:sint64), do: wire_varint()
  def wire_type(:bool), do: wire_varint()
  def wire_type(:enum), do: wire_varint()
  def wire_type(:fixed64), do: wire_64bits()
  def wire_type(:sfixed64), do: wire_64bits()
  def wire_type(:double), do: wire_64bits()
  def wire_type(:string), do: wire_delimited()
  def wire_type(:bytes), do: wire_delimited()
  def wire_type(:fixed32), do: wire_32bits()
  def wire_type(:sfixed32), do: wire_32bits()
  def wire_type(:float), do: wire_32bits()
  def wire_type(mod) when is_atom(mod), do: wire_delimited()

  defp repeated_or_not(val, repeated, func) do
    if repeated do
      Enum.map(val, func)
    else
      func.(val)
    end
  end

  defp empty_val?(v) do
    !v || v == 0 || v == "" || v == [] || v == %{}
  end

  defp oneof_actual_vals(
         %{field_tags: field_tags, field_props: field_props, oneof: oneof},
         struct
       ) do
    Enum.reduce(oneof, %{}, fn {field, index}, acc ->
      case Map.get(struct, field, nil) do
        {f, val} ->
          %{oneof: oneof} = field_props[field_tags[f]]

          if oneof != index do
            raise Protobuf.EncodeError,
              message: ":#{f} doesn't belongs to #{inspect(struct.__struct__)}##{field}"
          else
            Map.put(acc, f, val)
          end

        nil ->
          acc

        _ ->
          raise Protobuf.EncodeError,
            message: "#{inspect(struct.__struct__)}##{field} should be {key, val} or nil"
      end
    end)
  end
end
