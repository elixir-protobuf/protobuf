defmodule Protobuf.Decoder do
  import Protobuf.WireTypes
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  require Logger

  @max_bits 64
  @mask64 bsl(1, @max_bits) - 1

  alias Protobuf.{DecodeError, MessageProps, FieldProps}

  @spec decode(binary, atom) :: any
  def decode(data, module) do
    kvs = raw_decode_key(data, [])
    %{repeated_fields: repeated_fields} = msg_props = module.__message_props__()
    struct = build_struct(kvs, msg_props, module.new())
    reverse_repeated(struct, repeated_fields)
  end

  @doc false
  def decode_raw(data) do
    raw_decode_key(data, [])
  end

  defmacro decode_type_m(type, key, val) do
    quote do
      case unquote(type) do
        :int32 ->
          <<n::signed-integer-32>> = <<unquote(val)::32>>
          n
        :string -> unquote(val)
        :bytes -> unquote(val)
        :int64 ->
          <<n::signed-integer-64>> = <<unquote(val)::64>>
          n
        :uint32 -> unquote(val)
        :uint64 -> unquote(val)
        :bool -> unquote(val) != 0
        :sint32 -> decode_zigzag(unquote(val))
        :sint64 -> decode_zigzag(unquote(val))
        :fixed64 ->
          <<n::little-64>> = unquote(val)
          n
        :sfixed64 ->
          <<n::little-signed-64>> =unquote(val)
          n
        :double ->
          <<n::little-float-64>> = unquote(val)
          n
        :fixed32 ->
          <<n::little-32>> = unquote(val)
          n
        :sfixed32 ->
          <<n::little-signed-32>> = unquote(val)
          n
        :float ->
          <<n::little-float-32>> = unquote(val)
          n
        {:enum, enum_type} ->
          try do
            enum_type.key(unquote(val))
          rescue
            FunctionClauseError ->
              Logger.warn("unknown enum value #{unquote(val)} when decoding for #{inspect(unquote(type))}")
              unquote(val)
          end
        _ ->
          raise DecodeError, message: "can't decode type #{unquote(type)} for field #{unquote(key)}"
      end
    end
  end

  # ugly for performance
  def build_struct([tag, wire, val | rest], %{field_props: f_props} = msg_props, struct) do
    case f_props do
      %{^tag => %{wire_type: ^wire, repeated?: is_repeated, map?: is_map, type: type, oneof: oneof, name_atom: name_atom, embedded?: embedded} = prop} ->
        key = if oneof, do: oneof_field(prop, msg_props), else: name_atom
        struct = if embedded do
          embedded_msg = decode(val, type)
          val = if is_map, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
          val = if oneof, do: {name_atom, val}, else: val

          case struct do
            %{^key => nil} ->
              val = if is_repeated, do: [val], else: val
              Map.put(struct, key, val)

            %{^key => value} ->
              val = if is_repeated, do: [val|value], else: Map.merge(value, val)
              Map.put(struct, key, val)

            %{} ->
              val = if is_repeated, do: [val], else: val
              Map.put(struct, key, val)
          end
        else
          val = decode_type_m(type, key, val)
          val = if oneof, do: {name_atom, val}, else: val
          case struct do
            %{^key => nil} ->
              val = if is_repeated, do: [val], else: val
              Map.put(struct, key, val)

            %{^key => value} ->
              val = if is_repeated, do: [val|value], else: val
              Map.put(struct, key, val)

            %{} ->
              val = if is_repeated, do: [val], else: val
              Map.put(struct, key, val)
          end
        end
        build_struct(rest, msg_props, struct)
      %{^tag => %{packed?: true} = f_prop} ->
        struct = put_packed_field(struct, f_prop, val)
        build_struct(rest, msg_props, struct)
      %{^tag => %{wire_type: wire2} = f_prop} ->
        raise DecodeError, "wrong wire_type for #{prop_display(f_prop)}: got #{wire}, want #{wire2}"
      _ ->
        build_struct(rest, msg_props, struct)
    end
  end

  def build_struct([], _, struct) do
    struct
  end

  def decode_varint(bin, type \\ :key) do
    raw_decode_varint(bin, [], type)
  end

  defp raw_decode_key(<<>>, result), do: Enum.reverse(result)
  defp raw_decode_key(<<bin::bits>>, result), do: raw_decode_varint(bin, result, :key)

  defp raw_decode_varint(<<0::1, x::7, rest::bits>>, result, type) do
    raw_handle_varint(type, rest, result, x)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            0::1, x1::7, rest::bits>>, result, type) do
    val = bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            0::1, x2::7, rest::bits>>, result, type) do
    val = bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            0::1, x3::7, rest::bits>>, result, type) do
    val = bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            0::1, x4::7, rest::bits>>, result, type) do
    val = bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            0::1, x5::7, rest::bits>>, result, type) do
    val = bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            0::1, x6::7, rest::bits>>, result, type) do
    val = bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            0::1, x7::7, rest::bits>>, result, type) do
    val = bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            1::1, x7::7,
                            0::1, x8::7, rest::bits>>, result, type) do
    val = bsl(x8, 56) +bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            1::1, x7::7,
                            1::1, x8::7,
                            0::1, x9::7, rest::bits>>, result, type) do
    val = bsl(x9, 63) + bsl(x8, 56) +bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    val = band(val, @mask64)
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_handle_varint(:key, <<bin::bits>>, result, key) do
    tag = bsr(key, 3)
    wire_type = band(key, 7)
    raw_decode_value(wire_type, bin, [wire_type, tag | result])
  end

  defp raw_handle_varint(:value, <<>>, result, val) do
    Enum.reverse([val|result])
  end

  defp raw_handle_varint(:value, <<bin::bits>>, result, val) do
    raw_decode_varint(bin, [val|result], :key)
  end

  defp raw_handle_varint(:bytes_len, <<bin::bits>>, result, len) do
    <<bytes::bytes-size(len), rest::bits>> = bin
    raw_decode_key(rest, [bytes|result])
  end

  defp raw_handle_varint(:packed, <<>>, result, val) do
    [val|result]
  end

  defp raw_handle_varint(:packed, <<bin::bits>>, result, val) do
    raw_decode_varint(bin, [val|result], :packed)
  end

  defp raw_decode_value(wire_varint(), <<bin::bits>>, result) do
    # raw_decode_varint(bin, result, :value, {0, 0})
    raw_decode_varint(bin, result, :value)
  end

  defp raw_decode_value(wire_delimited(), <<bin::bits>>, result) do
    # raw_decode_varint(bin, result, :bytes_len, {0, 0})
    raw_decode_varint(bin, result, :bytes_len)
  end

  defp raw_decode_value(wire_32bits(), <<n::32, rest::bits>>, result) do
    raw_decode_key(rest, [<<n::32>>|result])
    # raw_decode_key(rest, [n|result])
  end

  defp raw_decode_value(wire_64bits(), <<n::64, rest::bits>>, result) do
    raw_decode_key(rest, [<<n::64>>|result])
  end

  # packed
  defp put_packed_field(msg, %{wire_type: wire_type, type: type, name_atom: key}, val) do
    vals = decode_packed(wire_type, val, [])
    |> Enum.map(fn v ->
      decode_type_m(type, key, v)
    end)

    case msg do
      %{^key => nil} ->
        Map.put(msg, key, vals)

      %{^key => value} ->
        Map.put(msg, key, vals ++ value)

      %{} ->
        Map.put(msg, key, vals)
    end
  end

  defp decode_packed(_wire_type, <<>>, acc), do: acc
  defp decode_packed(wire_varint(), <<bin::bits>>, _) do
    raw_decode_varint(bin, [], :packed)
  end

  defp decode_packed(wire_32bits(), <<n::32, rest::bits>>, result) do
    decode_packed(wire_32bits(), rest, [<<n::32>>|result])
  end

  defp decode_packed(wire_64bits(), <<n::64, rest::bits>>, result) do
    decode_packed(wire_64bits(), rest, [<<n::64>>|result])
  end

  @spec find_field(MessageProps.t(), integer) :: {atom, FieldProps.t()} | {atom} | false
  def find_field(_, tag) when tag < 0 do
    raise DecodeError, message: "decoded tag is less than 0"
  end

  def find_field(props, tag) when is_integer(tag) do
    case props do
      %{tags_map: %{^tag => _field_num}, field_props: %{^tag => prop}} -> {:field_num, prop}
      %{extendable?: true} -> {:extention}
      _ -> {:field_num, %FieldProps{}}
    end
  end

  @spec class_field(FieldProps.t(), integer) :: atom | {:error, String.t()}
  def class_field(%{wire_type: wire_delimited(), embedded?: true}, wire_delimited()) do
    :embedded
  end

  def class_field(%{wire_type: wire}, wire) do
    :normal
  end

  def class_field(%{repeated?: true, packed?: true}, wire_delimited()) do
    :packed
  end

  def class_field(%{wire_type: wire}, _) when is_nil(wire) do
    :unknown_field
  end

  def class_field(%{wire_type: wire_type} = prop, wire) do
    {:error, "wrong wire_type for #{prop_display(prop)}: got #{wire}, want #{wire_type}"}
  end

  @spec decode_zigzag(integer) :: integer
  def decode_zigzag(n) when band(n, 1) == 0, do: bsr(n, 1)
  def decode_zigzag(n) when band(n, 1) == 1, do: -bsr(n + 1, 1)

  defp prop_display(prop) do
    prop.name
  end

  defp reverse_repeated(msg, []), do: msg
  defp reverse_repeated(msg, [h | t]) do
    case msg do
      %{^h => val} when is_list(val) ->
        reverse_repeated(Map.put(msg, h, Enum.reverse(val)), t)

      _ ->
        reverse_repeated(msg, t)
    end
  end

  defp oneof_field(%{oneof: oneof}, %{oneof: oneofs}) do
    {field, ^oneof} = Enum.at(oneofs, oneof)
    field
  end
end
