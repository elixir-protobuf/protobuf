defmodule Protobuf.Protoc.Generator.EnumTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Enum, as: Generator
  alias Protobuf.TestHelpers

  test "generate/2 generates enum type messages" do
    ctx = %Context{}
    module = Module.concat(__MODULE__, "EnumFoo") |> inspect() |> String.replace(".", "")

    desc = %Google.Protobuf.EnumDescriptorProto{
      name: module,
      options: nil,
      value: [
        Google.Protobuf.EnumValueDescriptorProto.new(name: "A", number: 0),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "B", number: 1),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES", number: 2),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES_X", number: 3),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES_", number: 4)
      ]
    }

    assert {^module, msg} = Generator.generate(ctx, desc)

    # Make sure the generated file is compilable.
    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)
    assert inspect(compiled_mod) == module

    assert msg =~ "defmodule #{module} do\n"
    assert msg =~ "use Protobuf, enum: true\n"

    refute msg =~ "defstruct "

    assert msg =~ """
             field :A, 0
             field :B, 1
             field :HAS_UNDERSCORES, 2
             field :HAS_UNDERSCORES_X, 3
             field :HAS_UNDERSCORES_, 4
           """

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             "t() :: integer() | :A | :B | :HAS_UNDERSCORES | :HAS_UNDERSCORES_X | :HAS_UNDERSCORES_"
  end

  test "generate/2 generates enum type messages with descriptor" do
    ctx = %Context{gen_descriptors?: true}
    module = Module.concat(__MODULE__, "EnumFooDesc") |> inspect() |> String.replace(".", "")

    desc = %Google.Protobuf.EnumDescriptorProto{
      name: module,
      options: nil,
      value: [
        Google.Protobuf.EnumValueDescriptorProto.new(name: "A", number: 0),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "B", number: 1),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES", number: 2),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES_X", number: 3),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "HAS_UNDERSCORES_", number: 4)
      ]
    }

    assert {^module, msg} = Generator.generate(ctx, desc)

    # Make sure the generated file is compilable.
    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)
    assert inspect(compiled_mod) == module

    assert msg =~ "defmodule #{module} do\n"
    assert msg =~ "use Protobuf, enum: true\n"

    refute msg =~ "defstruct "

    assert msg =~ """
             field :A, 0
             field :B, 1
             field :HAS_UNDERSCORES, 2
             field :HAS_UNDERSCORES_X, 3
             field :HAS_UNDERSCORES_, 4
           """

    assert %Google.Protobuf.EnumDescriptorProto{} = desc = compiled_mod.descriptor
    assert desc.name == module

    assert msg =~ """
             def descriptor do
               # credo:disable-for-next-line
           """

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             "t() :: integer() | :A | :B | :HAS_UNDERSCORES | :HAS_UNDERSCORES_X | :HAS_UNDERSCORES_"
  end

  test "generate/2 generates the right code when the enum name starts with lowercase" do
    ctx = %Context{}

    desc = %Google.Protobuf.EnumDescriptorProto{
      name: "valueType",
      options: nil,
      value: [
        Google.Protobuf.EnumValueDescriptorProto.new(name: "VALUE_TYPE_UNDEFINED", number: 0),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "VALUE_TYPE_INTEGER", number: 1)
      ]
    }

    assert {module, msg} = Generator.generate(ctx, desc)

    assert module == "ValueType"
    assert msg =~ "defmodule ValueType do"
  end
end
