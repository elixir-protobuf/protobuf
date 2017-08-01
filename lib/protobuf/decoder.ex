defmodule Protobuf.Decoder do
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  @mask64 bsl(1, 64) - 1

  alias Protobuf.{DecodeError, MessageProps, FieldProps}

  @wire_varint       0
  @wire_64bits       1
  @wire_delimited    2
  # @wire_start_group  3
  # @wire_end_group    4
  @wire_32bits       5

  @spec decode(binary, atom) :: any
  def decode(data, module, opts \\ []) when is_atom(module) do
    msg = if Keyword.get(opts, :use_default, true), do: module.new, else: struct(module)
    do_decode(data, module.__message_props__(), msg, opts)
  end

  @spec do_decode(binary, MessageProps.t, struct, Keyword) :: any
  defp do_decode(bin, props, msg, opts) when is_binary(bin) and byte_size(bin) > 0 do
    {key, rest} = decode_varint(bin)
    tag = bsr(key, 3)
    wire_type = band(key, 7)
    # TODO: handle EndGroup
    case find_field(props, tag) do
      {:field_num, prop} ->
        case class_field(prop, wire_type) do
          :normal ->
            {val, rest} = decode_type(prop.type, wire_type, rest)
            new_msg = put_map(msg, prop.name_atom, val, fn _k, v1, v2 ->
              merge_same_fields(v1, v2, prop.repeated?, fn -> v2 end)
            end)
            do_decode(rest, props, new_msg, opts)
          :embedded ->
            {val, rest} = decode_type(:bytes, wire_type, rest)
            embedded_msg = decode(val, prop.type, opts)
            decoded = if prop.map?, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
            new_msg = put_map(msg, prop.name_atom, decoded, fn _k, v1, v2 ->
              merge_same_fields(v1, v2, prop.repeated?, fn ->
                if v1, do: Map.merge(v1, v2), else: v2
              end)
            end)
            do_decode(rest, props, struct(new_msg), opts)
          :packed ->
            {val, rest} = decode_type(:bytes, wire_type, rest)
            vals = decode_packed(prop.type, Protobuf.Encoder.wire_type(prop.type), val)
            new_msg = put_map(msg, prop.name_atom, vals, fn _k, v1, v2 ->
              if v1, do: v2 ++ v1, else: v2
            end)
            do_decode(rest, props, struct(new_msg), opts)
          {:error, error_msg} ->
            raise DecodeError, message: "#{inspect(msg.__struct__)}: " <> error_msg
          :unknown_field ->
            {_, rest} = decode_type(wire_type, rest)
            do_decode(rest, props, msg, opts)
        end
      {:extention} ->
        msg
      {:oneof} ->
        msg
    end
  end
  defp do_decode(<<>>, props, msg, _) do
    reverse_repeated(msg, props.repeated_fields)
  end

  @spec find_field(MessageProps.t, integer) :: {atom, FieldProps.t} | {atom} | false
  def find_field(_, tag) when tag < 0 do
    raise DecodeError, message: "decoded tag is less than 0"
  end
  def find_field(props, tag) when is_integer(tag) do
    case props do
       %{tags_map: %{^tag => _field_num}, field_props: %{^tag => prop}} -> {:field_num, prop}
       %{extendable?: true} -> {:extention}
       %{oneof?: true} -> {:oneof}
       _ -> {:field_num, %FieldProps{}}
    end
  end

  @spec class_field(FieldProps.t, integer) :: atom | {:error, String.t}
  def class_field(%{wire_type: @wire_delimited, embedded?: true}, @wire_delimited) do
    :embedded
  end
  def class_field(%{wire_type: wire}, wire) do
    :normal
  end
  def class_field(%{repeated?: true, packed?: true}, @wire_delimited) do
    :packed
  end
  def class_field(%{wire_type: wire}, _) when is_nil(wire) do
    :unknown_field
  end
  def class_field(%{wire_type: wire_type} = prop, wire) do
    {:error, "wrong wire_type for #{prop_display(prop)}: got #{wire}, want #{wire_type}"}
  end

  # decode_type/2 can only be used to parse unknown fields With no type detail
  @spec decode_type(integer, binary) :: {binary, binary}
  def decode_type(@wire_varint, bin) do
    decode_varint(bin)
  end
  def decode_type(@wire_64bits, bin) do
    <<n::64, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(@wire_delimited, bin) do
    {len, rest} = decode_varint(bin)
    <<str::binary-size(len), rest2::binary>> = rest
    {str, rest2}
  end
  def decode_type(@wire_32bits, bin) do
    <<n::32, rest::binary>> = bin
    {n, rest}
  end

  @spec decode_type(atom, integer, binary) :: {binary, binary}
  def decode_type(:int32, @wire_varint, bin) do
    {n, rest} = decode_varint(bin)
    <<n::signed-integer-32>> = <<n::32>>
    {n, rest}
  end
  def decode_type(:int64, @wire_varint, bin) do
    {n, rest} = decode_varint(bin)
    <<n::signed-integer-64>> = <<n::64>>
    {n, rest}
  end
  def decode_type(:uint32, @wire_varint, bin), do: decode_varint(bin)
  def decode_type(:uint64, @wire_varint, bin), do: decode_varint(bin)
  def decode_type(:sint32, @wire_varint, bin) do
    {n, rest} = decode_varint(bin)
    {decode_zigzag(n), rest}
  end
  def decode_type(:sint64, @wire_varint, bin) do
    {n, rest} = decode_varint(bin)
    {decode_zigzag(n), rest}
  end
  def decode_type(:bool, @wire_varint, bin) do
    {n, rest} = decode_varint(bin)
    {n != 0, rest}
  end
  def decode_type(:enum, @wire_varint, bin) do
    decode_type(:int32, @wire_varint, bin)
  end
  def decode_type(:fixed64, @wire_64bits, bin) do
    <<n::little-64, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(:sfixed64, @wire_64bits, bin) do
    <<n::little-signed-64, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(:double, @wire_64bits, bin) do
    <<n::little-float-64, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(:bytes, @wire_delimited, bin) do
    {len, rest} = decode_varint(bin)
    <<str::binary-size(len), rest2::binary>> = rest
    {str, rest2}
  end
  def decode_type(:string, @wire_delimited, bin) do
    decode_type(:bytes, @wire_delimited, bin)
  end
  def decode_type(:fixed32, @wire_32bits, bin) do
    <<n::little-32, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(:sfixed32, @wire_32bits, bin) do
    <<n::little-signed-32, rest::binary>> = bin
    {n, rest}
  end
  def decode_type(:float, @wire_32bits, bin) do
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
    decode_packed(field_type, wire_type, rest, [val|acc])
  end

  @spec decode_zigzag(integer) :: integer
  def decode_zigzag(n) when band(n, 1) == 0, do: bsr(n, 1)
  def decode_zigzag(n) when band(n, 1) == 1, do: -(bsr(n + 1, 1))

  @spec decode_varint(binary) :: {number, binary}
  def decode_varint(<<>>), do: {0, <<>>}
  def decode_varint(bin), do: decode_varint(bin, 64)
  def decode_varint(bin, max_bits), do: decode_varint(bin, 0, 0, max_bits)
  defp decode_varint(<<1::1, x::7, rest::binary>>, n, acc, max_bits) when n < (max_bits - 7) do
    decode_varint(rest, n + 7, bsl(x, n) + acc, max_bits)
  end
  defp decode_varint(<<0::1, x::7, rest::binary>>, n, acc, max_bits) do
    mask = mask(max_bits)
    key = x |> bsl(n) |> Kernel.+(acc) |> band(mask)
    {key, rest}
  end

  defp mask(64) do
    @mask64
  end
  defp mask(max_bits) do
    Bitwise.bsl(1, max_bits) - 1
  end

  defp prop_display(prop) do
    prop.name
  end

  defp put_map(map, key, val, func) when is_function(func, 3) do
    case Map.fetch(map, key) do
      {:ok, old_val} -> Map.put(map, key, func.(key, old_val, val))
      :error         -> Map.put(map, key, val)
    end
  end

  defp merge_same_fields(v1, v2, repeated, func) do
    if repeated do
      if v1, do: [v2|v1], else: [v2]
    else
      func.()
    end
  end

  defp reverse_repeated(msg, [h|t]) do
    case msg do
      %{^h => val} when is_list(val) ->
        reverse_repeated(%{msg | h => Enum.reverse(val)}, t)
      _ -> reverse_repeated(msg, t)
    end
  end
  defp reverse_repeated(msg, []), do: msg
end
