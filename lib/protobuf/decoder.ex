defmodule Protobuf.Decoder do
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  @mask64 bsl(1, 64) - 1

  alias Protobuf.{DecodeError, FieldProps}

  @wire_varint       0
  @wire_64bits       1
  @wire_bytes        2
  @wire_start_group  3
  @wire_end_group    4
  @wire_32bits       5

  @spec decode(binary, atom) :: any
  def decode(data, module) when is_atom(module) do
    decode(data, module.__message_props__(), struct(module, %{}))
  end

  @spec decode(binary, MessageProps.t, struct) :: any
  defp decode(bin, props, msg) when is_binary(bin) and byte_size(bin) > 0 do
    {key, rest} = decode_varint(bin)
    tag = bsr(key, 3)
    wire_type = band(key, 7)
    # TODO: handle EndGroup
    case find_field(props, tag) do
      {:field_num, prop} ->
        case class_field(prop, wire_type) do
          :normal ->
            {val, rest} = decode_type(prop.type, wire_type, rest)
            new_msg = struct(msg, [{prop.name_atom, val}])
            decode(rest, props, new_msg)
          :packed ->
            {}
          {:error, msg} -> raise DecodeError, message: msg
        end
      {:extention} ->
        {}
      {:oneof} ->
        {}
      _ -> {}
    end
  end
  defp decode(<<>>, _, msg) do
    msg
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
       _ -> false
    end
  end

  @spec class_field(FieldProps.t, integer) :: atom | {:error, String.t}
  def class_field(%{wire_type: wire_type, packed_dec: packed_dec} = prop, wire)
      when wire != @wire_start_group and wire != wire_type do
    cond do
      wire == wire_type && packed_dec -> :packed
      true ->
        {:error, "bad wiretype for #{prop_display(prop)}: got #{wire}, want #{wire_type}"}
    end
  end
  def class_field(%{wire_type: wire}, wire) do
    :normal
  end
  def class_field(prop, wire) do
    {:error, "unknown field for #{prop_display(prop)}: got #{wire}, want #{prop.wire_type}"}
  end

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
  def decode_type(:string, @wire_bytes, bin) do
    {len, rest} = decode_varint(bin)
    <<str::binary-size(len), rest2::binary>> = rest
    {str, rest2}
  end
  def decode_type(:bytes, @wire_bytes, bin) do
    decode_type(:string, @wire_bytes, bin)
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
end
