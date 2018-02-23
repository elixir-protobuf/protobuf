defmodule Protobuf.Protoc.Generator.UtilTest do
  use ExUnit.Case, async: true

  import Protobuf.Protoc.Generator.Util

  test "attach_pkg can handle nil package" do
    assert attach_pkg("name", nil) == "name"
  end

  test "attach_pkg can handle empty package" do
    assert attach_pkg("name", "") == "name"
  end

  test "attach_pkg normolizes package name" do
    assert attach_pkg("Name", "foo.bar") == "Foo.Bar.Name"
  end
end
