defmodule Protobuf.DecoderTest do
  use ExUnit.Case, async: true

  alias Protobuf.Decoder

  defmodule Foo_Bar do
    use Protobuf

    defstruct [:a, :b]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :string
  end

  defmodule Foo do
    use Protobuf

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :fixed64
    field :c, 3, optional: true, type: :string
    # 4 is skipped for testing
    field :d, 5, optional: true, type: :fixed32
    field :e, 6, optional: true, type: Foo_Bar
    field :f, 7, optional: true, type: :int32
    field :g, 8, repeated: true, type: :int32
    field :h, 9, repeated: true, type: Foo_Bar
    field :i, 10, repeated: true, type: :int32, packed: true
  end

  test "decodes one simple field" do
    struct = Decoder.decode(<<8, 42>>, Foo)
    assert struct == %Foo{a: 42}
  end

  test "decodes full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Foo{a: 42, b: 100, c: "str", d: 123}
  end

  test "skips a known fields" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Foo{a: 42, c: "str", d: 123}
  end

  test "raises for wrong type field" do
    assert_raise(Protobuf.DecodeError, "wrong field for a: got 1, want 0", fn ->
      Decoder.decode(<<9, 42, 0, 0, 0, 0, 0, 0, 0>>, Foo)
    end)
  end

  test "skips unknown varint fields" do
    struct = Decoder.decode(<<8, 42, 32, 100, 45, 123, 0, 0, 0>>, Foo)
    assert struct == %Foo{a: 42, d: 123}
  end

  test "skips unknown string fields" do
    struct = Decoder.decode(<<8, 42, 34, 3, 115, 116, 114, 45, 123, 0, 0, 0>>, Foo)
    assert struct == %Foo{a: 42, d: 123}
  end

  test "decodes embedded message" do
    struct = Decoder.decode(<<8, 42, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13>>, Foo)
    assert struct == %Foo{a: 42, e: %Foo_Bar{a: 12, b: "abc"}, f: 13}
  end

  test "merges singular embedded messages for multiple fields" do
    # %{a: 12} + %{a: 21, b: "abc"}
    bin = <<50, 2, 8, 12, 50, 7, 8, 21, 18, 3, 97, 98, 99>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Foo{e: %Foo_Bar{a: 21, b: "abc"}}
  end

  test "decodes repeated varint fields" do
    struct = Decoder.decode(<<64, 12, 8, 123, 64, 13, 64, 14>>, Foo)
    assert struct == %Foo{a: 123, g: [12, 13, 14]}
  end

  test "decodes repeated embedded fields" do
    bin = <<74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Foo{h: [%Foo_Bar{a: 12, b: "abc"}, %Foo_Bar{a: 13}]}
  end

  test "decodes packed fields" do
    struct = Decoder.decode(<<82, 2, 12, 13>>, Foo)
    assert struct == %Foo{i: [12, 13]}
  end

  test "concat multiple packed fields" do
    struct = Decoder.decode(<<82, 2, 12, 13, 82, 2, 14, 15>>, Foo)
    assert struct == %Foo{i: [12, 13, 14, 15]}
  end
end
