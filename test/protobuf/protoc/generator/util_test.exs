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

  test "mod_name returns prefixed package name" do
    assert mod_name(%{package_prefix: "custom.prefix", package: "pkg", module_prefix: nil}, [
             "Foo",
             "Bar"
           ]) ==
             "Custom.Prefix.Pkg.Foo.Bar"
  end

  test "mod_name returns module prefix when  package prefix is present" do
    assert mod_name(
             %{module_prefix: "overrides", package_prefix: "custom.prefix", package: "pkg"},
             ["Foo", "Bar"]
           ) ==
             "Overrides.Foo.Bar"
  end

  describe "normalize_type_name/1" do
    test "splits the name and normalizes it" do
      assert normalize_type_name("pkg.Msg") == "Pkg.Msg"
      assert normalize_type_name("FooBar.Prefix.Msg") == "FooBar.Prefix.Msg"
    end
  end

  describe "options_to_str/1" do
    test "stringifies a map of options" do
      assert options_to_str(%{}) == ""
      assert options_to_str(%{enum: true, syntax: nil}) == "enum: true"
      assert options_to_str(%{syntax: :proto2}) == "syntax: :proto2"
      assert options_to_str(%{default: nil, enum: false}) == ""
      assert options_to_str(%{deprecated: nil, map: nil, syntax: nil}) == ""
      assert options_to_str(%{default: "42", enum: false}) == "default: 42"
      assert options_to_str(%{json_name: "\"theFieldName\""}) == "json_name: \"theFieldName\""
    end
  end
end
