defmodule Protobuf.Wire do
  @moduledoc false

  alias Protobuf.Wire.{Varint, Zigzag}

  require Logger

  @type proto_type ::
          :int32
          | :int64
          | :fixed32
          | :fixed64
          | :uint32
          | :uint64
          | :sfixed32
          | :sfixed64
          | :sint32
          | :sint64
          | :float
          | :double
          | :bool
          | :string
          | :bytes
          | {:enum, module() | integer()}

  @type proto_float() :: :infinity | :negative_infinity | :nan | float()

  @type proto_value() :: binary() | integer() | boolean() | proto_float() | atom()

  @sint32_range -0x80000000..0x7FFFFFFF
  @sint64_range -0x8000000000000000..0x7FFFFFFFFFFFFFFF
  @uint32_range 0..0xFFFFFFFF
  @uint64_range 0..0xFFFFFFFFFFFFFFFF

  @spec from_proto(proto_type(), proto_value()) :: iodata()
  def from_proto(type, value)

  # Returns improper list, but still valid iodata.
  def from_proto(type, binary) when is_binary(binary) and type in [:string, :bytes] do
    Varint.encode(byte_size(binary)) ++ binary
  end

  def from_proto(:int32, n) when n in @sint32_range, do: Varint.encode(n)
  def from_proto(:int64, n) when n in @sint64_range, do: Varint.encode(n)
  def from_proto(:uint32, n) when n in @uint32_range, do: Varint.encode(n)
  def from_proto(:uint64, n) when n in @uint64_range, do: Varint.encode(n)

  def from_proto(:bool, true), do: Varint.encode(1)
  def from_proto(:bool, false), do: Varint.encode(0)

  def from_proto({:enum, enum_mod}, key) when is_atom(enum_mod) and is_atom(key),
    do: Varint.encode(enum_mod.value(key))

  def from_proto({:enum, enum_mod}, n) when is_atom(enum_mod) and is_integer(n),
    do: Varint.encode(n)

  def from_proto(:float, :infinity), do: [0, 0, 128, 127]
  def from_proto(:float, :negative_infinity), do: [0, 0, 128, 255]
  def from_proto(:float, :nan), do: [0, 0, 192, 127]
  def from_proto(:float, n), do: <<n::32-float-little>>

  def from_proto(:double, :infinity), do: [0, 0, 0, 0, 0, 0, 240, 127]
  def from_proto(:double, :negative_infinity), do: [0, 0, 0, 0, 0, 0, 240, 255]
  def from_proto(:double, :nan), do: [1, 0, 0, 0, 0, 0, 248, 127]
  def from_proto(:double, n), do: <<n::64-float-little>>

  def from_proto(:sint32, n) when n in @sint32_range, do: Varint.encode(Zigzag.encode(n))
  def from_proto(:sint64, n) when n in @sint64_range, do: Varint.encode(Zigzag.encode(n))
  def from_proto(:fixed32, n) when n in @uint32_range, do: <<n::32-little>>
  def from_proto(:fixed64, n) when n in @uint64_range, do: <<n::64-little>>
  def from_proto(:sfixed32, n) when n in @sint32_range, do: <<n::32-signed-little>>
  def from_proto(:sfixed64, n) when n in @sint64_range, do: <<n::64-signed-little>>

  def from_proto(type, value) do
    raise Protobuf.TypeEncodeError,
      message: "#{inspect(value)} is invalid for type #{inspect(type)}"
  end

  @spec to_proto(proto_type(), binary() | integer()) :: proto_value()
  def to_proto(type, value)

  def to_proto(type, val) when type in [:string, :bytes], do: val

  def to_proto(:int32, val) do
    <<n::signed-integer-32>> = <<val::32>>
    n
  end

  def to_proto(:int64, val) do
    <<n::signed-integer-64>> = <<val::64>>
    n
  end

  def to_proto(:uint32, val) do
    <<n::unsigned-integer-32>> = <<val::32>>
    n
  end

  def to_proto(:uint64, val) do
    <<n::unsigned-integer-64>> = <<val::64>>
    n
  end

  def to_proto(:bool, val), do: val != 0

  def to_proto({:enum, enum_mod}, val) when is_atom(enum_mod) and is_integer(val) do
    enum_mod.key(val)
  rescue
    FunctionClauseError ->
      Logger.warn("unknown enum value #{val} when decoding for #{inspect(enum_mod)}")
      val
  end

  def to_proto(:float, <<n::little-float-32>>), do: n
  # little endianness, should be 0b0_11111111_000000000...
  def to_proto(:float, <<0, 0, 0b1000_0000::8, 0b01111111::8>>), do: :infinity
  # little endianness, should be 0b1_11111111_000000000...
  def to_proto(:float, <<0, 0, 0b1000_0000::8, 0b11111111::8>>), do: :negative_infinity
  # should be 0b*_11111111_not_zero...
  def to_proto(:float, <<a::16, 1::1, b::7, _::1, 0b1111111::7>>) when a != 0 or b != 0,
    do: :nan

  def to_proto(:double, <<n::little-float-64>>), do: n
  # little endianness, should be 0b0_11111111111_000000000...
  def to_proto(:double, <<0::48, 0b1111::4, 0::4, 0b01111111::8>>), do: :infinity
  # little endianness, should be 0b1_11111111111_000000000...
  def to_proto(:double, <<0::48, 0b1111::4, 0::4, 0b11111111::8>>), do: :negative_infinity

  def to_proto(:double, <<a::48, 0b1111::4, b::4, _::1, 0b1111111::7>>) when a != 0 or b != 0,
    do: :nan

  def to_proto(type, val) when type in [:sint32, :sint64], do: Zigzag.decode(val)
  def to_proto(:fixed32, <<n::little-32>>), do: n
  def to_proto(:fixed64, <<n::little-64>>), do: n
  def to_proto(:sfixed32, <<n::little-signed-32>>), do: n
  def to_proto(:sfixed64, <<n::little-signed-64>>), do: n

  def to_proto(type, val) do
    raise Protobuf.DecodeError, message: "can't decode #{inspect(val)} into type #{inspect(type)}"
  end
end
