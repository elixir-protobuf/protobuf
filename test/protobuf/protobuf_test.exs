defmodule Protobuf.ProtobufTest do
  use ExUnit.Case, async: false
  import Protobuf, only: [is_protobuf_message: 1]

  test "load_extensions/0 is a noop" do
    assert loaded_extensions() == 19
    Protobuf.load_extensions()
    assert loaded_extensions() == 19
  end

  describe "encode/1" do
    test "encodes a struct" do
      bin = Protobuf.encode(%TestMsg.Foo{a: 42})
      assert bin == <<8, 42>>
    end

    test "encodes a struct with proto3 optional field" do
      bin = Protobuf.encode(%TestMsg.Proto3Optional{b: "A"})
      assert bin == <<18, 1, 65>>
    end
  end

  describe "encode_to_iodata/1" do
    test "encodes a struct as iodata" do
      iodata = Protobuf.encode_to_iodata(%TestMsg.Foo{a: 42})
      assert IO.iodata_to_binary(iodata) == <<8, 42>>
    end
  end

  describe "decode/2" do
    test "decodes a struct" do
      struct = Protobuf.decode(<<8, 42>>, TestMsg.Foo)
      assert struct == %TestMsg.Foo{a: 42}
    end
  end

  describe "get_unknown_fields/1" do
    test "returns a list of decoded unknown varints" do
      input = <<168, 31, 1>>
      message = ProtobufTestMessages.Proto3.TestAllTypesProto3.decode(input)
      assert Protobuf.get_unknown_fields(message) == [{501, _wire_varint = 0, 1}]
    end

    test "raises if the given struct doesn't have an :__unknown_fields__ field" do
      assert_raise ArgumentError, ~r/can't retrieve unknown fields for struct URI/, fn ->
        Protobuf.get_unknown_fields(%URI{})
      end
    end
  end

  describe "is_protobuf_message/1" do
    test "returns true for protobuf message structs" do
      message = %TestMsg.Foo{a: 42}
      assert is_protobuf_message(message)
    end

    test "returns false for non-protobuf structs" do
      refute is_protobuf_message(%URI{})
    end

    test "returns false for non-structs" do
      refute is_protobuf_message(%{})
      refute is_protobuf_message("string")
      refute is_protobuf_message(42)
      refute is_protobuf_message(nil)
    end

    test "works in pattern matching" do
      message = %TestMsg.Foo{a: 42}

      result =
        case message do
          %{__protobuf__: true} -> :protobuf
          _ -> :not_protobuf
        end

      assert result == :protobuf
    end

    test "works in guards" do
      message = %TestMsg.Foo{a: 42}
      assert check_protobuf_with_guard(message) == true
      assert check_protobuf_with_guard(%URI{}) == false
    end
  end

  defp check_protobuf_with_guard(value) when is_protobuf_message(value), do: true
  defp check_protobuf_with_guard(_), do: false

  defp loaded_extensions do
    Enum.count(:persistent_term.get(), &match?({{Protobuf.Extension, _, _}, _}, &1))
  end
end
