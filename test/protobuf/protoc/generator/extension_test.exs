defmodule Protobuf.Protoc.Generator.ExtensionTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Extension, as: Generator

  test "generate/3 generates blank" do
    ctx = %Context{namespace: [""]}

    desc = Google.Protobuf.FileDescriptorProto.new(extension: [])

    msg = Generator.generate(ctx, desc, [])
    assert msg == ""
  end

  test "generate/3 generates extensions" do
    ctx = %Context{
      module_prefix: "ext",
      dep_type_mapping: %{
        ".ext.Foo1" => %{type_name: "Ext.Foo1"},
        ".ext.Options" => %{type_name: "Ext.Options"},
        ".ext.Foo2" => %{type_name: "Ext.Foo2"}
      },
      syntax: :proto2
    }

    desc =
      Google.Protobuf.FileDescriptorProto.new(
        extension: [
          %{
            extendee: ".ext.Foo1",
            name: "foo",
            number: 1047,
            label: :LABEL_OPTIONAL,
            type: :TYPE_MESSAGE,
            type_name: ".ext.Options"
          },
          %{
            extendee: ".ext.Foo1",
            name: "foo2",
            number: 1049,
            label: :LABEL_REPEATED,
            type: :TYPE_UINT32
          },
          %{
            extendee: ".ext.Foo2",
            name: "bar",
            number: 1047,
            label: :LABEL_OPTIONAL,
            type: :TYPE_STRING
          }
        ]
      )

    msg = Generator.generate(ctx, desc, [])
    assert msg =~ "defmodule Ext.PbExtension do\n"
    assert msg =~ "extend Ext.Foo1, :foo, 1047, optional: true, type: Ext.Options\n"
    assert msg =~ "extend Ext.Foo1, :foo2, 1049, repeated: true, type: :uint32\n"
    assert msg =~ "extend Ext.Foo2, :bar, 1047, optional: true, type: :string\n"
  end

  test "generate/3 generates nested extensions" do
    ctx = %Context{
      module_prefix: "ext",
      dep_type_mapping: %{
        ".ext.Foo1" => %{type_name: "Ext.Foo1"},
        ".ext.EnumFoo" => %{type_name: "Ext.EnumFoo"}
      },
      syntax: :proto2
    }

    desc = Google.Protobuf.FileDescriptorProto.new(extension: [])

    nested = [
      {["Parent"],
       [
         Google.Protobuf.FieldDescriptorProto.new(
           extendee: ".ext.Foo1",
           label: :LABEL_OPTIONAL,
           name: "foo",
           number: 1048,
           type: :TYPE_ENUM,
           type_name: ".ext.EnumFoo"
         )
       ]}
    ]

    msg = Generator.generate(ctx, desc, nested)
    assert msg =~ "defmodule Ext.PbExtension do\n"

    assert msg =~
             ~s(extend Ext.Foo1, :"Parent.foo", 1048, optional: true, type: Ext.EnumFoo, enum: true\n)
  end
end
