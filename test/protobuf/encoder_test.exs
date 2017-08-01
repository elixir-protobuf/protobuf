Code.require_file("../support/test_msg.ex", __DIR__)
defmodule Protobuf.EncoderTest do
  use ExUnit.Case, async: true

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

  test "skips a known fields" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66>>
    res = Encoder.encode(%TestMsg.Foo{a: 42, c: "str", d: 123.5})
    assert res == bin
  end

  test "encodes embedded message" do
    bin = Encoder.encode(%TestMsg.Foo{a: 42, e: %TestMsg.Foo.Bar{a: 12, b: "abc"}, f: 13})
    assert bin == <<8, 42, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13>>
  end

  test "encodes repeated varint fields" do
    bin = Encoder.encode(%TestMsg.Foo{a: 123, g: [12, 13, 14]})
    assert bin == <<8, 123, 64, 12, 64, 13, 64, 14>>
  end

  test "encodes repeated embedded fields" do
    bin = <<74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13>>
    res = Encoder.encode(%TestMsg.Foo{h: [%TestMsg.Foo.Bar{a: 12, b: "abc"}, %TestMsg.Foo.Bar{a: 13}]})
    assert res == bin
  end

  test "encodes packed fields" do
    bin = Encoder.encode(%TestMsg.Foo{i: [12, 13, 14]})
    assert bin == <<82, 3, 12, 13, 14>>
  end

  test "encodes enum type" do
    bin = Encoder.encode(%TestMsg.Foo{j: 2})
    assert bin == <<88, 2>>
  end

  test "encodes unknown enum type" do
    bin = Encoder.encode(%TestMsg.Foo{j: 3})
    assert bin == <<88, 3>>
  end

  test "encodes 0" do
    assert Encoder.encode(%TestMsg.Foo{a: 0}) == <<>>
    assert Encoder.encode(%TestMsg.Foo{b: 0}) == <<>>
  end

  test "encodes empty string" do
    assert Encoder.encode(%TestMsg.Foo{c: ""}) == <<>>
  end

  test "encodes bool" do
    assert Encoder.encode(%TestMsg.Foo{k: false}) == <<>>
    assert Encoder.encode(%TestMsg.Foo{k: true}) == <<96, 1>>
  end

  test "encode map type" do
    struct = %TestMsg.Foo{l: %{"foo_key" => 213}}
    assert Encoder.encode(struct) == <<106, 12, 10, 7, 102, 111, 111, 95, 107, 101, 121, 16, 213, 1>>
  end
end
