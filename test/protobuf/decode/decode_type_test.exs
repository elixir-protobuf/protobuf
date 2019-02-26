defmodule Protobuf.Decoder.DecodeTypeTest do
  use ExUnit.Case, async: true

  require Logger
  import Protobuf.Decoder

  def decode_type(type, val) do
    decode_type_m(type, :fake_key, val)
  end

  test "decode_type/2 varint" do
    assert 42 == decode_type(:int32, 42)
  end

  test "decode_type/2 int64" do
    assert -1 == decode_type(:int64, -1)
  end

  test "decode_type/2 string" do
    assert "a" = decode_type(:string, "a")
  end

  test "decode_type/3 min sint32" do
    assert -2_147_483_648 == decode_type(:sint32, 4294967295)
  end

  test "decode_type/3 max sint32" do
    assert 2_147_483_647 == decode_type(:sint32, 4294967294)
  end

  test "decode_type/3 min sint64" do
    assert -9_223_372_036_854_775_808 == decode_type(:sint64, 18446744073709551615)
  end

  test "decode_type/3 max sint64" do
    assert 9_223_372_036_854_775_807 == decode_type(:sint64, 18446744073709551614)
  end

  test "decode_type/3 bool works" do
    assert true == decode_type(:bool, 1)
    assert false == decode_type(:bool, 0)
  end

  test "decode_type/3 a fixed64" do
    assert 8_446_744_073_709_551_615 == decode_type(:fixed64, <<255, 255, 23, 118, 251, 220, 56, 117>>)
  end

  test "decode_type/3 max fixed64" do
    assert 18_446_744_073_709_551_615 == decode_type(:fixed64, <<255, 255, 255, 255, 255, 255, 255, 255>>)
  end

  test "decode_type/3 min sfixed64" do
    assert -9_223_372_036_854_775_808 == decode_type(:sfixed64, <<0, 0, 0, 0, 0, 0, 0, 128>>)
  end

  test "decode_type/3 max sfixed64" do
    assert 9_223_372_036_854_775_807 == decode_type(:sfixed64, <<255, 255, 255, 255, 255, 255, 255, 127>>)
  end

  test "decode_type/3 min double" do
    assert 5.0e-324 == decode_type(:double, <<1, 0, 0, 0, 0, 0, 0, 0>>)
  end

  test "decode_type/3 max double" do
    assert 1.7976931348623157e308 == decode_type(:double, <<255, 255, 255, 255, 255, 255, 239, 127>>)
  end

  test "decode_type/3 string" do
    assert "testing" == decode_type(:string, <<116, 101, 115, 116, 105, 110, 103>>)
  end

  test "decode_type/3 bytes" do
    assert <<42, 43, 44, 45>> == decode_type(:bytes, <<42, 43, 44, 45>>)
  end

  test "decode_type/3 fixed32" do
    assert 4_294_967_295 == decode_type(:fixed32, <<255, 255, 255, 255>>)
  end

  test "decode_type/3 sfixed32" do
    assert 2_147_483_647 == decode_type(:sfixed32, <<255, 255, 255, 127>>)
  end

  test "decode_type/3 float" do
    assert 3.4028234663852886e38 == decode_type(:float, <<255, 255, 127, 127>>)
  end
end
