defmodule Protobuf.Decoder do
  import Protobuf.WireTypes
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  require Logger

  @max_bits 64
  @mask64 bsl(1, @max_bits) - 1

  alias Protobuf.{DecodeError, MessageProps, FieldProps}

  @spec decode(binary, atom) :: any
  def decode(data, module) when is_atom(module) do
    do_decode(data, module.__message_props__(), module.new)
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
    key = x |> bsl(n) |> Kernel.+(acc) |> band(@mask64)
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

  defp reverse_repeated(msg, [h | t]) do
    case msg do
      %{^h => val} when is_list(val) ->
        reverse_repeated(%{msg | h => Enum.reverse(val)}, t)

      _ ->
        reverse_repeated(msg, t)
    end
  end

  defp reverse_repeated(msg, []), do: msg

  defp oneof_field(field_props, msg_props) do
    index = field_props.oneof
    {field, ^index} = Enum.at(msg_props.oneof, index)
    field
  end
end
