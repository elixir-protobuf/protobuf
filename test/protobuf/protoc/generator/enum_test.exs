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
        Google.Protobuf.EnumValueDescriptorProto.new(name: "B", number: 1)
      ]
    }

    msg = Generator.generate(ctx, desc)
    assert msg =~ "defmodule EnumFoo do\n"
    assert msg =~ "use Protobuf, enum: true\n"
    assert msg =~ "@type t :: integer | :A | :B\n"
    refute msg =~ "defstruct "
    assert msg =~ "field :A, 0\n  field :B, 1\n"
  end

  test "generate/2 generates enum type messages with custom options" do
    ctx = %Context{package: "", custom_field_options?: true}

    enum_opts = Google.Protobuf.EnumOptions.new()
    custom_opts = Brex.Elixirpb.EnumOptions.new(atomize: true)

    opts =
      Google.Protobuf.EnumOptions.put_extension(
        enum_opts,
        Brex.Elixirpb.PbExtension,
        :enum,
        custom_opts
      )

    desc = %Google.Protobuf.EnumDescriptorProto{
      name: "EnumFoo",
      options: opts,
      value: [
        Google.Protobuf.EnumValueDescriptorProto.new(name: "ENUM_FOO_A", number: 0),
        Google.Protobuf.EnumValueDescriptorProto.new(name: "ENUM_FOO_B", number: 1)
      ]
    }

    msg = Generator.generate(ctx, desc)
    assert msg =~ "defmodule EnumFoo do\n"
    assert msg =~ "use Protobuf, custom_field_options?: true, enum: true\n"
    assert msg =~ "@type t :: integer | :a | :b\n"
    refute msg =~ "defstruct "
    assert msg =~ "field :ENUM_FOO_A, 0\n  field :ENUM_FOO_B, 1\n"
  end
end
