defmodule Protobuf.TextTest do
  use ExUnit.Case, async: true

  alias Protobuf.Text

  test "default fields aren't encoded" do
    # proto3
    assert "" == Text.encode(%TestMsg.Foo{})

    # proto2
    assert "a: 1" == Text.encode(%TestMsg.Foo2{a: 1})
  end

  test "encoding basic types" do
    assert ~S(a: 1, b: "foo") == Text.encode(%TestMsg.Foo.Bar{a: 1, b: "foo"})
  end

  test "encoding enums" do
    assert ~S(j: D) == Text.encode(%TestMsg.Foo{j: :D})
  end

  test "encoding repeated" do
    assert ~S(g: [1, 2, 3, 4, 5, 6]) == Text.encode(%TestMsg.Foo{g: [1, 2, 3, 4, 5, 6]})
  end

  test "encoding large repeated breaks lines" do
    result = Text.encode(%TestMsg.Foo{a: 1, g: List.duplicate(1_111_111_111, 7), j: :D})

    assert result == """
           a: 1
           g: [
             1111111111,
             1111111111,
             1111111111,
             1111111111,
             1111111111,
             1111111111,
             1111111111
           ]
           j: D\
           """
  end

  test "encoding nested structs" do
    result = Text.encode(%TestMsg.Foo{e: nil})
    assert result == ~S()

    result = Text.encode(%TestMsg.Foo{e: %TestMsg.Foo.Bar{}})
    assert result == ~S(e: {})

    result = Text.encode(%TestMsg.Foo{e: %TestMsg.Foo.Bar{a: 1, b: "Hello"}})

    assert result == ~S(e: {a: 1, b: "Hello"})
  end

  test "encoding large nested structs" do
    result =
      Text.encode(%TestMsg.Foo{
        a: 1,
        e: %TestMsg.Foo.Bar{a: 1, b: String.duplicate("Hello", 15)},
        h: [
          %TestMsg.Foo.Bar{a: 5},
          %TestMsg.Foo.Bar{a: 1, b: String.duplicate("Hello", 15)},
          %TestMsg.Foo.Bar{a: 7}
        ]
      })

    assert result == """
           a: 1
           e: {
             a: 1,
             b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
           }
           h: [
             {a: 5},
             {
               a: 1,
               b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
             },
             {a: 7}
           ]\
           """
  end

  test "respects max line width option" do
    input = %TestMsg.Foo{
      a: 1,
      e: %TestMsg.Foo.Bar{a: 1, b: String.duplicate("Hello", 15)},
      h: [
        %TestMsg.Foo.Bar{a: 5, b: "hi"},
        %TestMsg.Foo.Bar{a: 1, b: String.duplicate("Hello", 15)},
        %TestMsg.Foo.Bar{a: 7}
      ]
    }

    result_with_large_limit = Text.encode(input, max_line_width: 1000)

    assert result_with_large_limit == """
           a: 1, \
           e: {\
           a: 1, \
           b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"\
           }, \
           h: [\
           {a: 5, b: "hi"}, \
           {\
           a: 1, \
           b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"\
           }, \
           {a: 7}\
           ]\
           """

    result_with_small_limit = Text.encode(input, max_line_width: 10)

    assert result_with_small_limit == """
           a: 1
           e: {
             a: 1,
             b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
           }
           h: [
             {
               a: 5,
               b: "hi"
             },
             {
               a: 1,
               b: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
             },
             {a: 7}
           ]\
           """
  end

  test "encoding oneofs" do
    assert "a: 50" == Text.encode(%TestMsg.Oneof{first: {:a, 50}})
  end

  test "encoding maps" do
    assert ~S(l: [{key: "a", value: 1}, {key: "b", value: 2}]) ==
             Text.encode(%TestMsg.Foo{l: %{"a" => 1, "b" => 2}})
  end

  test "raises on absent proto2 required" do
    assert_raise RuntimeError, "field :a is required", fn ->
      Text.encode(%TestMsg.Foo2{})
    end
  end
end
