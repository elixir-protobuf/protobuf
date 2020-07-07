defmodule Protobuf.Encoder.DecodeVarintTest do
  use ExUnit.Case, async: true

  alias Protobuf.Encoder

  test "encode_varint 300" do
    assert Encoder.encode_varint(300) == <<0b1010110000000010::16>>
  end

  test "encode_varint 150" do
    assert Encoder.encode_varint(150) == <<150, 1>>
  end

  test "encode_varint 0" do
    assert Encoder.encode_varint(0) == <<0>>
  end

  test "encode_varint/2 min int32" do
    assert Encoder.encode_varint(-2_147_483_648) ==
             <<128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>
  end

  test "encode_varint max int32" do
    assert Encoder.encode_varint(2_147_483_647) == <<255, 255, 255, 255, 7>>
  end

  test "encode_varint/2 min int64" do
    assert Encoder.encode_varint(-9_223_372_036_854_775_808) ==
             <<128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>
  end

  test "encode_varint max int64" do
    assert Encoder.encode_varint(9_223_372_036_854_775_807) ==
             <<255, 255, 255, 255, 255, 255, 255, 255, 127>>
  end

  test "encode_varint max uint32" do
    assert Encoder.encode_varint(4_294_967_295) == <<255, 255, 255, 255, 15>>
  end

  test "encode_varint max uint64" do
    assert Encoder.encode_varint(18_446_744_073_709_551_615) ==
             <<255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>
  end
end
