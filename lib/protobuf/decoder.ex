defmodule Protobuf.Decoder do
  import Protobuf.WireTypes
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  require Logger

  @max_bits 64
  @mask64 bsl(1, @max_bits) - 1

  alias Protobuf.{DecodeError, MessageProps, FieldProps}

  @spec decode(binary, atom) :: any
  def decode2(data, module) when is_atom(module) do
    do_decode(data, module.__message_props__(), module.new)
  end

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
          val = case type do
            :int32 ->
              <<n::signed-integer-32>> = <<val::32>>
              n
            :string -> val
            :bytes -> val
            :int64 ->
              <<n::signed-integer-64>> = <<val::64>>
            :uint32 -> val
            :uint64 -> val
            :bool -> val != 0
            :sint32 -> decode_zigzag(val)
            :sint64 -> decode_zigzag(val)
            :fixed64 ->
              <<n::little-64>> = val
              n
            :sfixed64 ->
              <<n::little-signed-64>> =val
              n
            :double ->
              <<n::little-float-64>> = val
              n
            :fixed32 ->
              <<n::little-32>> = val
              n
            :sfixed32 ->
              <<n::little-signed-32>> = val
              n
            :float ->
              <<n::little-float-32>> = val
              n
            {:enum, enum_type} ->
              try do
                enum_type.key(val)
              rescue
                FunctionClauseError ->
                  Logger.warn("unknown enum value #{val} when decoding for #{inspect(type)}")
                  val
              end
            _ ->
              raise DecodeError, message: "can't decode type #{type} for field #{key}"
          end
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


  defp raw_decode_key(<<>>, result), do: Enum.reverse(result)
  # defp raw_decode_key(<<bin::bits>>, result), do: raw_decode_varint(bin, result, :key, {0, 0})
  defp raw_decode_key(<<bin::bits>>, result), do: raw_decode_varint2(bin, result, :key)

  # defp raw_decode_varint(<<1::1, x::7, rest::bits>>, result, type, {n, acc}) when n < @max_bits - 7 do
  #   raw_decode_varint(rest, result, type, {n + 7, bsl(x, n) + acc})
  # end

  # defp raw_decode_varint(<<0::1, x::7, rest::bits>>, result, type, {n, acc}) do
  #   val = x |> bsl(n) |> Kernel.+(acc)
  #   raw_handle_varint(type, rest, result, val)
  # end

  defp raw_decode_varint2(<<0::1, x::7, rest::bits>>, result, type) do
    raw_handle_varint(type, rest, result, x)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            0::1, x1::7, rest::bits>>, result, type) do
    # <<val::14>> = <<x1::7, x0::7>>
    val = bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            0::1, x2::7, rest::bits>>, result, type) do
    <<val::21>> = <<x2::7, x1::7, x0::7>>
    # val = bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            0::1, x3::7, rest::bits>>, result, type) do
    # <<val::28>> = <<x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            0::1, x4::7, rest::bits>>, result, type) do
    # <<val::35>> = <<x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            0::1, x5::7, rest::bits>>, result, type) do
    # <<val::42>> = <<x5::7, x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            0::1, x6::7, rest::bits>>, result, type) do
    # <<val::49>> = <<x6::7, x5::7, x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            0::1, x7::7, rest::bits>>, result, type) do
    # <<val::56>> = <<x7::8, x6::7, x5::7, x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            1::1, x7::7,
                            0::1, x8::7, rest::bits>>, result, type) do
    # <<val::63>> = <<x8::7, x7::7, x6::7, x5::7, x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x8, 56) +bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val)
  end

  defp raw_decode_varint2(<<1::1, x0::7,
                            1::1, x1::7,
                            1::1, x2::7,
                            1::1, x3::7,
                            1::1, x4::7,
                            1::1, x5::7,
                            1::1, x6::7,
                            1::1, x7::7,
                            1::1, x8::7,
                            0::1, x9::7, rest::bits>>, result, type) do
    # <<val::64>> = <<x9::7, x8::7, x7::7, x6::7, x5::7, x4::7, x3::7, x2::7, x1::7, x0::7>>
    val = bsl(x9, 63) + bsl(x8, 56) +bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    val = band(val, @mask64)
    # val = bsl(x9, 63) + bsl(x8, 56) +bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
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
    raw_decode_varint2(bin, [val|result], :key)
  end

  defp raw_handle_varint(:bytes_len, <<bin::bits>>, result, len) do
    <<bytes::bytes-size(len), rest::bits>> = bin
    raw_decode_key(rest, [bytes|result])
  end

  defp raw_handle_varint(:packed, <<>>, result, val) do
    [val|result]
  end

  defp raw_handle_varint(:packed, <<bin::bits>>, result, val) do
    raw_decode_varint2(bin, [val|result], :packed)
  end

  defp raw_decode_value(wire_varint(), <<bin::bits>>, result) do
    # raw_decode_varint(bin, result, :value, {0, 0})
    raw_decode_varint2(bin, result, :value)
  end

  defp raw_decode_value(wire_delimited(), <<bin::bits>>, result) do
    # raw_decode_varint(bin, result, :bytes_len, {0, 0})
    raw_decode_varint2(bin, result, :bytes_len)
  end

  defp raw_decode_value(wire_32bits(), <<n::32, rest::bits>>, result) do
    raw_decode_key(rest, [<<n::32>>|result])
    # raw_decode_key(rest, [n|result])
  end

  defp raw_decode_value(wire_64bits(), <<n::64, rest::bits>>, result) do
    raw_decode_key(rest, [<<n::64>>|result])
  end

  @max_pos_int32 (bsl(1, 31) - 1)
  @max_pos_int64 (bsl(1, 63) - 1)

  @spec decode_type2(atom, binary) :: {binary, binary}
  def decode_type2(:int32, val) when val < @max_pos_int32, do: val
  def decode_type2(:int32, val) do
    <<n::signed-integer-32>> = <<val::32>>
    n
  end
  def decode_type2(:string, val), do: val
  def decode_type2(:bytes, val), do: val
  def decode_type2(:int64, val) when val < @max_pos_int64, do: val
  def decode_type2(:int64, val) do
    <<n::signed-integer-64>> = <<val::64>>
    n
  end
  def decode_type2(:uint32, val), do: val
  def decode_type2(:uint64, val), do: val
  def decode_type2(:bool, val), do: val != 0
  def decode_type2(:sint32, val), do: decode_zigzag(val)
  def decode_type2(:sint64, val), do: decode_zigzag(val)
  def decode_type2(:fixed64, <<n::little-64>>), do: n
  def decode_type2(:sfixed64, <<n::little-signed-64>>), do: n
  def decode_type2(:double, <<n::little-float-64>>), do: n
  def decode_type2(:fixed32, <<n::little-32>>), do: n
  def decode_type2(:sfixed32, <<n::little-signed-32>>), do: n
  def decode_type2(:float, <<n::little-float-32>>), do: n
  def decode_type2({:enum, type}, val) do
    try do
      type.key(val)
    rescue
      FunctionClauseError ->
        Logger.warn("unknown enum value #{val} when decoding for #{inspect(type)}")
        val
    end
  end
  def decode_type2(t, _) do
    raise DecodeError, message: "can't decode #{t}"
  end

  @spec do_decode(binary, MessageProps.t(), struct) :: any
  defp do_decode(bin, props, msg) when is_binary(bin) and byte_size(bin) > 0 do
    {key, rest} = decode_varint(bin)
    tag = bsr(key, 3)
    wire_type = band(key, 7)
    # TODO: handle EndGroup
    case find_field(props, tag) do
      {:field_num, prop} ->
        case class_field(prop, wire_type) do
          type when type in [:normal, :embedded, :packed] ->
            %{type: prop_type, oneof: oneof} = prop
            {val, rest} = decode_type(type_to_decode(type, prop_type), wire_type, rest)
            field_key = if oneof, do: oneof_field(prop, props), else: prop.name_atom
            new_msg = put_field(type, msg, prop, field_key, val)
            do_decode(rest, props, new_msg)

          {:error, error_msg} ->
            raise DecodeError, message: "#{inspect(msg.__struct__)}: " <> error_msg

          :unknown_field ->
            {_, rest} = decode_type(wire_type, rest)
            do_decode(rest, props, msg)
        end

      {:extention} ->
        msg

      {:oneof} ->
        msg
    end
  end

  defp do_decode(<<>>, %{repeated_fields: repeated_fields}, msg) do
    reverse_repeated(msg, repeated_fields)
  end

  defp type_to_decode(:normal, prop_type), do: prop_type
  defp type_to_decode(:embedded, _), do: :bytes
  defp type_to_decode(:packed, _), do: :bytes

  # embedded
  defp put_field2(
         msg,
         %{map?: is_map, type: type, oneof: oneof, repeated?: is_repeated, embedded?: true} = prop,
         key,
         val
       ) do
    embedded_msg = decode(val, type)
    val = if is_map, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
    val = if oneof, do: {prop.name_atom, val}, else: val

    case msg do
      %{^key => nil} ->
        val = if is_repeated, do: [val], else: val
        Map.put(msg, key, val)

      %{^key => value} ->
        val = if is_repeated, do: [val|value], else: Map.merge(value, val)
        Map.put(msg, key, val)

      %{} ->
        val = if is_repeated, do: [val], else: val
        Map.put(msg, key, val)
    end
  end

  # others
  defp put_field2(msg, %{oneof: oneof, repeated?: is_repeated, type: prop_type} = prop, key, val) do
    # val = decode_type2(prop_type, val)
    val = if oneof, do: {prop.name_atom, val}, else: val

    case msg do
      %{^key => nil} ->
        val = if is_repeated, do: [val], else: val
        Map.put(msg, key, val)

      %{^key => value} ->
        val = if is_repeated, do: [val|value], else: val
        Map.put(msg, key, val)

      %{} ->
        val = if is_repeated, do: [val], else: val
        Map.put(msg, key, val)
    end
  end

  # packed
  defp put_packed_field(msg, %{wire_type: wire_type, type: type, name_atom: key}, val) do
    vals = decode_packed2(wire_type, val, [])
    |> Enum.map(&decode_type2(type, &1))

    case msg do
      %{^key => nil} ->
        Map.put(msg, key, vals)

      %{^key => value} ->
        Map.put(msg, key, vals ++ value)

      %{} ->
        Map.put(msg, key, vals)
    end
  end

  defp decode_packed2(_wire_type, <<>>, acc), do: acc
  defp decode_packed2(wire_varint(), <<bin::bits>>, _) do
    raw_decode_varint2(bin, [], :packed)
  end

  defp decode_packed2(wire_32bits(), <<n::32, rest::bits>>, result) do
    decode_packed2(wire_32bits(), rest, [<<n::32>>|result])
  end

  defp decode_packed2(wire_64bits(), <<n::64, rest::bits>>, result) do
    decode_packed2(wire_64bits(), rest, [<<n::64>>|result])
  end

  defp put_field(:normal, msg, %{oneof: oneof, repeated?: is_repeated} = prop, field_key, val) do
    val = if oneof, do: {prop.name_atom, val}, else: val

    put_map(msg, field_key, val, fn _k, v1, v2 ->
      merge_same_fields(v1, v2, is_repeated, fn -> v2 end)
    end)
  end

  defp put_field(
         :embedded,
         msg,
         %{map?: is_map, type: type, oneof: oneof, repeated?: is_repeated} = prop,
         field_key,
         val
       ) do
    embedded_msg = decode(val, type)
    decoded = if is_map, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
    decoded = if oneof, do: {prop.name_atom, decoded}, else: decoded

    new_msg =
      put_map(msg, field_key, decoded, fn _k, v1, v2 ->
        merge_same_fields(v1, v2, is_repeated, fn ->
          if v1, do: Map.merge(v1, v2), else: v2
        end)
      end)

    new_msg
  end

  defp put_field(:packed, msg, %{type: type, oneof: oneof} = prop, field_key, val) do
    vals = decode_packed(type, Protobuf.Encoder.wire_type(type), val)
    vals = if oneof, do: {prop.name_atom, vals}, else: vals

    new_msg =
      put_map(msg, field_key, vals, fn _k, v1, v2 ->
        if v1, do: v2 ++ v1, else: v2
      end)

    struct(new_msg)
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

  # decode_type/2 can only be used to parse unknown fields with no type detail
  @spec decode_type(integer, binary) :: {binary, binary}
  def decode_type(wire_varint(), bin) do
    decode_varint(bin)
  end

  def decode_type(wire_64bits(), bin) do
    <<n::64, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(wire_delimited(), bin) do
    {len, rest} = decode_varint(bin)
    <<str::binary-size(len), rest2::binary>> = rest
    {str, rest2}
  end

  def decode_type(wire_32bits(), bin) do
    <<n::32, rest::binary>> = bin
    {n, rest}
  end

  @spec decode_type(atom, integer, binary) :: {binary, binary}
  def decode_type(:int32, wire_varint(), bin) do
    {n, rest} = decode_varint(bin)
    <<n::signed-integer-32>> = <<n::32>>
    {n, rest}
  end

  def decode_type(:int64, wire_varint(), bin) do
    {n, rest} = decode_varint(bin)
    <<n::signed-integer-64>> = <<n::64>>
    {n, rest}
  end

  def decode_type(:uint32, wire_varint(), bin), do: decode_varint(bin)
  def decode_type(:uint64, wire_varint(), bin), do: decode_varint(bin)

  def decode_type(:sint32, wire_varint(), bin) do
    {n, rest} = decode_varint(bin)
    {decode_zigzag(n), rest}
  end

  def decode_type(:sint64, wire_varint(), bin) do
    {n, rest} = decode_varint(bin)
    {decode_zigzag(n), rest}
  end

  def decode_type(:bool, wire_varint(), bin) do
    {n, rest} = decode_varint(bin)
    {n != 0, rest}
  end

  def decode_type({:enum, type}, wire_varint(), bin) do
    {n, rest} = decode_type(:int32, wire_varint(), bin)

    val =
      try do
        type.key(n)
      rescue
        FunctionClauseError ->
          Logger.warn("unknown enum value #{n} when decoding for #{inspect(type)}")
          n
      end

    {val, rest}
  end

  def decode_type(:fixed64, wire_64bits(), bin) do
    <<n::little-64, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(:sfixed64, wire_64bits(), bin) do
    <<n::little-signed-64, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(:double, wire_64bits(), bin) do
    <<n::little-float-64, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(:bytes, wire_delimited(), bin) do
    {len, rest} = decode_varint(bin)
    <<str::binary-size(len), rest2::binary>> = rest
    {str, rest2}
  end

  def decode_type(:string, wire_delimited(), bin) do
    decode_type(:bytes, wire_delimited(), bin)
  end

  def decode_type(:fixed32, wire_32bits(), bin) do
    <<n::little-32, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(:sfixed32, wire_32bits(), bin) do
    <<n::little-signed-32, rest::binary>> = bin
    {n, rest}
  end

  def decode_type(:float, wire_32bits(), bin) do
    <<n::little-float-32, rest::binary>> = bin
    {n, rest}
  end

  @spec decode_packed(atom, integer, binary) :: list
  def decode_packed(field_type, wire_type, bin) do
    decode_packed(field_type, wire_type, bin, [])
  end

  @spec decode_packed(atom, integer, binary, list) :: list
  def decode_packed(_, _, <<>>, acc), do: acc

  def decode_packed(field_type, wire_type, bin, acc) do
    {val, rest} = decode_type(field_type, wire_type, bin)
    decode_packed(field_type, wire_type, rest, [val | acc])
  end

  @spec decode_zigzag(integer) :: integer
  def decode_zigzag(n) when band(n, 1) == 0, do: bsr(n, 1)
  def decode_zigzag(n) when band(n, 1) == 1, do: -bsr(n + 1, 1)

  @spec decode_varint(binary) :: {number, binary}
  def decode_varint(<<>>), do: {0, <<>>}
  def decode_varint(bin), do: decode_varint(bin, 0, 0)

  defp decode_varint(<<>>, 0, 0), do: {0, <<>>}

  defp decode_varint(<<1::1, x::7, rest::binary>>, n, acc) when n < @max_bits - 7 do
    decode_varint(rest, n + 7, bsl(x, n) + acc)
  end

  defp decode_varint(<<0::1, x::7, rest::binary>>, n, acc) do
    key = x |> bsl(n) |> Kernel.+(acc)
    {key, rest}
  end

  defp prop_display(prop) do
    prop.name
  end

  defp put_map(map, key, val, func) do
    case map do
      %{^key => old_val} ->
        Map.put(map, key, func.(key, old_val, val))

      _ ->
        Map.put(map, key, val)
    end
  end

  defp merge_same_fields(v1, v2, repeated, func) do
    if repeated do
      if v1, do: [v2 | v1], else: [v2]
    else
      func.()
    end
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
