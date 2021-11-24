ExUnit.start()

defmodule Protobuf.ConformanceRegressionsTest do
  use ExUnit.Case

  @tag :skip
  test "Required.Proto3.ProtobufInput.UnknownVarint.ProtobufOutput" do
    payload = octets_to_binary(~S(\250\037\001))

    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    assert payload |> message_type.decode() |> message_type.encode() == payload
  end

  @tag :skip
  test "Required.Proto3.ProtobufInput.ValidDataMap.STRING.MESSAGE.MergeValue.ProtobufOutput" do
    payload =
      octets_to_binary(
        ~S(\272\004\013\n\000\022\007\022\005\010\001\370\001\001\272\004\013\n\000\022\007\022\005\020\001\370\001\001)
      )

    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    assert %_{} = message_type.decode(payload)
  end

  @tag :skip
  test "Required.Proto3.ProtobufInput.IllegalZeroFieldNum_Case_0" do
    payload = octets_to_binary(~S(\001)) <> "DEADBEEF"
    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    assert_raise Protobuf.DecodeError, fn ->
      message_type.decode(payload)
    end
  end

  @tag :skip
  test "Required.Proto3.ProtobufInput.ValidDataOneof.MESSAGE.MultipleValuesForSameField.ProtobufOutput" do
    payload = octets_to_binary(~S(\202\007\000\202\007\003\010\322))
    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")
    message_type.decode(payload)
  end

  @tag :skip
  test "Required.Proto3.ProtobufInput.ValidDataRepeated.SINT32.PackedInput.ProtobufOutput" do
    payload =
      octets_to_binary(
        ~S(\232\002\023\000\362\300\001\376\377\377\377\017\377\377\377\377\017\202\200\200\200\020)
      )

    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")
    assert payload |> message_type.decode() |> message_type.encode() == 1
  end

  @tag :skip
  test "foo" do
    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    "{\"optionalValue\": null}"
    |> Protobuf.JSON.decode!(message_type)
    |> IO.inspect(limit: :infinity)
    |> Protobuf.JSON.encode!()
    |> IO.inspect()
  end

  @tag :skip
  test "bar" do
    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    "{\"optionalNullValue\": null}"
    |> Protobuf.JSON.decode!(message_type)
    |> IO.inspect(limit: :infinity)
    |> Protobuf.JSON.encode!()
    |> IO.inspect()
  end

  test "baz" do
    message_type = to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3")

    "{\n        \"repeatedValue\": [[\"a\"]]\n      }"
    |> Protobuf.JSON.decode!(message_type)
    |> IO.inspect(limit: :infinity)
    |> Protobuf.encode()
    |> IO.inspect()
  end

  defp to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3"),
    do: ProtobufTestMessages.Proto3.TestAllTypesProto3

  defp to_test_proto_type("protobuf_test_messages.proto2.TestAllTypesProto2"),
    do: ProtobufTestMessages.Proto2.TestAllTypesProto2

  defp to_test_proto_type("conformance.FailureSet"), do: Conformance.FailureSet
  defp to_test_proto_type(""), do: ProtobufTestMessages.Proto3.TestAllTypesProto3

  defp octets_to_binary(octets) do
    octets
    |> String.replace("\\n", "")
    |> String.split("\\", trim: true)
    |> Enum.map(&Integer.parse(&1, 8))
    |> Enum.map(fn {number, ""} -> number end)
    |> IO.iodata_to_binary()
  end
end
