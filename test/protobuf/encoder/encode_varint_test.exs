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
    assert Encoder.encode_varint(0) == <<>>
  end
end
