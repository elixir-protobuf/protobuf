defmodule Protobuf.Protoc.FilePathTest do
  use ExUnit.Case, async: true

  alias Google.Protobuf.{DescriptorProto, FileDescriptorProto}
  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator

  describe "generate/2 - file naming with module_prefix" do
    test "file path does not respect module_prefix when one_file_per_module is false (default)" do
      ctx = %Context{
        module_prefix: "MyApp.V1",
        package: nil,
        syntax: :proto2,
        one_file_per_module?: false,
        dep_type_mapping: %{},
        global_type_mapping: %{"example.proto" => %{}}
      }

      desc = %FileDescriptorProto{
        name: "example.proto",
        message_type: [
          %DescriptorProto{
            name: "Foo"
          }
        ]
      }

      {_package_level_exts, files} = Generator.generate(ctx, desc)

      assert length(files) == 1
      file = List.first(files)

      assert file.content =~ "defmodule MyApp.V1.Foo do"

      assert file.name == "my_app/v1/example.pb.ex",
             "File path should respect module_prefix. Expected 'my_app/v1/example.pb.ex' to match module 'MyApp.V1.Foo', but got '#{file.name}'"
    end

    test "file path respects module_prefix when one_file_per_module is true" do
      ctx = %Context{
        module_prefix: "MyApp.V1",
        package: nil,
        syntax: :proto2,
        one_file_per_module?: true,
        dep_type_mapping: %{},
        global_type_mapping: %{"example.proto" => %{}}
      }

      desc = %FileDescriptorProto{
        name: "example.proto",
        message_type: [
          %DescriptorProto{
            name: "Foo"
          }
        ]
      }

      {_package_level_exts, files} = Generator.generate(ctx, desc)

      assert length(files) == 1
      file = List.first(files)

      assert file.name == "my_app/v1/foo.pb.ex",
             "Expected 'my_app/v1/foo.pb.ex' but got '#{file.name}'"
    end

    test "file path should respect module_prefix with extensions" do
      ctx = %Context{
        module_prefix: "Protobuf.Protoc.ExtTest",
        package: "ext",
        syntax: :proto2,
        one_file_per_module?: false,
        dep_type_mapping: %{".ext.Foo" => %{type_name: "Protobuf.Protoc.ExtTest.Foo"}},
        global_type_mapping: %{"extension.proto" => %{}}
      }

      desc = %FileDescriptorProto{
        name: "extension.proto",
        message_type: [
          %DescriptorProto{name: "Foo"}
        ]
      }

      {_package_level_exts, files} = Generator.generate(ctx, desc)

      assert length(files) == 1
      file = List.first(files)

      assert file.name == "protobuf/protoc/ext_test/extension.pb.ex",
             "File path should respect module_prefix. Expected 'protobuf/protoc/ext_test/extension.pb.ex' to match module 'Protobuf.Protoc.ExtTest.*', but got '#{file.name}'"
    end
  end
end
