defmodule Protobuf.Protoc.GeneratorTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.{Generator, Context}

  test "generate/2 works" do
    ctx = %Context{global_type_mapping: %{"name.proto" => %{}}}
    desc = Google.Protobuf.FileDescriptorProto.new(name: "name.proto")

    assert Generator.generate(ctx, desc) ==
             Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
               name: "name.pb.ex",
               content: ""
             )
  end
end
