defmodule Protobuf.Protoc.GeneratorTest do
  use ExUnit.Case, async: true

  import Protobuf.TestHelpers

  alias Protobuf.Protoc.{Generator, Context}
  alias Google.Protobuf.Compiler.CodeGeneratorResponse

  describe "generate/2" do
    test "returns a list of Google.Protobuf.Compiler.CodeGeneratorResponse.File structs" do
      ctx = %Context{global_type_mapping: %{"name.proto" => %{}}}
      desc = %Google.Protobuf.FileDescriptorProto{name: "name.proto"}

      assert Generator.generate(ctx, desc) ==
               {nil, [%CodeGeneratorResponse.File{name: "name.pb.ex", content: ""}]}
    end

    test "uses the package prefix" do
      ctx = %Context{
        package_prefix: "myapp",
        global_type_mapping: %{
          "name.proto" => %{".myapp.Foo" => %{type_name: "Myapp.Foo"}}
        }
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        message_type: [%Google.Protobuf.DescriptorProto{name: "Foo"}]
      }

      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)

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

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        package: "lib",
        message_type: [%Google.Protobuf.DescriptorProto{name: "Foo"}]
      }

      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)

      assert [{mod, _bytecode}] = Code.compile_string(file.content)
      assert mod == Myapp.Proto.Lib.Foo

      purge_modules([mod])
    end

    test "returns a module for each enum and message" do
      ctx = %Context{
        package: "foo",
        global_type_mapping: %{"name.proto" => %{}}
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        message_type: [%Google.Protobuf.DescriptorProto{name: "MyMessage"}],
        enum_type: [
          %Google.Protobuf.EnumDescriptorProto{
            name: "MyEnum",
            value: [
              %Google.Protobuf.EnumValueDescriptorProto{name: :MY_ENUM_NOT_SET, number: 0}
            ]
          }
        ]
      }

      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)

      assert [{enum_mod, _bytecode1}, {message_mod, _bytecode2}] =
               Code.compile_string(file.content)

      assert enum_mod == MyEnum
      assert message_mod == MyMessage

      purge_modules([enum_mod, message_mod])
    end

    test "returns a module for each enum and message as separate files with one_file_per_module=true" do
      ctx = %Context{
        global_type_mapping: %{"name.proto" => %{}},
        one_file_per_module?: true
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        package: "foo",
        message_type: [%Google.Protobuf.DescriptorProto{name: "MyMessage.Nested"}],
        enum_type: [
          %Google.Protobuf.EnumDescriptorProto{
            name: "MyEnum",
            value: [
              %Google.Protobuf.EnumValueDescriptorProto{name: :MY_ENUM_NOT_SET, number: 0}
            ]
          }
        ]
      }

      assert {nil = _extensions,
              [
                %CodeGeneratorResponse.File{} = enum_file,
                %CodeGeneratorResponse.File{} = message_file
              ]} = Generator.generate(ctx, desc)

      assert message_file.name == "foo/my_message/nested.pb.ex"
      assert enum_file.name == "foo/my_enum.pb.ex"
    end

    test "with one_file_per_module=true and package_prefix" do
      ctx = %Context{
        global_type_mapping: %{"name.proto" => %{}},
        one_file_per_module?: true,
        package_prefix: "prfx"
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        package: "foo",
        message_type: [%Google.Protobuf.DescriptorProto{name: "MyMessage.Nested"}]
      }

      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)

      assert file.name == "prfx/foo/my_message/nested.pb.ex"
    end

    test "with one_file_per_module=true and module_prefix" do
      ctx = %Context{
        global_type_mapping: %{"name.proto" => %{}},
        one_file_per_module?: true,
        module_prefix: "My.Prefix"
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        package: "foo",
        message_type: [%Google.Protobuf.DescriptorProto{name: "MyMessage.Nested"}]
      }

      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)

      assert file.name == "my/prefix/my_message/nested.pb.ex"
    end

    test "can generate a GRPC service" do
      ctx = %Context{
        package: "foo",
        plugins: ["grpc"],
        global_type_mapping: %{"name.proto" => %{}, "my_dep" => %{}}
      }

      desc = %Google.Protobuf.FileDescriptorProto{
        name: "name.proto",
        dependency: ["my_dep"],
        service: [%Google.Protobuf.ServiceDescriptorProto{name: "my_service"}]
      }

      # We can't compile the generated service module because we haven't loaded GRPC.Service here.
      assert {nil, [%CodeGeneratorResponse.File{} = file]} = Generator.generate(ctx, desc)
      assert file.content =~ "defmodule MyService.Service do"
    end
  end
end
