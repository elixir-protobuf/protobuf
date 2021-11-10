defmodule Protobuf.Protoc.Generator.EnumTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Enum, as: Generator

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

    msg = Generator.generate(ctx, desc)

    # Make sure the generated file is compilable.
    assert [{compiled_mod, _bytecode}] = Code.compile_string(msg)
    assert inspect(compiled_mod) == module

    assert msg =~ "defmodule #{module} do\n"
    assert msg =~ "use Protobuf, enum: true\n"

    assert msg =~
             "@type t :: integer | :A | :B | :HAS_UNDERSCORES | :HAS_UNDERSCORES_X | :HAS_UNDERSCORES_\n"

    refute msg =~ "defstruct "

    assert msg =~ """
             field :A, 0
             field :B, 1
             field :HAS_UNDERSCORES, 2
             field :HAS_UNDERSCORES_X, 3
             field :HAS_UNDERSCORES_, 4
           """
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

    msg = Generator.generate(ctx, desc)

    # Make sure the generated file is compilable.
    assert [{compiled_mod, _bytecode}] = Code.compile_string(msg)
    assert inspect(compiled_mod) == module

    assert msg =~ "defmodule #{module} do\n"
    assert msg =~ "use Protobuf, enum: true\n"

    assert msg =~
             "@type t :: integer | :A | :B | :HAS_UNDERSCORES | :HAS_UNDERSCORES_X | :HAS_UNDERSCORES_\n"

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
  end
end
