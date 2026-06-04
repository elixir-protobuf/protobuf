defmodule Protobuf.Protoc.Generator.UtilTest do
  use ExUnit.Case, async: true

  import Protobuf.Protoc.Generator.Util

  alias Protobuf.Protoc.Context

  describe "mod_name/2" do
    test "camelizes components" do
      assert mod_name(%Context{}, ["lowercaseName"]) == "LowercaseName"
      assert mod_name(%Context{}, ["lowercase", "name"]) == "Lowercase.Name"
      assert mod_name(%Context{}, ["Upper", "lower"]) == "Upper.Lower"
    end

    test "can handle nil prefix" do
      assert mod_name(%Context{module_prefix: nil}, ["Foo", "Bar"]) == "Foo.Bar"
    end

    test "can handle empty package" do
      assert mod_name(%Context{module_prefix: ""}, ["Foo", "Bar"]) == "Foo.Bar"
    end

    test "can handle non-empty module prefix" do
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

    test "ensure all components of namespace are camel-case'd" do
      assert mod_name(%Context{module_prefix: nil}, ["foo", "Bar"]) == "Foo.Bar"
    end

    test "rejects a namespace component that isn't a bare identifier (no source injection)" do
      payload = "Victim do\n  System.halt()\n  defmodule X"

      assert_raise RuntimeError, ~r/invalid protobuf identifier/, fn ->
        mod_name(%Context{}, [payload])
      end
    end
  end

  describe "validate_proto_name!/1" do
    test "accepts bare identifiers" do
      assert validate_proto_name!("foo") == "foo"
      assert validate_proto_name!("_private") == "_private"
      assert validate_proto_name!("Foo123") == "Foo123"
      assert validate_proto_name!(:MY_ENUM_VALUE) == :MY_ENUM_VALUE
    end

    test "rejects names that could break out of the generated source" do
      for bad <- [
            "pwn, 1, type: :int32\n  System.halt()\n  field :pad",
            "has space",
            "has.dot",
            "1leading_digit",
            "trailing!",
            ""
          ] do
        assert_raise RuntimeError, ~r/invalid protobuf identifier/, fn ->
          validate_proto_name!(bad)
        end
      end
    end
  end

  describe "options_to_str/1" do
    test "stringifies a map of options" do
      assert options_to_str(%{}) == ""
      assert options_to_str(%{enum: true, syntax: nil}) == "enum: true"
      assert options_to_str(%{syntax: :proto2}) == "syntax: :proto2"
      assert options_to_str(%{full_name: nil, enum: false}) == ""
      assert options_to_str(%{deprecated: nil, map: nil, syntax: nil}) == ""
      # Atoms and integers render as bare literals...
      assert options_to_str(%{enum: true, oneof: 0}) == "enum: true, oneof: 0"
      # ...while strings render as quoted literals.
      assert options_to_str(%{full_name: "Foo.Bar"}) == "full_name: \"Foo.Bar\""
    end

    test "renders string values as quoted, escaped literals (no source injection)" do
      payload = ~s|true, evil: System.halt()|
      assert options_to_str(%{full_name: payload}) == ~s|full_name: "true, evil: System.halt()"|
    end

    test "keep options string in alphabetical order" do
      opts = %{
        syntax: :proto3,
        map: true,
        deprecated: true,
        protoc_gen_elixir_version: "1.2.3"
      }

      sorted_str =
        ~s|deprecated: true, map: true, protoc_gen_elixir_version: "1.2.3", syntax: :proto3|

      assert options_to_str(opts) == sorted_str
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
    test "ignores nils" do
      assert prepend_package_prefix("foo", nil) == "foo"
      assert prepend_package_prefix(nil, "foo") == "foo"
      assert prepend_package_prefix("foo", "bar") == "foo.bar"
    end
  end
end
