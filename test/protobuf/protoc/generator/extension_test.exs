defmodule Protobuf.Protoc.Generator.ExtensionTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Extension, as: Generator

  describe "generate/3" do
    test "generates blank" do
      ctx = %Context{namespace: [""]}

      desc = %Google.Protobuf.FileDescriptorProto{extension: []}

      assert Generator.generate(ctx, desc, []) == nil
    end

    test "generates extensions" do
      ctx = %Context{
        module_prefix: "ext",
        dep_type_mapping: %{
          ".ext.Foo1" => %{type_name: "Ext.Foo1"},
          ".ext.Options" => %{type_name: "Ext.Options"},
          ".ext.Foo2" => %{type_name: "Ext.Foo2"}
        },
        syntax: :proto2
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        extension: [
          %Google.Protobuf.FieldDescriptorProto{
            extendee: ".ext.Foo1",
            name: "foo",
            json_name: "foo",
            number: 1047,
            label: :LABEL_OPTIONAL,
            type: :TYPE_MESSAGE,
            type_name: ".ext.Options"
          },
          %Google.Protobuf.FieldDescriptorProto{
            extendee: ".ext.Foo1",
            name: "foo2",
            json_name: "foo2",
            number: 1049,
            label: :LABEL_REPEATED,
            type: :TYPE_UINT32
          },
          %Google.Protobuf.FieldDescriptorProto{
            extendee: ".ext.Foo2",
            name: "bar",
            json_name: "bar",
            number: 1047,
            label: :LABEL_OPTIONAL,
            type: :TYPE_STRING
          }
        ]
      }

      assert {_mod_name, msg} = Generator.generate(ctx, desc, _nested_extensions = [])
      assert msg =~ "defmodule Ext.PbExtension do\n"
      assert msg =~ "extend Ext.Foo1, :foo, 1047, optional: true, type: Ext.Options\n"
      assert msg =~ "extend Ext.Foo1, :foo2, 1049, repeated: true, type: :uint32\n"
      assert msg =~ "extend Ext.Foo2, :bar, 1047, optional: true, type: :string\n"
    end

    test "generates nested extensions when given" do
      ctx = %Context{
        module_prefix: "ext",
        dep_type_mapping: %{
          ".ext.Foo1" => %{type_name: "Ext.Foo1"},
          ".ext.EnumFoo" => %{type_name: "Ext.EnumFoo"}
        },
        syntax: :proto2
      }

      desc = %Google.Protobuf.FileDescriptorProto{extension: []}

      nested = [
        {["Parent"],
         [
           %Google.Protobuf.FieldDescriptorProto{
             extendee: ".ext.Foo1",
             label: :LABEL_OPTIONAL,
             name: "foo",
             json_name: "foo",
             number: 1048,
             type: :TYPE_ENUM,
             type_name: ".ext.EnumFoo"
           }
         ]}
      ]

      assert {"Ext.PbExtension", msg} = Generator.generate(ctx, desc, nested)
      assert msg =~ "defmodule Ext.PbExtension do\n"

      assert msg =~
               ~s(extend Ext.Foo1, :"Parent.foo", 1048, optional: true, type: Ext.EnumFoo, enum: true\n)
    end
  end

  describe "get_nested_extensions/2" do
    test "returns the nested extensions" do
      ctx = %Context{
        namespace: ["my_ns"],
        dep_type_mapping: %{
          ".ext.Foo1" => %{type_name: "Ext.Foo1"},
          ".ext.EnumFoo" => %{type_name: "Ext.EnumFoo"}
        },
        syntax: :proto2
      }

      descs = [
        %Google.Protobuf.DescriptorProto{
          name: "MyMsg",
          extension: [
            %Google.Protobuf.FieldDescriptorProto{
              extendee: ".ext.Foo1",
              label: :LABEL_OPTIONAL,
              name: "foo1",
              json_name: "foo1",
              number: 1048,
              type: :TYPE_ENUM,
              type_name: ".ext.EnumFoo"
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "MyNestedMsg",
              extension: [
                %Google.Protobuf.FieldDescriptorProto{
                  extendee: ".ext.Foo2",
                  label: :LABEL_OPTIONAL,
                  name: "foo2",
                  json_name: "foo2",
                  number: 1048,
                  type: :TYPE_ENUM,
                  type_name: ".ext.EnumFoo"
                }
              ]
            }
          ]
        }
      ]

      assert [nested1, nested2] = Generator.get_nested_extensions(ctx, descs)

      assert {ns1, [field1]} = nested1
      assert ns1 == ["my_ns", "MyMsg"]
      assert %Google.Protobuf.FieldDescriptorProto{extendee: ".ext.Foo1", name: "foo1"} = field1

      assert {ns2, [field2]} = nested2
      assert ns2 == ["my_ns", "MyMsg", "MyNestedMsg"]
      assert %Google.Protobuf.FieldDescriptorProto{extendee: ".ext.Foo2", name: "foo2"} = field2
    end
  end
end
