defmodule Protobuf.Decoder.DecodeVarintTest do
  use ExUnit.Case, async: true
  import Bitwise, only: [band: 2]

  alias Protobuf.Decoder

  test "decode_varint 300" do
    {n, _} = Decoder.decode_varint(<<0b1010110000000010::16>>)
    assert n == 300
  end

  test "decode_varint 150" do
    {n, rest} = Decoder.decode_varint(<<8, 150, 01>>)
    assert n == 8
    {n, _} = Decoder.decode_varint(rest)
    assert n == 150
  end

  test "decode_varint zero value(int, bool, enum)" do
    {n, rest} = Decoder.decode_varint(<<>>)
    assert n == 0
    assert rest == ""
  end

  test "decode_varint+decode_type min int32" do
    {_, rest} = Decoder.decode_varint(<<8, 128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>)
    {n, _} = Decoder.decode_varint(rest)
    <<n::signed-32>> = <<n::32>>
    assert n == -2_147_483_648
    t = band(n, 7)
    {n1, _} = Decoder.decode_type(:int32, t, rest)
    assert n == n1
  end

  test "decode_varint max int32" do
    {_, rest} = Decoder.decode_varint(<<8, 255, 255, 255, 255, 7>>)
    {n, _} = Decoder.decode_varint(rest)
    assert n == 2_147_483_647
  end

  test "decode_varint+decode_type min int64" do
    {_, rest} = Decoder.decode_varint(<<8, 128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>)
    {n, _} = Decoder.decode_varint(rest)
    <<n::signed-64>> = <<n::64>>
    assert n == -9_223_372_036_854_775_808
    t = band(n, 7)
    {n1, _} = Decoder.decode_type(:int64, t, rest)
    assert n == n1
  end

  test "decode_varint max int64" do
    {_, rest} = Decoder.decode_varint(<<8, 255, 255, 255, 255, 255, 255, 255, 255, 127>>)
    {n, _} = Decoder.decode_varint(rest)
    assert n == 9_223_372_036_854_775_807
  end

  test "decode_varint max uint32" do
    {_, rest} = Decoder.decode_varint(<<8, 255, 255, 255, 255, 15>>)
    {n, _} = Decoder.decode_varint(rest)
    assert n == 4_294_967_295
  end

  test "decode_varint max uint64" do
    {_, rest} = Decoder.decode_varint(<<8, 255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>)
    {n, _} = Decoder.decode_varint(rest)
    assert n == 18_446_744_073_709_551_615
  end

  test "decode_varint true/enum_1" do
    {_, rest} = Decoder.decode_varint(<<8, 1>>)
    {n, _} = Decoder.decode_varint(rest)
    assert n == 1
  end
end
