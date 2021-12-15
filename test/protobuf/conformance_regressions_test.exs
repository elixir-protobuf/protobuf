defmodule Protobuf.ConformanceRegressionsTest do
  use ExUnit.Case, async: true

  describe "proto3" do
    setup :url_to_message
    setup :decode_conformance_input

    @describetag message_type: "protobuf_test_messages.proto3.TestAllTypesProto3"

    # Issue #218
    @tag conformance_input: ~S(\250\037\001)
    test "Required.Proto3.ProtobufInput.UnknownVarint.ProtobufOutput",
         %{proto_input: proto_input, message_mod: message_mod} do
      assert proto_input |> message_mod.decode() |> message_mod.encode() == proto_input
    end

    @tag conformance_input: ~S(\001DEADBEEF)
    test "Required.Proto3.ProtobufInput.IllegalZeroFieldNum_Case_0",
         %{proto_input: proto_input, message_mod: message_mod} do
      assert_raise Protobuf.DecodeError, fn ->
        message_mod.decode(proto_input)
      end
    end

    @tag conformance_input: ~S{(\202\200\200\200\020}
    test "Required.Proto3.ProtobufInput.ValidDataScalar.SINT32[4].JsonOutput",
         %{proto_input: proto_input, message_mod: message_mod} do
      # Value gets "cast" back to an int32.
      assert message_mod.decode(proto_input).optional_sint32 == 1
    end

    @tag conformance_input:
           ~S{\222\001\014\022\n\010\322\t\020\322\t\370\001\322\t\222\001\014\022\n\010\341!\030\341!\370\001\341!}
    test "Required.Proto3.ProtobufInput.RepeatedScalarMessageMerge.ProtobufOutput",
         %{proto_input: proto_input, message_mod: message_mod} do
      decoded = message_mod.decode(proto_input)

      assert decoded.optional_nested_message.corecursive.repeated_int32 == [1234, 4321]
      assert decoded.optional_nested_message.corecursive.optional_int64 == 1234
    end

    @tag conformance_input: ~S(\202\007\014\022\012\010\001\020\001\310\005\001\310\005\001)
    test "Recommended.Proto3.ProtobufInput.ValidDataOneofBinary.MESSAGE.Merge.ProtobufOutput",
         %{proto_input: proto_input, message_mod: message_mod} do
      assert proto_input |> message_mod.decode() |> message_mod.encode() == proto_input
    end
  end

  describe "proto2" do
    setup :url_to_message
    setup :decode_conformance_input

    @describetag message_type: "protobuf_test_messages.proto2.TestAllTypesProto2"
    @tag conformance_input:
           ~S{\332\002(\000\001\377\377\377\377\377\377\377\377\377\001\316\302\361\005\200\200\200\200 \377\377\377\377\377\377\377\377\177\200\200\200\200\200\200\200\200\200\001}
    test "Recommended.Proto2.ProtobufInput.ValidDataRepeated.BOOL.PackedInput.DefaultOutput.ProtobufOutput",
         %{proto_input: proto_input, message_mod: message_mod} do
      assert message_mod.decode(proto_input).repeated_bool == [
               false,
               true,
               true,
               true,
               true,
               true,
               true
             ]
    end
  end

  describe "JSON" do
    setup :url_to_message

    @describetag message_type: "protobuf_test_messages.proto3.TestAllTypesProto3"

    test "Recommended.Proto3.JsonInput.NullValueInOtherOneofNewFormat.Validator",
         %{message_mod: message_mod} do
      json = "{\"oneofNullValue\": null}"

      assert json
             |> Protobuf.JSON.decode!(message_mod)
             |> Protobuf.JSON.encode!()
             |> Jason.decode!() == Jason.decode!(json)
    end

    test "Recommended.Proto3.JsonInput.NullValueInOtherOneofOldFormat.Validator",
         %{message_mod: message_mod} do
      json = "{\"oneofNullValue\": \"NULL_VALUE\"}"

      assert json
             |> Protobuf.JSON.decode!(message_mod)
             |> Protobuf.JSON.encode!()
             |> Jason.decode!() == %{"oneofNullValue" => nil}
    end
  end

  defp url_to_message(%{message_type: type_url}) do
    case type_url do
      "protobuf_test_messages.proto3.TestAllTypesProto3" ->
        %{message_mod: ProtobufTestMessages.Proto3.TestAllTypesProto3}

      "protobuf_test_messages.proto2.TestAllTypesProto2" ->
        %{message_mod: ProtobufTestMessages.Proto2.TestAllTypesProto2}
    end
  end

  defp decode_conformance_input(%{conformance_input: conformance_input}) do
    %{proto_input: conformance_input_to_binary(conformance_input)}
  end

  defp decode_conformance_input(context) do
    context
  end

  defp conformance_input_to_binary(<<?\\, d1, d2, d3, rest::binary>>)
       when d1 in ?0..?9 and d2 in ?0..?9 and d3 in ?0..?9 do
    integer = Integer.undigits([d1 - ?0, d2 - ?0, d3 - ?0], 8)
    <<integer, conformance_input_to_binary(rest)::binary>>
  end

  defp conformance_input_to_binary(<<?\\, char, rest::binary>>) when char in [?n, ?t, ?r, ?\\] do
    <<escape_char(char), conformance_input_to_binary(rest)::binary>>
  end

  defp conformance_input_to_binary(<<byte, rest::binary>>) do
    <<byte, conformance_input_to_binary(rest)::binary>>
  end

  defp conformance_input_to_binary(<<>>) do
    <<>>
  end

  defp escape_char(?n), do: ?\n
  defp escape_char(?t), do: ?\t
  defp escape_char(?r), do: ?\r
  defp escape_char(?\\), do: ?\\
end
