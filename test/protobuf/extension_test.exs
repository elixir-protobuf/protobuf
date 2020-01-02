defmodule Protobuf.ExtensionTest do
  use ExUnit.Case, async: true

  alias Protobuf.GlobalStore

  test "extension persistent works" do
    assert TestMsg.Ext.PbExtension = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo1, :foo}, nil)
    assert TestMsg.Ext.PbExtension = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo2, :bar}, nil)
    assert TestMsg.Ext.PbExtension = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo2, :"Parent.foo"}, nil)
  end

  test "extension get/put work" do
    assert %{__pb_extensions__: %{foo: "foo"}} = TestMsg.Ext.Foo1.put_extension(%{}, :foo, "foo")
    assert %{__pb_extensions__: %{bar: "bar"}} = TestMsg.Ext.Foo2.put_extension(%{}, :bar, "bar")
    assert %{__pb_extensions__: %{"Parent.foo": "nested.foo"}} = TestMsg.Ext.Foo2.put_extension(%{}, :"Parent.foo", "nested.foo")
  end

  test "extension put not existed key" do
    assert_raise Protobuf.ExtensionNotFound, fn ->
      TestMsg.Ext.Foo1.put_extension(%{}, :not_exist, "foo")
    end
  end

  test "simple types work" do
    bin = <<186, 65, 3, 97, 98, 99>>
    msg = TestMsg.Ext.Foo2.new()
    msg = TestMsg.Ext.Foo2.put_extension(msg, :bar, "abc")
    assert bin == TestMsg.Ext.Foo2.encode(msg)

    msg = TestMsg.Ext.Foo2.decode(bin)
    assert %{__pb_extensions__: %{bar: "abc"}} = msg
    assert "abc" == TestMsg.Ext.Foo2.get_extension(msg, :bar)
  end

  test "nested types work" do
    bin = <<186, 65, 5, 10, 3, 97, 98, 99>>
    msg = TestMsg.Ext.Foo1.new()
    ext_msg = TestMsg.Ext.Options.new(a: "abc")
    msg = TestMsg.Ext.Foo1.put_extension(msg, :foo, ext_msg)
    assert bin == TestMsg.Ext.Foo2.encode(msg)

    msg = TestMsg.Ext.Foo1.decode(bin)
    assert %{__pb_extensions__: %{foo: %TestMsg.Ext.Options{a: "abc"}}} = msg
    assert %TestMsg.Ext.Options{a: "abc"} == TestMsg.Ext.Foo2.get_extension(msg, :foo)
  end

  test "enum types work" do
    bin = <<192, 65, 2>>
    msg = TestMsg.Ext.Foo1.new()
    msg = TestMsg.Ext.Foo1.put_extension(msg, :"Parent.foo", :B)
    assert bin == TestMsg.Ext.Foo1.encode(msg)

    msg = TestMsg.Ext.Foo1.decode(bin)
    assert %{__pb_extensions__: %{"Parent.foo": :B}} = msg
    assert :B == TestMsg.Ext.Foo1.get_extension(msg, :"Parent.foo")
  end
end
