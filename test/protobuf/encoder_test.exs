Code.require_file("../support/test_msg.ex", __DIR__)
defmodule Protobuf.EncoderTest do
  use ExUnit.Case, async: true

  alias Protobuf.Encoder

  test "encodes one simple field" do
    bin = Encoder.encode(TestMsg.Foo.new(a: 42))
    assert bin == <<8, 42, 17, 5, 0, 0, 0, 0, 0, 0, 0, 112, 2>>
  end

  test "encodes full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66, 112, 2>>
    res = Encoder.encode(TestMsg.Foo.new(a: 42, b: 100, c: "str", d: 123.5))
    assert res == bin
  end

  test "skips a field with default value" do
    bin = <<8, 42, 17, 5, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66, 112, 2>>
    res = Encoder.encode(TestMsg.Foo.new(a: 42, c: "str", d: 123.5))
    assert res == bin
  end

  test "skips a field without default value" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 0, 247, 66, 112, 2>>
    res = Encoder.encode(TestMsg.Foo.new(a: 42, b: 100, d: 123.5))
    assert res == bin
  end

  test "encodes embedded message" do
    bin = Encoder.encode(TestMsg.Foo.new(a: 42, e: %TestMsg.Foo.Bar{a: 12, b: "abc"}, f: 13))
    assert bin == <<8, 42, 17, 5, 0, 0, 0, 0, 0, 0, 0, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13, 112, 2>>
  end

  test "encodes repeated varint fields" do
    bin = Encoder.encode(TestMsg.Foo.new(a: 123, g: [12, 13, 14]))
    assert bin == <<8, 123, 17, 5, 0, 0, 0, 0, 0, 0, 0, 64, 12, 64, 13, 64, 14, 112, 2>>
  end

  test "encodes repeated varint fields with all 0" do
    bin = Encoder.encode(TestMsg.Foo.new(g: [0, 0, 0]))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 64, 0, 64, 0, 64, 0, 112, 2>>
  end

  test "encodes repeated embedded fields" do
    bin = <<17, 5, 0, 0, 0, 0, 0, 0, 0, 74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13, 112, 2>>
    res = Encoder.encode(TestMsg.Foo.new(h: [%TestMsg.Foo.Bar{a: 12, b: "abc"}, TestMsg.Foo.Bar.new(a: 13)]))
    assert res == bin
  end

  test "encodes repeated embedded fields with all empty struct" do
    bin = Encoder.encode(TestMsg.Foo.new(h: [TestMsg.Foo.Bar.new(), TestMsg.Foo.Bar.new()]))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 74, 0, 74, 0, 112, 2>>
  end

  test "encodes packed fields" do
    bin = Encoder.encode(TestMsg.Foo.new(i: [12, 13, 14]))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 82, 3, 12, 13, 14, 112, 2>>
  end

  test "encodes packed fields with all 0" do
    bin = Encoder.encode(TestMsg.Foo.new(i: [0, 0, 0]))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 112, 2>>
  end

  test "encodes enum type" do
    bin = Encoder.encode(TestMsg.Foo.new(j: 2))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 88, 2, 112, 2>>
  end

  test "encodes unknown enum type" do
    bin = Encoder.encode(TestMsg.Foo.new(j: 3))
    assert bin == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 88, 3, 112, 2>>
  end

  test "encodes 0" do
    assert Encoder.encode(TestMsg.Foo.new(a: 0)) == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 112, 2>>
    assert Encoder.encode(TestMsg.Foo.new(b: 0)) == <<112, 2>>
  end

  test "encodes empty string" do
    assert Encoder.encode(TestMsg.Foo.new(c: "")) == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 112, 2>>
  end

  test "encodes bool" do
    assert Encoder.encode(TestMsg.Foo.new(k: false)) == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 112, 2>>
    assert Encoder.encode(TestMsg.Foo.new(k: true)) == <<17, 5, 0, 0, 0, 0, 0, 0, 0, 96, 1, 112, 2>>
  end

  test "encode map type" do
    bin = <<17, 5, 0, 0, 0, 0, 0, 0, 0, 106, 12, 10, 7, 102, 111, 111, 95, 107, 101, 121, 16, 213, 1, 112, 2>>
    struct = TestMsg.Foo.new(l: %{"foo_key" => 213})
    assert Encoder.encode(struct) == bin
  end
end
