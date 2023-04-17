defmodule Protobuf.EncoderTest do
  use ExUnit.Case, async: true

  import Protobuf.Wire.Types

  alias Protobuf.Encoder

  test "encodes one simple field" do
    bin = Encoder.encode(%TestMsg.Foo{a: 42})
    assert bin == <<8, 42>>
  end

  test "encodes full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66>>
    res = Encoder.encode(%TestMsg.Foo{a: 42, b: 100, c: "str", d: 123.5})
    assert res == bin
  end

  test "skips a field with default value" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66>>
    res = Encoder.encode(%TestMsg.Foo{a: 42, c: "str", d: 123.5})
    assert res == bin
  end

  test "skips a field without default value" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 0, 247, 66>>
    res = Encoder.encode(%TestMsg.Foo{a: 42, b: 100, d: 123.5})
    assert res == bin
  end

  test "encodes embedded message" do
    bin = Encoder.encode(%TestMsg.Foo{a: 42, e: %TestMsg.Foo.Bar{a: 12, b: "abc"}, f: 13})
    assert bin == <<8, 42, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13>>
  end

  test "encodes empty embedded message" do
    bin = Encoder.encode(%TestMsg.Foo{a: 42, e: %TestMsg.Foo.Bar{}})
    assert bin == <<8, 42, 50, 0>>
  end

  test "encodes repeated non-packed varint fields" do
    bin = Encoder.encode(%TestMsg.Foo{a: 123, g: [12, 13, 14]})
    assert bin == <<8, 123, 64, 12, 64, 13, 64, 14>>
  end

  test "encodes repeated varint fields with all 0" do
    bin = Encoder.encode(%TestMsg.Foo{g: [0, 0, 0]})
    assert bin == <<64, 0, 64, 0, 64, 0>>
  end

  test "encodes repeated embedded fields" do
    bin = <<74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13>>

    res =
      Encoder.encode(%TestMsg.Foo{
        h: [%TestMsg.Foo.Bar{a: 12, b: "abc"}, %TestMsg.Foo.Bar{a: 13}]
      })

    assert res == bin
  end

  test "encodes repeated embedded fields with all empty struct" do
    bin = Encoder.encode(%TestMsg.Foo{h: [%TestMsg.Foo.Bar{}, %TestMsg.Foo.Bar{}]})
    assert bin == <<74, 0, 74, 0>>
  end

  test "encodes packed fields" do
    bin = Encoder.encode(%TestMsg.Foo{i: [12, 13, 14]})
    assert bin == <<82, 3, 12, 13, 14>>
  end

  test "encodes packed fields with all 0" do
    bin = Encoder.encode(%TestMsg.Foo{i: [0, 0, 0]})
    assert bin == <<82, 3, 0, 0, 0>>
  end

  test "encodes enum type" do
    bin = Encoder.encode(%TestMsg.Foo{j: 2})
    assert bin == <<88, 2>>
    bin = Encoder.encode(%TestMsg.Foo{j: :A})
    assert bin == <<88, 1>>
    bin = Encoder.encode(%TestMsg.Foo{j: :B})
    assert bin == <<88, 2>>
  end

  test "encodes repeated enum fields using packed by default" do
    bin = Encoder.encode(%TestMsg.Foo{o: [:A, :B]})
    assert bin == <<130, 1, 2, 1, 2>>
  end

  test "encodes unknown enum type" do
    bin = Encoder.encode(%TestMsg.Foo{j: 3})
    assert bin == <<88, 3>>
  end

  test "encodes 0" do
    assert Encoder.encode(%TestMsg.Foo{a: 0}) == <<>>
  end

  test "encodes empty string" do
    assert Encoder.encode(%TestMsg.Foo{c: ""}) == <<>>
  end

  test "encodes bool" do
    assert Encoder.encode(%TestMsg.Foo{k: false}) == <<>>
    assert Encoder.encode(%TestMsg.Foo{k: true}) == <<96, 1>>
  end

  test "encode map type" do
    bin = <<106, 12, 10, 7, 102, 111, 111, 95, 107, 101, 121, 16, 213, 1>>
    struct = %TestMsg.Foo{l: %{"foo_key" => 213}}
    assert Encoder.encode(struct) == bin
  end

  test "encodes 0 for proto2" do
    assert Encoder.encode(%TestMsg.Foo2{a: 0}) == <<8, 0>>
  end

  test "encodes [] for proto2" do
    assert Encoder.encode(%TestMsg.Foo2{a: 0, g: []}) == <<8, 0>>
  end

  test "encodes %{} for proto2" do
    assert Encoder.encode(%TestMsg.Foo2{a: 0, l: %{}}) == <<8, 0>>
  end

  test "encodes custom default message for proto2" do
    assert Encoder.encode(%TestMsg.Foo2{a: 0, b: 0}) == <<8, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0>>
  end

  test "encodes oneof fields" do
    msg = %TestMsg.Oneof{first: {:a, 42}, second: {:d, "abc"}, other: "other"}
    assert Encoder.encode(msg) == <<8, 42, 34, 3, 97, 98, 99, 42, 5, 111, 116, 104, 101, 114>>
    msg = %TestMsg.Oneof{first: {:b, "abc"}, second: {:c, 123}, other: "other"}
    assert Encoder.encode(msg) == <<18, 3, 97, 98, 99, 24, 123, 42, 5, 111, 116, 104, 101, 114>>
  end

  test "encodes oneof fields zero values" do
    # proto2
    # int and string
    msg = %TestMsg.Oneof{first: {:a, 0}, second: {:d, ""}}
    assert Encoder.encode(msg) == <<8, 0, 34, 0>>
    msg = %TestMsg.Oneof{first: {:b, ""}, second: {:c, 0}}
    assert Encoder.encode(msg) == <<18, 0, 24, 0>>
    # enum
    msg = %TestMsg.Oneof{first: {:e, :UNKNOWN}}
    assert Encoder.encode(msg) == <<48, 0>>
    assert TestMsg.Oneof.decode(<<48, 0>>) == msg

    # proto3
    # int and string
    msg = %TestMsg.OneofProto3{first: {:a, 0}, second: {:d, ""}}
    assert Encoder.encode(msg) == <<8, 0, 34, 0>>
    assert TestMsg.OneofProto3.encode(msg) == <<8, 0, 34, 0>>
    msg = %TestMsg.OneofProto3{first: {:b, ""}, second: {:c, 0}}
    assert Encoder.encode(msg) == <<18, 0, 24, 0>>
    assert TestMsg.OneofProto3.encode(msg) == <<18, 0, 24, 0>>
    # enum
    msg = %TestMsg.OneofProto3{first: {:e, :UNKNOWN}}
    assert Encoder.encode(msg) == <<48, 0>>
    assert TestMsg.OneofProto3.decode(<<48, 0>>) == msg
  end

  test "encodes proto3 optional fields zero values" do
    msg = %TestMsg.Proto3Optional{a: 0, c: :UNKNOWN}
    assert Encoder.encode(msg) == <<8, 0, 24, 0>>
  end

  test "skips a proto3 optional field with a nil value" do
    msg = %TestMsg.Proto3Optional{a: nil, c: nil}
    assert Encoder.encode(msg) == <<>>
  end

  test "encodes map with oneof" do
    msg = %Google.Protobuf.Struct{fields: %{"valid" => %{kind: {:bool_value, true}}}}
    bin = Google.Protobuf.Struct.encode(msg)

    assert Google.Protobuf.Struct.decode(bin) ==
             %Google.Protobuf.Struct{
               fields: %{"valid" => %Google.Protobuf.Value{kind: {:bool_value, true}}}
             }
  end

  test "encodes enum default value for proto2" do
    # Includes required
    msg = %TestMsg.EnumBar2{a: 0}
    assert Encoder.encode(msg) == <<8, 0>>

    # Missing required field `:a` occurs a runtime error
    msg = %TestMsg.EnumBar2{}

    assert_raise Protobuf.EncodeError, ~r/Got error when encoding TestMsg.EnumBar2/, fn ->
      Encoder.encode(msg)
    end

    msg = %TestMsg.EnumFoo2{}
    assert Encoder.encode(msg) == <<>>

    # Explicitly set the enum default value should be encoded, should not return it as ""
    msg = %TestMsg.EnumBar2{a: 0}
    assert Encoder.encode(msg) == <<8, 0>>

    msg = %TestMsg.EnumBar2{a: 1}
    assert Encoder.encode(msg) == <<8, 1>>

    msg = %TestMsg.EnumBar2{a: 0, b: 0}
    assert Encoder.encode(msg) == <<8, 0, 16, 0>>

    msg = %TestMsg.EnumBar2{a: 0, b: 1}
    assert Encoder.encode(msg) == <<8, 0, 16, 1>>

    msg = %TestMsg.EnumFoo2{a: 0}
    assert Encoder.encode(msg) == <<8, 0>>

    msg = %TestMsg.EnumFoo2{a: 1}
    assert Encoder.encode(msg) == <<8, 1>>

    msg = %TestMsg.EnumFoo2{b: 0}
    assert Encoder.encode(msg) == <<16, 0>>

    msg = %TestMsg.EnumFoo2{a: 0, b: 1}
    assert Encoder.encode(msg) == <<8, 0, 16, 1>>

    # Proto2 enums that are not zero-based default to their first value declared.
    msg = %My.Test.Request{deadline: nil}
    assert Encoder.encode(msg) == <<>>

    msg = %My.Test.Request{deadline: nil, hat: 1}
    assert Encoder.encode(msg) == <<32, 1>>

    msg = %My.Test.Request{deadline: nil, hat: :FEDORA}
    assert Encoder.encode(msg) == <<>>
  end

  test "encodes oneof fields' default values for proto2" do
    msg = %TestMsg.Oneof{first: {:e, :A}}
    assert Encoder.encode(msg) == <<48, 1>>
    assert TestMsg.Oneof.decode(<<48, 1>>) == msg
  end

  test "encodes unknown fields" do
    msg = %TestMsg.Foo{
      __unknown_fields__: [
        {4, wire_varint(), 100},
        {100, wire_varint(), -1},
        {1001, wire_delimited(), "foo"}
      ],
      a: 42,
      d: 123.5
    }

    assert Encoder.encode(msg) ==
             <<8, 42, 45, 0, 0, 247, 66, 32, 100, 160, 6, 255, 255, 255, 255, 255, 255, 255, 255,
               255, 1, 202, 62, 3, 102, 111, 111>>
  end

  test "raises on invalid UTF-8" do
    assert_raise Protobuf.EncodeError, fn ->
      Encoder.encode(%TestMsg.Scalars{string: <<255>>})
    end
  end

  test "encodes with transformer module" do
    msg = %TestMsg.ContainsTransformModule{field: 0}
    assert Encoder.encode(msg) == <<10, 0>>
    assert TestMsg.ContainsTransformModule.decode(Encoder.encode(msg)) == msg

    msg = %TestMsg.ContainsTransformModule{field: 42}
    assert Encoder.encode(msg) == <<10, 2, 8, 42>>
    assert TestMsg.ContainsTransformModule.decode(Encoder.encode(msg)) == msg
  end

  test "encodes with transformer module when encoding struct contains a transformer module" do
    msg = %TestMsg.ContainsIntegerStringTransformModule{field: "42"}
    assert msg == %TestMsg.ContainsIntegerStringTransformModule{field: "42"}

    encoded = TestMsg.ContainsIntegerStringTransformModule.encode(msg)
    assert encoded == "\b*"

    assert %TestMsg.ContainsIntegerStringTransformModule{field: 42} ==
             TestMsg.ContainsIntegerStringTransformModule.decode(encoded)
  end

  test "encoding skips transformer module when field is not set" do
    msg = %TestMsg.ContainsTransformModule{field: nil}
    assert Encoder.encode(msg) == <<>>
    assert TestMsg.ContainsTransformModule.decode(Encoder.encode(msg)) == msg
  end

  test "NewTransform calls new/2 before encoding" do
    msg = %TestMsg.ContainsNewTransformModule{field: [field: 123]}
    assert msg == %TestMsg.ContainsNewTransformModule{field: [field: 123]}

    assert TestMsg.ContainsNewTransformModule.decode(Encoder.encode(msg)) ==
             %TestMsg.ContainsNewTransformModule{
               field: %TestMsg.WithNewTransformModule{field: 123}
             }
  end
end
