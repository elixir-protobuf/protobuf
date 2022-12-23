defmodule Protobuf.Protoc.Generator.ExtensionTest do
  use ExUnit.Case, async: true

  alias Google.Protobuf.{DescriptorProto, FieldDescriptorProto, FileDescriptorProto}
  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Extension, as: Generator

  describe "generate/3" do
    test "doesn't generate any modules if the given file has no messages and no extensions" do
      ctx = %Context{namespace: [""]}
      desc = %FileDescriptorProto{extension: []}

      assert Generator.generate(ctx, desc) == []
    end

    test "generates file-level extensions using the file's module" do
      ctx = %Context{
        module_prefix: "ext",
        dep_type_mapping: %{
          ".ext.Foo1" => %{type_name: "Ext.Foo1"},
          ".ext.Bar1" => %{type_name: "Ext.Bar1"},
          ".ext.Options" => %{type_name: "Ext.Options"}
        },
        syntax: :proto2
      }

      desc = %FileDescriptorProto{
        extension: [
          %FieldDescriptorProto{
            extendee: ".ext.Foo1",
            name: "foo",
            json_name: "foo",
            number: 1047,
            label: :LABEL_OPTIONAL,
            type: :TYPE_MESSAGE,
            type_name: ".ext.Options"
          },
          %FieldDescriptorProto{
            extendee: ".ext.Bar1",
            name: "bar",
            json_name: "bar",
            number: 1048,
            label: :LABEL_OPTIONAL,
            type: :TYPE_MESSAGE,
            type_name: ".ext.Options"
          }
        ]
      }

      assert [{mod_name, msg}] = Generator.generate(ctx, desc)
      assert ["Ext", "Extensions" <> unique_part, "PbExtension"] = String.split(mod_name, ".")
      assert {_, ""} = Integer.parse(unique_part)
      assert msg =~ "extend Ext.Foo1, :foo, 1047, optional: true, type: Ext.Options"
      assert msg =~ "extend Ext.Bar1, :bar, 1048, optional: true, type: Ext.Options"
    end

    test "resolves type names" do
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

      assert [{"Ext.Extensions" <> _, msg}] = Generator.generate(ctx, desc)
      assert msg =~ "extend Ext.Foo1, :foo, 1047, optional: true, type: Ext.Options\n"
      assert msg =~ "extend Ext.Foo1, :foo2, 1049, repeated: true, type: :uint32\n"
      assert msg =~ "extend Ext.Foo2, :bar, 1047, optional: true, type: :string\n"
    end

    test "generates nested extensions when given" do
      ctx = %Context{
        module_prefix: "ext",
        dep_type_mapping: %{
          ".ext.Foo" => %{type_name: "Ext.Foo"}
        },
        syntax: :proto2
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        extension: [
          %Google.Protobuf.FieldDescriptorProto{
            extendee: ".ext.Foo",
            label: :LABEL_OPTIONAL,
            name: "file_level",
            json_name: "file_level",
            number: 1048,
            type: :TYPE_STRING
          }
        ],
        message_type: [
          %DescriptorProto{
            name: "MyMessage",
            extension: [
              %Google.Protobuf.FieldDescriptorProto{
                extendee: ".ext.Foo",
                label: :LABEL_OPTIONAL,
                name: "in_msg",
                json_name: "in_msg",
                number: 1049,
                type: :TYPE_STRING
              }
            ],
            nested_type: [
              %DescriptorProto{
                name: "NestedMessage",
                extension: [
                  %Google.Protobuf.FieldDescriptorProto{
                    extendee: ".ext.Foo",
                    label: :LABEL_OPTIONAL,
                    name: "in_nested",
                    json_name: "in_nested",
                    number: 1050,
                    type: :TYPE_STRING
                  }
                ]
              }
            ]
          }
        ]
      }

      assert [
               {"Ext.Extension" <> _ = unique_name, file_message},
               {"Ext.MyMessage.PbExtension", my_message},
               {"Ext.MyMessage.NestedMessage.PbExtension", nested_message}
             ] = Generator.generate(ctx, desc)

      assert ["Ext", "Extensions" <> _, "PbExtension"] = String.split(unique_name, ".")

      assert file_message =~ "extend Ext.Foo, :file_level, 1048, optional: true, type: :string"
      assert my_message =~ "extend Ext.Foo, :in_msg, 1049, optional: true, type: :string"
      assert nested_message =~ "extend Ext.Foo, :in_nested, 1050, optional: true, type: :string"
    end
  end
end
