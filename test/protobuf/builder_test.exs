defmodule Protobuf.BuilderTest do
  use ExUnit.Case, async: true

  alias TestMsg.{Foo, Foo2, Proto3Optional}

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
  end
end
