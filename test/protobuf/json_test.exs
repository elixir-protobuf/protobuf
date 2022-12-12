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

  describe "to_encodable/2" do
    test "validates options" do
      assert_raise ArgumentError, ~r"option :use_proto_names must be a boolean", fn ->
        Protobuf.JSON.to_encodable(%TestMsg.Foo2{b: 10}, use_proto_names: :no_bool)
      end

      assert_raise ArgumentError, "unknown option: :unknown_opt", fn ->
        Protobuf.JSON.to_encodable(%TestMsg.Foo2{b: 10}, unknown_opt: 1)
      end

      assert_raise ArgumentError, "invalid element in options list: :bad_value", fn ->
        Protobuf.JSON.to_encodable(%TestMsg.Foo2{b: 10}, [:bad_value])
      end
    end
  end

  test "going back and forth with the Any type" do
    data = """
    {
      "optionalAny": {
        "@type": "type.googleapis.com/protobuf_test_messages.proto3.TestAllTypesProto3",
        "optionalInt32": 12345
      }
    }
    """

    assert {:ok, decoded} =
             Protobuf.JSON.decode(data, ProtobufTestMessages.Proto3.TestAllTypesProto3)

    assert %Google.Protobuf.Any{} = decoded.optional_any
    assert decoded.optional_any.type_url =~ "TestAllTypesProto3"

    assert Protobuf.JSON.to_encodable(decoded) == {:ok, Jason.decode!(data)}
  end
end
