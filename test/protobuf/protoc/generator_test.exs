defmodule Protobuf.Protoc.GeneratorTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.{Generator, Context}

  test "generate/2 works" do
    ctx = %Context{}
    desc = Google_Protobuf.FileDescriptorProto.new(name: "name.proto")
    assert Generator.generate(ctx, desc) == %Google_Protobuf_Compiler.CodeGeneratorResponse.File{name: "name.pb.ex", content: ""}
  end

  test "get_dep_pkgs/2 sort pkgs by length" do
    ctx = %Context{pkg_mapping: %{"foo.proto" => "foo", "foo_bar.proto" => "foo.bar"}}
    assert Generator.get_dep_pkgs(ctx, ["foo.proto", "foo_bar.proto"]) == ["foo.bar", "foo"]
  end

  test "generate_msg/2 has right name" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo")
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Foo do\n"
    assert msg =~ "use Protobuf\n"
  end

  test "generate_msg/2 has right name with package" do
    ctx = %Context{package: "pkg.name"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo")
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Pkg_Name.Foo do\n"
  end

  test "generate_msg/2 has right options" do
    ctx = %Context{package: "pkg.name"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", options: Google_Protobuf.MessageOptions.new(map_entry: true))
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "use Protobuf, map: true\n"
  end

  test "generate_msg/2 has right fields" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1),
      Google_Protobuf.FieldDescriptorProto.new(name: "b", number: 2, type: 9, label: 2)
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defstruct [:a, :b]\n"
    assert msg =~ "field :a, 1, optional: true, type: :int32\n"
    assert msg =~ "field :b, 2, required: true, type: :string\n"
  end

  test "generate_msg/2 supports option :default" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1, default_value: "42")
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, default: 42\n"
  end

  test "generate_msg/2 supports option :packed" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1,
        options: %Google_Protobuf.FieldOptions{packed: true})
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, packed: true\n"
  end

  test "generate_msg/2 supports option :deprecated" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 5, label: 1,
      options: %Google_Protobuf.FieldOptions{deprecated: true})
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, deprecated: true\n"
  end

  test "generate_msg/2 supports map field" do
    ctx = %Context{package: "foo_bar.ab_cd"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 11, label: 3, type_name: ".foo_bar.ab_cd.Foo.ProjectsEntry")
    ], nested_type: [Google_Protobuf.DescriptorProto.new(
      name: "ProjectsEntry", options: Google_Protobuf.MessageOptions.new(map_entry: true)
    )])
    [msg, _] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, repeated: true, type: FooBar_AbCd.Foo.ProjectsEntry, map: true\n"
  end

  test "generate_msg/2 supports enum field" do
    ctx = %Context{package: "foo_bar.ab_cd"}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".foo_bar.ab_cd.EnumFoo")
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: FooBar_AbCd.EnumFoo, enum: true\n"
  end

  test "generate_msg/2 generate right enum type name with different package" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["other_pkg"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".other_pkg.EnumFoo")
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.EnumFoo, enum: true\n"
  end

  test "generate_msg/2 generate right message type name with different package" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["other_pkg"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 11, label: 1, type_name: ".other_pkg.MsgFoo")
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.MsgFoo\n"
  end

  test "generate_msg/2 use longest package name for type" do
    ctx = %Context{package: "foo_bar.ab_cd", dep_pkgs: ["foo.bar", "foo"]}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", field: [
      Google_Protobuf.FieldDescriptorProto.new(name: "a", number: 1, type: 14, label: 1, type_name: ".foo.bar.EnumFoo")
    ])
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: Foo_Bar.EnumFoo, enum: true\n"
  end

  test "generate_msg/2 supports nested messages" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", nested_type: [
      Google_Protobuf.DescriptorProto.new(name: "Nested")
    ])
    [_, [msg]] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Foo.Nested do\n"
    assert msg =~ "defstruct []\n"
  end

  test "generate_msg/2 supports nested enum messages" do
    ctx = %Context{package: ""}
    desc = Google_Protobuf.DescriptorProto.new(name: "Foo", nested_type: [
      Google_Protobuf.DescriptorProto.new(enum_type: [
        Google_Protobuf.EnumDescriptorProto.new(name: "EnumFoo",
          value: [%Google_Protobuf.EnumValueDescriptorProto{name: "A", number: 0},
                  %Google_Protobuf.EnumValueDescriptorProto{name: "B", number: 1}]
        )
      ], name: "Nested")
    ])
    [_, [_, msg]] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Foo.Nested.EnumFoo do\n"
    assert msg =~ "use Protobuf, enum: true\n"
    assert msg =~ "field :A, 0\n  field :B, 1\n"
  end

  test "generate_enum/2 generates enum type messages" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.EnumDescriptorProto{name: "EnumFoo",
      options: nil,
      value: [%Google_Protobuf.EnumValueDescriptorProto{name: "A", number: 0},
              %Google_Protobuf.EnumValueDescriptorProto{name: "B", number: 1}]
    }
    msg = Generator.generate_enum(ctx, desc)
    assert msg =~ "defmodule EnumFoo do\n"
    assert msg =~ "use Protobuf, enum: true\n"
    refute msg =~ "defstruct "
    assert msg =~ "field :A, 0\n  field :B, 1\n"
  end

  test "generate_service/2 generates services" do
    ctx = %Context{package: "foo"}
    desc = %Google_Protobuf.ServiceDescriptorProto{name: "ServiceFoo",
      method: [
        %Google_Protobuf.MethodDescriptorProto{name: "MethodA", input_type: "Input0", output_type: "Output0"},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodB", input_type: "Input1", output_type: "Output1", client_streaming: true},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodC", input_type: "Input2", output_type: "Output2", server_streaming: true},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodD", input_type: "Input3", output_type: "Output3", client_streaming: true, server_streaming: true}
      ]
    }
    msg = Generator.generate_service(ctx, desc)
    assert msg =~ "defmodule Foo.ServiceFoo.Service do\n"
    assert msg =~ "use GRPC.Service, name: \"foo.ServiceFoo\"\n"
    assert msg =~ "rpc :MethodA, Foo.Input0, Foo.Output0\n"
    assert msg =~ "rpc :MethodB, stream(Foo.Input1), Foo.Output1\n"
    assert msg =~ "rpc :MethodC, Foo.Input2, stream(Foo.Output2)\n"
    assert msg =~ "rpc :MethodD, stream(Foo.Input3), stream(Foo.Output3)\n"
  end
end
