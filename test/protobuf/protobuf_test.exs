defmodule Protobuf.ProtobufTest do
  use ExUnit.Case, async: false

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

  defp loaded_extensions do
    Enum.count(:persistent_term.get(), &match?({{Protobuf.Extension, _, _}, _}, &1))
  end
end
