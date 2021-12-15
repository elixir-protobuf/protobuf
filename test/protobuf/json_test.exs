defmodule Protobuf.JSONTest do
  use ExUnit.Case, async: true
  doctest Protobuf.JSON

  alias TestMsg.Scalars

  test "encodes proto2 structs" do
    assert Protobuf.JSON.encode!(%TestMsg.Foo2{b: 10}) == ~S|{"b":"10"}|
  end

  test "encoding string field with invalid UTF-8 data" do
    message = Scalars.new!(string: "   \xff   ")
    assert {:error, %Jason.EncodeError{}} = Protobuf.JSON.encode(message)
  end

  test "decoding string field with invalid UTF-8 data" do
    json = ~S|{"string":"   \xff   "}|
    assert {:error, %Jason.DecodeError{}} = Protobuf.JSON.decode(json, Scalars)
  end

  describe "bang variants of encode and decode" do
    test "decode!/2" do
      json = ~S|{"string":"   \xff   "}|

      assert_raise Jason.DecodeError, fn ->
        Protobuf.JSON.decode!(json, Scalars)
      end
    end
  end
end
