defmodule Protobuf.Protoc.Generator.UtilTest do
  use ExUnit.Case, async: true

  import Protobuf.Protoc.Generator.Util

  alias Protobuf.Protoc.Context

  describe "mod_name/2" do
    test "can handle nil prefix" do
      assert mod_name(%Context{module_prefix: nil}, ["Foo", "Bar"]) == "Foo.Bar"
    end

    test "can handle empty package" do
      assert mod_name(%Context{module_prefix: ""}, ["Foo", "Bar"]) == "Foo.Bar"
    end

    test "returns right name" do
      assert mod_name(%Context{module_prefix: "custom.prefix"}, ["Foo", "Bar"]) ==
               "Custom.Prefix.Foo.Bar"
    end

    test "returns prefixed package name" do
      ctx = %Context{package_prefix: "custom.prefix", package: "pkg", module_prefix: nil}
      assert mod_name(ctx, ["Foo", "Bar"]) == "Custom.Prefix.Pkg.Foo.Bar"
    end

    test "returns module prefix when package prefix is present" do
      ctx = %Context{module_prefix: "overrides", package_prefix: "custom.prefix", package: "pkg"}
      assert mod_name(ctx, ["Foo", "Bar"]) == "Overrides.Foo.Bar"
    end
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

  describe "type_from_type_name/2" do
    test "fetches the right type" do
      ctx = %Context{
        dep_type_mapping: %{
          ".Bar" => %{type_name: "Bar"},
          ".Baz" => %{type_name: "Baz"}
        }
      }

      assert type_from_type_name(ctx, ".Baz") == "Baz"

      ctx = %Context{
        dep_type_mapping: %{".foo_bar.ab_cd.Bar" => %{type_name: "FooBar.AbCd.Bar"}}
      }

      assert type_from_type_name(ctx, ".foo_bar.ab_cd.Bar")
    end
  end

  describe "prepend_package_prefix/2" do
    test "ignores empty strings" do
      assert prepend_package_prefix("foo", nil) == "foo"
      assert prepend_package_prefix(nil, "foo") == "foo"
      assert prepend_package_prefix("foo", "bar") == "foo.bar"
    end
  end
end
