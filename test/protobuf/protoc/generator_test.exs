defmodule Protobuf.Protoc.GeneratorTest do
  use ExUnit.Case, async: true

  import Protobuf.TestHelpers

  alias Protobuf.Protoc.{Generator, Context}
  alias Google.Protobuf.Compiler.CodeGeneratorResponse

  describe "generate/2" do
    test "returns a Google.Protobuf.Compiler.CodeGeneratorResponse.File struct" do
      ctx = %Context{global_type_mapping: %{"name.proto" => %{}}}
      desc = Google.Protobuf.FileDescriptorProto.new(name: "name.proto")

      assert Generator.generate(ctx, desc) ==
               CodeGeneratorResponse.File.new(name: "name.pb.ex", content: "")
    end

    test "uses the package prefix" do
      ctx = %Context{
        package_prefix: "myapp",
        global_type_mapping: %{
          "name.proto" => %{".myapp.Foo" => %{type_name: "Myapp.Foo"}}
        }
      }

      desc =
        Google.Protobuf.FileDescriptorProto.new(
          name: "name.proto",
          message_type: [Google.Protobuf.DescriptorProto.new(name: "Foo")]
        )

      assert %CodeGeneratorResponse.File{} = file = Generator.generate(ctx, desc)

      assert [{mod, _bytecode}] = Code.compile_string(file.content)
      assert mod == Myapp.Foo

      purge_modules([mod])
    end

    test "uses the package prefix when descriptor has package" do
      ctx = %Context{
        package_prefix: "myapp.proto",
        global_type_mapping: %{
          "name.proto" => %{".myapp.proto.lib.Foo" => %{type_name: "Myapp.Proto.Lib.Foo"}}
        }
      }

      desc =
        Google.Protobuf.FileDescriptorProto.new(
          name: "name.proto",
          package: "lib",
          message_type: [Google.Protobuf.DescriptorProto.new(name: "Foo")]
        )

      assert %CodeGeneratorResponse.File{} = file = Generator.generate(ctx, desc)

      assert [{mod, _bytecode}] = Code.compile_string(file.content)
      assert mod == Myapp.Proto.Lib.Foo

      purge_modules([mod])
    end

    test "returns a module for each enum and message" do
      ctx = %Context{
        package: "foo",
        global_type_mapping: %{"name.proto" => %{}}
      }

      desc =
        Google.Protobuf.FileDescriptorProto.new(
          name: "name.proto",
          message_type: [Google.Protobuf.DescriptorProto.new(name: "MyMessage")],
          enum_type: [
            Google.Protobuf.EnumDescriptorProto.new(
              name: "MyEnum",
              value: [
                Google.Protobuf.EnumValueDescriptorProto.new(name: :MY_ENUM_NOT_SET, number: 0)
              ]
            )
          ]
        )

      assert %CodeGeneratorResponse.File{} = file = Generator.generate(ctx, desc)

      assert [{enum_mod, _bytecode1}, {message_mod, _bytecode2}] =
               Code.compile_string(file.content)

      assert enum_mod == MyEnum
      assert message_mod == MyMessage

      purge_modules([enum_mod, message_mod])
    end

    test "can generate a GRPC service" do
      ctx = %Context{
        package: "foo",
        plugins: ["grpc"],
        global_type_mapping: %{"name.proto" => %{}, "my_dep" => %{}}
      }

      desc =
        Google.Protobuf.FileDescriptorProto.new(
          name: "name.proto",
          dependency: ["my_dep"],
          service: [Google.Protobuf.ServiceDescriptorProto.new(name: "my_service")]
        )

      # We can't compile the generated service module because we haven't loaded GRPC.Service here.
      assert %CodeGeneratorResponse.File{} = file = Generator.generate(ctx, desc)
      assert file.content =~ "defmodule MyService.Service do"
    end
  end
end
