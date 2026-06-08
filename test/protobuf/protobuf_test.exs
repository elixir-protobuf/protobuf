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

  describe "field_presence/2" do
    test "returns presence for proto3 scalar fields" do
      assert Protobuf.field_presence(%TestMsg.Foo{a: 42}, :a) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{a: 0}, :a) == :maybe
      assert Protobuf.field_presence(%TestMsg.Foo{}, :a) == :maybe

      assert Protobuf.field_presence(%TestMsg.Foo{c: "value"}, :c) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{c: ""}, :c) == :maybe

      assert Protobuf.field_presence(%TestMsg.Foo{k: true}, :k) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{k: false}, :k) == :maybe
    end

    test "returns presence for proto3 optional fields" do
      assert Protobuf.field_presence(%TestMsg.Proto3Optional{a: 0}, :a) == :present
      assert Protobuf.field_presence(%TestMsg.Proto3Optional{a: nil}, :a) == :not_present
      assert Protobuf.field_presence(%TestMsg.Proto3Optional{c: :UNKNOWN}, :c) == :present
      assert Protobuf.field_presence(%TestMsg.Proto3Optional{c: nil}, :c) == :not_present
    end

    test "returns presence for embedded fields" do
      assert Protobuf.field_presence(%TestMsg.Foo{e: %TestMsg.Foo.Bar{}}, :e) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{e: nil}, :e) == :not_present
    end

    test "returns presence for repeated fields and maps" do
      assert Protobuf.field_presence(%TestMsg.Foo{g: [0]}, :g) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{g: []}, :g) == :maybe

      assert Protobuf.field_presence(%TestMsg.Foo{l: %{"key" => 0}}, :l) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{l: %{}}, :l) == :maybe
    end

    test "returns presence for oneof fields" do
      assert Protobuf.field_presence(%TestMsg.OneofProto3{first: {:a, 0}}, :a) == :present
      assert Protobuf.field_presence(%TestMsg.OneofProto3{first: {:b, ""}}, :a) == :not_present
      assert Protobuf.field_presence(%TestMsg.OneofProto3{first: nil}, :a) == :not_present
      assert Protobuf.field_presence(%TestMsg.Oneof{first: {:e, :A}}, :e) == :present
    end

    test "returns presence for proto2 fields" do
      assert Protobuf.field_presence(%TestMsg.Foo2{a: 0}, :a) == :present
      assert Protobuf.field_presence(%TestMsg.Foo2{}, :a) == :not_present

      assert Protobuf.field_presence(%TestMsg.Foo2{b: 5}, :b) == :maybe
      assert Protobuf.field_presence(%TestMsg.Foo2{b: 0}, :b) == :present

      assert Protobuf.field_presence(%TestMsg.Foo2{c: ""}, :c) == :present
      assert Protobuf.field_presence(%TestMsg.Foo2{c: nil}, :c) == :not_present
    end

    test "returns presence for enum fields" do
      assert Protobuf.field_presence(%TestMsg.Foo{j: :UNKNOWN}, :j) == :maybe
      assert Protobuf.field_presence(%TestMsg.Foo{j: :A}, :j) == :present
      assert Protobuf.field_presence(%TestMsg.Foo{j: 0}, :j) == :maybe
      assert Protobuf.field_presence(%TestMsg.Foo{j: 1}, :j) == :present

      assert Protobuf.field_presence(%TestMsg.EnumFoo2{a: 0}, :a) == :present
    end

    test "uses transform modules for embedded fields" do
      assert Protobuf.field_presence(%TestMsg.ContainsTransformModule{field: 0}, :field) ==
               :present

      assert Protobuf.field_presence(%TestMsg.ContainsTransformModule{field: nil}, :field) ==
               :not_present

      assert Protobuf.field_presence(
               %TestMsg.ContainsIntegerStringTransformModule{field: "42"},
               :field
             ) == :present

      assert Protobuf.field_presence(
               %TestMsg.ContainsIntegerStringTransformModule{field: "0"},
               :field
             ) == :maybe
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
      classify = fn value ->
        case value do
          %{__protobuf__: true} -> :protobuf
          _ -> :not_protobuf
        end
      end

      assert classify.(%TestMsg.Foo{a: 42}) == :protobuf
      assert classify.(%URI{}) == :not_protobuf
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
