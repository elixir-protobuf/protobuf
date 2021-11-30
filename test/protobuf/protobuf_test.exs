defmodule Protobuf.ProtobufTest do
  use ExUnit.Case, async: false

  test "load_extensions/0 is a noop" do
    Protobuf.load_extensions()
    assert loaded_extensions() == 13
    assert loaded_extensions() == 13
  end

  describe "encode/1" do
    test "encodes a struct" do
      bin = Protobuf.encode(TestMsg.Foo.new(a: 42))
      assert bin == <<8, 42>>
    end
  end

  describe "encode/2" do
    test "encodes a struct as iodata with iolist: true" do
      iodata = Protobuf.encode(TestMsg.Foo.new(a: 42), iolist: true)
      assert IO.iodata_to_binary(iodata) == <<8, 42>>
    end

    test "raises an ArgumentError if the :iolist option is invalid" do
      assert_raise ArgumentError, ~r/expected bool/, fn ->
        Protobuf.encode(TestMsg.Foo.new(), iolist: :not_a_boolean)
      end
    end
  end

  describe "decode/2" do
    test "decodes a struct" do
      struct = Protobuf.decode(<<8, 42>>, TestMsg.Foo)
      assert struct == TestMsg.Foo.new(a: 42)
    end
  end

  defp loaded_extensions do
    Enum.count(:persistent_term.get(), &match?({{Protobuf.Extension, _, _}, _}, &1))
  end
end
