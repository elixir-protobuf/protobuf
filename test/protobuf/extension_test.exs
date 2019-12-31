defmodule Protobuf.ExtensionTest do
  use ExUnit.Case, async: true

  alias Protobuf.GlobalStore

  test "extension persistent works" do
    assert %{type: TestMsg.Ext.Options} = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo1, :foo}, nil)
    assert %{type: :string} = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo2, :bar}, nil)
    assert %{type: TestMsg.EnumFoo} = GlobalStore.get({Protobuf.Extension, TestMsg.Ext.Foo2, :"Parent.foo"}, nil)
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
end
