defmodule Protobuf.Protoc.Generator.UtilTest do
  use ExUnit.Case, async: true

  import Protobuf.Protoc.Generator.Util

  test "mod_name can handle nil prefix" do
    assert mod_name(%{module_prefix: nil}, ["Foo", "Bar"]) == "Foo.Bar"
  end

  test "mod_name can handle empty package" do
    assert mod_name(%{module_prefix: ""}, ["Foo", "Bar"]) == "Foo.Bar"
  end

  test "mod_name returns right name" do
    assert mod_name(%{module_prefix: "custom.prefix"}, ["Foo", "Bar"]) == "Custom.Prefix.Foo.Bar"
  end
end
