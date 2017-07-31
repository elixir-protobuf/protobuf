defmodule Protobuf.EncoderTest do
  use ExUnit.Case, async: true

  alias Protobuf.Encoder

  defmodule Foo.Bar do
    use Protobuf

    defstruct [:a, :b]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :string
  end

  defmodule EnumFoo do
    use Protobuf, enum: true

    field :A, 1
    field :B, 2
    field :C, 4
  end

  defmodule MapFoo do
    use Protobuf, map: true

    defstruct [:key, :value]
    field :key, 1, optional: true, type: :string
    field :value, 2, optional: true, type: :int32
  end

  defmodule Foo do
    use Protobuf

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :fixed64
    field :c, 3, optional: true, type: :string
    # 4 is skipped for testing
    field :d, 5, optional: true, type: :fixed32
    field :e, 6, optional: true, type: Foo.Bar
    field :f, 7, optional: true, type: :int32
    field :g, 8, repeated: true, type: :int32
    field :h, 9, repeated: true, type: Foo.Bar
    field :i, 10, repeated: true, type: :int32, packed: true
    field :j, 11, optional: true, type: EnumFoo, enum: true
    field :k, 12, optioanl: true, type: :bool
    field :l, 13, repeated: true, type: MapFoo, map: true
  end

  test "encodes one simple field" do
    bin = Encoder.encode(%Foo{a: 42})
    assert bin == <<8, 42>>
  end

  test "encodes full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    res = Encoder.encode(%Foo{a: 42, b: 100, c: "str", d: 123})
    assert res == bin
  end

  test "skips a known fields" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    res = Encoder.encode(%Foo{a: 42, c: "str", d: 123})
    assert res == bin
  end

  # test "raises for wrong type field" do
  #   assert_raise(Protobuf.DecodeError, "wrong field for a: got 1, want 0", fn ->
  #     Encoder.encode(<<9, 42, 0, 0, 0, 0, 0, 0, 0>>, Foo)
  #   end)
  # end

  test "encodes embedded message" do
    bin = Encoder.encode(%Foo{a: 42, e: %Foo.Bar{a: 12, b: "abc"}, f: 13})
    assert bin == <<8, 42, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13>>
  end

  test "encodes repeated varint fields" do
    bin = Encoder.encode(%Foo{a: 123, g: [12, 13, 14]})
    assert bin == <<8, 123, 64, 12, 64, 13, 64, 14>>
  end

  test "encodes repeated embedded fields" do
    bin = <<74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13>>
    res = Encoder.encode(%Foo{h: [%Foo.Bar{a: 12, b: "abc"}, %Foo.Bar{a: 13}]})
    assert res == bin
  end

  test "encodes packed fields" do
    bin = Encoder.encode(%Foo{i: [12, 13, 14]})
    assert bin == <<82, 3, 12, 13, 14>>
  end

  test "encodes enum type" do
    bin = Encoder.encode(%Foo{j: 2})
    assert bin == <<88, 2>>
  end

  test "encodes unknown enum type" do
    bin = Encoder.encode(%Foo{j: 3})
    assert bin == <<88, 3>>
  end

  test "encodes 0" do
    assert Encoder.encode(%Foo{a: 0}) == <<>>
    assert Encoder.encode(%Foo{b: 0}) == <<>>
  end

  test "encodes empty string" do
    assert Encoder.encode(%Foo{c: ""}) == <<>>
  end

  test "encodes bool" do
    assert Encoder.encode(%Foo{k: false}) == <<>>
    assert Encoder.encode(%Foo{k: true}) == <<96, 1>>
  end

  test "encode map type" do
    struct = %Foo{l: %{"foo_key" => 213}}
    assert Encoder.encode(struct) == <<106, 12, 10, 7, 102, 111, 111, 95, 107, 101, 121, 16, 213, 1>>
  end
end
