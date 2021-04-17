defmodule Protobuf.Protoc.Generator.EnumTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Enum, as: Generator

  test "generate/2 generates enum type messages" do
    ctx = %Context{package: ""}

    desc = %Google.Protobuf.EnumDescriptorProto{
      name: "EnumFoo",
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
    assert msg =~ "defmodule EnumFoo do\n"
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
end
