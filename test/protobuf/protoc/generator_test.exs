defmodule Protobuf.Protoc.GeneratorTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.{Generator, Context}

  test "generate/1 works" do
    desc = %Google_Protobuf.FileDescriptorProto{name: "name"}
    assert Generator.generate(desc) == %Google_Protobuf_Compiler.CodeGeneratorResponse.File{name: "name", content: ""}
  end

  test "generate_msg/2 has right name" do
    ctx = %Context{}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo"}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Foo do\n"
    assert msg =~ "use Protobuf\n"
  end

  test "generate_msg/2 has right fields" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", field: [
      %Google_Protobuf.FieldDescriptorProto{name: "a", number: 1, type: 5, label: 1},
      %Google_Protobuf.FieldDescriptorProto{name: "b", number: 2, type: 9, label: 2}
    ]}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defstruct [:a, :b]\n"
    assert msg =~ "field :a, 1, optional: true, type: :int32\n"
    assert msg =~ "field :b, 2, required: true, type: :string\n"
  end

  test "generate_msg/2 supports option :default" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", field: [
      %Google_Protobuf.FieldDescriptorProto{name: "a", number: 1, type: 5, label: 1, default_value: 42}
    ]}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, default: 42\n"
  end

  test "generate_msg/2 supports option :packed" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", field: [
      %Google_Protobuf.FieldDescriptorProto{name: "a", number: 1, type: 5, label: 1,
        options: %Google_Protobuf.FieldOptions{packed: true}}
    ]}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, packed: true\n"
  end

  test "generate_msg/2 supports option :deprecated" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", field: [
      %Google_Protobuf.FieldDescriptorProto{name: "a", number: 1, type: 5, label: 1,
      options: %Google_Protobuf.FieldOptions{deprecated: true}}
    ]}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, deprecated: true\n"
  end

  test "generate_msg/2 supports enum" do
    ctx = %Context{package: "a_b.c_d"}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", field: [
      %Google_Protobuf.FieldDescriptorProto{name: "a", number: 1, type: 14, label: 1, type_name: ".a_b.c_d.EnumFoo"}
    ]}
    [msg] = Generator.generate_msg(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: EnumFoo, enum: true\n"
  end

  test "generate_msg/2 supports nested messages" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", nested_type: [
      %Google_Protobuf.DescriptorProto{name: "Nested"}
    ]}
    [_, [msg]] = Generator.generate_msg(ctx, desc)
    assert msg =~ "defmodule Foo.Nested do\n"
    assert msg =~ "defstruct []\n"
  end

  test "generate_msg/2 supports nested enum messages" do
    ctx = %Context{package: ""}
    desc = %Google_Protobuf.DescriptorProto{name: "Foo", nested_type: [
      %Google_Protobuf.DescriptorProto{enum_type: [
        %Google_Protobuf.EnumDescriptorProto{name: "EnumFoo",
          value: [%Google_Protobuf.EnumValueDescriptorProto{name: "A", number: 0},
                  %Google_Protobuf.EnumValueDescriptorProto{name: "B", number: 1}]
        }
      ], name: "Nested"}
    ]}
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
end
