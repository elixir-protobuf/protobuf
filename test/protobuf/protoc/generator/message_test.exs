defmodule Protobuf.Protoc.Generator.MessageTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Message, as: Generator

  test "generate/2 has right name" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo")
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo do\n"
    assert msg =~ "use Protobuf\n"
  end

  test "generate/2 has right syntax" do
    ctx = %Context{package: "", syntax: :proto3}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo")
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo do\n"
    assert msg =~ "use Protobuf, syntax: :proto3\n"
  end

  test "generate/2 has right name with package" do
    ctx = %Context{package: "pkg.name"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo")
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Pkg_Name.Foo do\n"
  end

  test "generate/2 has right options" do
    ctx = %Context{package: "pkg.name"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", options: Google_Protobuf.MessageOptions.new(map_entry: true))
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "use Protobuf, map: true\n"
  end

  test "generate/2 has right fields" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1),
      Google_Protobuf.FieldDescriptorProto.new(name: "b", number: 2, type: 9, label: 2)
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "defstruct [:a, :b]\n"
    assert msg =~ "a: integer"
    assert msg =~ "b: String.t"
    assert msg =~ "field :a, 1, optional: true, type: :int32\n"
    assert msg =~ "field :b, 2, required: true, type: :string\n"
  end

  test "generate/2 supports option :default" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1, default_value: "42")
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "a: integer"
    assert msg =~ "field :a, 1, optional: true, type: :int32, default: 42\n"
  end

  test "generate/2 supports option :packed" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1,
        options: %Google_Protobuf.FieldOptions{packed: true})
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, packed: true\n"
  end

  test "generate/2 supports option :deprecated" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1,
      options: %Google_Protobuf.FieldOptions{deprecated: true})
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, deprecated: true\n"
  end

  test "generate/2 supports map field" do
    ctx = %Context{package: "foo_bar.ab_cd"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 11, label: 3, type_name: ".foo_bar.ab_cd.Foo.ProjectsEntry")
    ], nested_type: [Google_Protobuf.DescriptorProto.new(
      name: "ProjectsEntry", options: Google_Protobuf.MessageOptions.new(map_entry: true),
      field: [
        Google_Protobuf.FieldDescriptorProto.new(number: 1, label: 1, type: 5, type_name: "int32"),
        Google_Protobuf.FieldDescriptorProto.new(number: 2, label: 1, type: 11, type_name: ".foo_bar.ab_cd.Bar")
      ]
    )])
    [msg, _] = Generator.generate(ctx, desc)
    assert msg =~ "a: %{integer => FooBar_AbCd.Bar.t}"
    assert msg =~ "field :a, 1, repeated: true, type: FooBar_AbCd.Foo.ProjectsEntry, map: true\n"
  end

  test "generate/2 supports enum field" do
    ctx = %Context{package: "foo_bar.ab_cd"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".foo_bar.ab_cd.EnumFoo")
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "a: integer"
    assert msg =~ "field :a, 1, optional: true, type: FooBar_AbCd.EnumFoo, enum: true\n"
  end

  test "generate/2 generate right enum type name with different package" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["other_pkg"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".other_pkg.EnumFoo")
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.EnumFoo, enum: true\n"
  end

  test "generate/2 generate right message type name with different package" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["other_pkg"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 11, label: 1, type_name: ".other_pkg.MsgFoo")
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "a: OtherPkg.MsgFoo.t"
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.MsgFoo\n"
  end

  test "generate/2 use longest package name for type" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["foo.bar", "foo"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".foo.bar.EnumFoo")
    ])
    [msg] = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: Foo_Bar.EnumFoo, enum: true\n"
  end

  test "generate/2 supports nested messages" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", nested_type: [
      Google_Protobuf.DescriptorProto.new(name: "Nested")
    ])
    [_, [msg]] = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.Nested do\n"
    assert msg =~ "defstruct []\n"
  end

  test "generate/2 supports nested enum messages" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", nested_type: [
      Google_Protobuf.DescriptorProto.new(enum_type: [
        Google_Protobuf.EnumDescriptorProto.new(name: "EnumFoo",
          value: [%Google_Protobuf.EnumValueDescriptorProto{name: "a", number: 0},
                  %Google_Protobuf.EnumValueDescriptorProto{name: "b", number: 1}]
        )
      ], name: "Nested")
    ])
    [_, [_, msg]] = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.Nested.EnumFoo do\n"
    assert msg =~ "use Protobuf, enum: true\n"
    assert msg =~ "field :a, 0\n  field :b, 1\n"
  end
end
