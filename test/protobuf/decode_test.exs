defmodule Protobuf.DecoderTest do
  use ExUnit.Case, async: true

  alias Protobuf.Decoder

  defmodule Foo do
    use Protobuf

    defstruct [:a, :b, :c, :d]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :fixed64
    field :c, 3, optional: true, type: :string
    field :d, 5, optional: true, type: :fixed32
  end

  test "only one field" do
    struct = Decoder.decode(<<8, 42>>, Foo)
    assert struct == %Protobuf.DecoderTest.Foo{a: 42}
  end

  test "full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Protobuf.DecoderTest.Foo{a: 42, b: 100, c: "str", d: 123}
  end

  test "skip fields" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 123, 0, 0, 0>>
    struct = Decoder.decode(bin, Foo)
    assert struct == %Protobuf.DecoderTest.Foo{a: 42, c: "str", d: 123}
  end
end
