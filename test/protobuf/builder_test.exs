defmodule Protobuf.BuilderTest do
  use ExUnit.Case, async: true

  alias TestMsg.{Foo, Foo2, ContainsTransformModule, Proto3Optional}

  describe "default values for structs" do
    test "for proto3" do
      assert %Foo{}.a == 0
      assert %Foo{}.c == ""
      assert %Foo{}.e == nil
    end

    test "uses nil for proto3 optional field" do
      assert %Proto3Optional{}.a == nil
      assert %Proto3Optional{}.b == ""
    end

    test "uses nil for proto2" do
      assert %Foo2{}.a == nil
      assert %Foo2{}.c == nil
      assert %Foo2{}.e == nil
    end

    test "works for circular reference" do
      assert %TestMsg.Parent{}.child == nil
    end

    test "builds embedded messages" do
      assert %Foo{e: %Foo.Bar{a: 1}}.e == %Foo.Bar{a: 1}
      assert %Foo{h: [%Foo.Bar{a: 1}]}.h == [%Foo.Bar{a: 1}]
    end

    test "new/2 doesn't build embedded messages for nil and maps" do
      assert %Foo{e: nil}.e == nil
      assert %Foo{}.e == nil
      assert %Foo{l: %{"k" => 1}}.l == %{"k" => 1}
    end
  end

  # TODO: remove these tests once we remove new/2.
  describe "new/2" do
    test "doesn't process struct" do
      msg = %Foo{}
      assert msg == Foo.new(msg)
    end

    test "raises an error for non-list repeated embedded msgs" do
      # TODO: remove conditional once we support only Elixir 1.18+
      message =
        if System.version() >= "1.18.0" do
          ~r/protocol Enumerable not implemented for type TestMsg.Foo.Ba/
        else
          ~r/protocol Enumerable not implemented for %TestMsg.Foo.Bar/
        end

      assert_raise Protocol.UndefinedError, message, fn ->
        Foo.new(h: Foo.Bar.new())
      end
    end

    test "builds correct message for non matched struct" do
      foo = Foo.new(Foo2.new(non_matched: 1))

      assert_raise Protobuf.EncodeError, fn ->
        Foo.encode(foo)
      end
    end

    test "ignores structs with transform modules" do
      assert ContainsTransformModule.new(field: 123) == %ContainsTransformModule{field: 123}
    end
  end

  # TODO: remove these tests once we remove new!/2.
  describe "new!/2" do
    test "raises for fields that don't exist in the schema" do
      assert_raise KeyError, fn ->
        Foo.new!(nonexisting_field: "foo")
      end
    end

    test "raises for non-matched struct" do
      assert_raise ArgumentError, fn ->
        Foo.new!(%Foo2{})
      end
    end
  end
end
