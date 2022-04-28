defmodule Protobuf.BuilderTest do
  use ExUnit.Case, async: true

  alias TestMsg.{Foo, Foo2, Link, ContainsTransformModule}

  test "new/2 uses default values for proto3" do
    assert Foo.new().a == 0
    assert Foo.new().c == ""
    assert Foo.new().e == nil
  end

  test "new/2 use nil for proto2" do
    assert Foo2.new().a == nil
    assert Foo2.new().c == nil
    assert Foo2.new().e == nil
  end

  test "works for circular reference" do
    assert TestMsg.Parent.new().child == nil
  end

  test "new/2 build embedded messages" do
    assert Foo.new(e: %{a: 1}).e == Foo.Bar.new(a: 1)
    assert Foo.new(h: [%{a: 1}]).h == [Foo.Bar.new(a: 1)]
  end

  test "new/2 build nested embedded messages" do
    link = Link.new(child: Link.new(child: Link.new(child: Link.new(value: 2))))
    assert Link.new(child: %{child: %{child: %{value: 2}}}) == link
  end

  test "new/2 doesn't build embedded messages for nil & map" do
    assert Foo.new(e: nil).e == nil
    assert Foo.new(%{}).e == nil
    assert Foo.new(l: %{"k" => 1}).l == %{"k" => 1}
  end

  test "new/2 raises an error for non-list repeated embedded msgs" do
    assert_raise Protocol.UndefinedError,
                 ~r/protocol Enumerable not implemented for %TestMsg.Foo.Bar/,
                 fn ->
                   Foo.new(h: Foo.Bar.new())
                 end
  end

  test "new/2 doesn't process struct" do
    msg = %Foo{}
    assert msg == Foo.new(msg)
  end

  test "new!/2 raises for fields that don't exist in the schema" do
    assert_raise KeyError, fn ->
      Foo.new!(nonexisting_field: "foo")
    end
  end

  test "new!/2 raises for non matched struct" do
    assert_raise ArgumentError, fn ->
      Foo.new!(Foo2.new())
    end
  end

  test "new/2 build correct message for non matched struct" do
    foo = Foo.new(Foo2.new(non_matched: 1))

    assert_raise Protobuf.EncodeError, fn ->
      Foo.encode(foo)
    end
  end

  test "new/2 ignores structs with transform modules" do
    assert ContainsTransformModule.new(field: 123) == %ContainsTransformModule{field: 123}
  end
end
