Code.require_file("../support/test_msg.ex", __DIR__)
defmodule Protobuf.BuilderTest do
  use ExUnit.Case, async: true

  test "new/2 uses default values for proto3" do
    assert TestMsg.Foo.new().a == 0
    assert TestMsg.Foo.new().c == ""
    assert TestMsg.Foo.new().e == nil
  end

  test "new/2 use nil for proto2" do
    assert TestMsg.Foo2.new().a == nil
    assert TestMsg.Foo2.new().c == nil
    assert TestMsg.Foo2.new().e == nil
  end

  test "works for circular reference" do
    assert TestMsg.Parent.new().child == nil
  end

  test "from_params works with nested structs" do
    foo = TestMsg.Foo.from_params(%{
      "a" => 1,
      "e" => %{
        "a" => 2,
        "b" => "hi"
      }
    })

    assert foo.a == 1
    assert foo.e.a == 2
    assert foo.e.b == "hi"
  end
end
