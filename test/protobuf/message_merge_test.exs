defmodule Protobuf.MessageMergeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3

  @max_runs 5

  property "the latest scalar value takes precedence if it's not the default" do
    fields_with_gen = [
      {:optional_int32, integer(-10..10), _default = 0},
      {:optional_double, float(), _default = 0.0},
      {:optional_string, string(:printable), _default = ""},
      {:optional_bytes, binary(), _default = <<>>}
    ]

    for {field, gen, default} <- fields_with_gen do
      check all val1 <- gen,
                val2 <- gen,
                val2 != default,
                max_runs: @max_runs do
        msg1 = struct!(TestAllTypesProto3, [{field, val1}])
        msg2 = struct!(TestAllTypesProto3, [{field, val2}])

        decoded = concat_and_decode([msg1, msg2])

        assert Map.fetch!(decoded, field) == val2
      end
    end
  end

  property "repeated fields are concatenated" do
    check all list1 <- list_of(integer()),
              list2 <- list_of(integer()),
              max_runs: @max_runs do
      msg1 = %TestAllTypesProto3{repeated_int32: list1}
      msg2 = %TestAllTypesProto3{repeated_int32: list2}

      decoded = concat_and_decode([msg1, msg2])

      assert decoded.repeated_int32 == list1 ++ list2
    end
  end

  # TODO
  # property "map fields are merged"

  @tag :skip
  test "oneof fields with the same tag are merged"

  test "the latest oneof field takes precedence if the two have different tags" do
    msg1 = %TestAllTypesProto3{oneof_field: {:oneof_nested_message, %TestAllTypesProto3{}}}
    msg2 = %TestAllTypesProto3{oneof_field: {:oneof_string, "foo"}}

    decoded = concat_and_decode([msg1, msg2])

    assert decoded.oneof_field == {:oneof_string, "foo"}
  end

  describe "nested messages" do
  end

  defp concat_and_decode(messages) do
    messages
    |> Enum.map_join("", &Protobuf.encode/1)
    |> Protobuf.decode(TestAllTypesProto3)
  end
end
