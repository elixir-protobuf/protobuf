defmodule Protobuf.Decoder.DecodeVarintTest do
  use ExUnit.Case, async: true

  import Protobuf.Decoder

  test "decode_varint 300" do
    assert [300] == decode_varint(<<0b1010110000000010::16>>, :value)
  end

  test "decode_varint 150" do
    assert [1, 0, 150] == decode_varint(<<8, 150, 01>>)
  end

  test "decode_varint zero value(int, bool, enum)" do
    assert [] == decode_raw(<<>>)
  end

  test "decode_varint+decode_type min int32" do
    assert [1, 0, val = 18446744071562067968] == decode_varint(<<8, 128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>)
    assert -2_147_483_648 == decode_type2(:int32, val)
  end

  test "decode_varint max int32" do
    [1, 0, 2_147_483_647] = decode_varint(<<8, 255, 255, 255, 255, 7>>)
  end

  test "decode_varint+decode_type min int64" do
    [1, 0, val] = decode_varint(<<8, 128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>)
    assert -9_223_372_036_854_775_808 == decode_type2(:int64, val)
  end

  test "decode_varint max int64" do
    [1, 0, val] = decode_varint(<<8, 255, 255, 255, 255, 255, 255, 255, 255, 127>>)
    assert 9_223_372_036_854_775_807 == decode_type2(:int64, val)
  end

  test "decode_varint max uint32" do
    [1, 0, val] = decode_varint(<<8, 255, 255, 255, 255, 15>>)
    assert 4_294_967_295 == decode_type2(:uint32, val)
  end

  test "decode_varint max uint64" do
    [1, 0, val] = decode_varint(<<8, 255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>)
    assert 18_446_744_073_709_551_615 == decode_type2(:uint64, val)
  end

  test "decode_varint true/enum_1" do
    [1, 0, val = 1] = decode_varint(<<8, 1>>)
    assert true === decode_type2(:bool, val)
  end
end
