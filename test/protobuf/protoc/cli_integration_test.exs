defmodule Protobuf.Protoc.CLIIntegrationTest do
  use ExUnit.Case, async: true

  # TODO: Remove when we depend on Elixir 1.11+.
  import Protobuf.TestHelpers, only: [tmp_dir: 1, fetch_docs_from_bytecode: 2], warn: false

  if Version.match?(System.version(), ">= 1.11.0") do
    @moduletag :tmp_dir
  else
    setup :tmp_dir
  end

  describe "with simple user.proto file" do
    setup %{tmp_dir: tmp_dir} do
      proto_path = Path.join(tmp_dir, "user.proto")

      File.write!(proto_path, """
      syntax = "proto3";

      package foo;

      message User {
        string email = 1;
      }
      """)

      %{proto_path: proto_path}
    end

    test "simple compilation", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert mod == Foo.User
    end

    test "transform_module option", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--elixir_opt=transform_module=MyTransformer",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert mod == Foo.User

      assert mod.transform_module() == MyTransformer
    end

    test "gen_descriptors option", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--elixir_opt=gen_descriptors=true",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert mod == Foo.User

      assert %Google.Protobuf.DescriptorProto{} = descriptor = mod.descriptor()
      assert descriptor.name == "User"
    end

    test "include_docs option", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--elixir_opt=include_docs=true",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      modules_and_docs =
        "#{tmp_dir}/user.pb.ex"
        |> Code.compile_file()
        |> Enum.map(fn {module, bytecode} -> {mod, fetch_docs_from_bytecode(module, bytecode)} end)

      on_exit(fn ->
        for {module, _} <- modules_and_docs do
          :code.delete(module)
          :code.purge(module)
        end
      end)

      for {_module, docs} <- modules_and_docs do
        assert {:docs_v1, _, :elixir, _, :none, _, _} = docs
      end
    end

    test "package_prefix mypkg", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--elixir_opt=package_prefix=mypkg",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert mod == Mypkg.Foo.User
    end

    # Regression test for https://github.com/elixir-protobuf/protobuf/issues/252
    test "with lowercase enum", %{tmp_dir: tmp_dir} do
      proto_path = Path.join(tmp_dir, "lowercase_enum.proto")

      File.write!(proto_path, """
      syntax = "proto3";

      enum lowercaseEnum {
        NOT_SET = 0;
        SET = 1;
      }

      message UsesLowercaseEnum {
        lowercaseEnum e = 1;
      }
      """)

      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [LowercaseEnum, UsesLowercaseEnum] =
               compile_file_and_clean_modules_on_exit("#{tmp_dir}/lowercase_enum.pb.ex")
    end
  end

  # Regression test for https://github.com/elixir-protobuf/protobuf/issues/242
  test "with external packages and the package_prefix option", %{tmp_dir: tmp_dir} do
    proto_path = Path.join(tmp_dir, "timestamp_wrapper.proto")

    File.write!(proto_path, """
    syntax = "proto3";

    import "google/protobuf/timestamp.proto";

    message TimestampWrapper {
      google.protobuf.Timestamp some_time = 1;
    }
    """)

    protoc!([
      "--proto_path=#{tmp_dir}",
      "--proto_path=#{Mix.Project.deps_paths().google_protobuf}/src",
      "--elixir_out=#{tmp_dir}",
      "--elixir_opt=package_prefix=my_type",
      "--plugin=./protoc-gen-elixir",
      proto_path
    ])

    assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/timestamp_wrapper.pb.ex")

    assert mod == MyType.TimestampWrapper
    assert Map.fetch!(mod.__message_props__().field_props, 1).type == Google.Protobuf.Timestamp
  end

  @tag :skip
  test "extensions defined and used in the same protoc call", %{tmp_dir: tmp_dir} do
    proto_path = Path.join(tmp_dir, "extensions.proto")

    File.write!(proto_path, """
    syntax = "proto3";

    package my_pkg;

    import "google/protobuf/descriptor.proto";

    extend google.protobuf.MessageOptions {
      string notes = 51800;
    }

    message MessageWithCustomOptions {
      option (notes) = "This message is cool";
    }
    """)

    protoc!([
      "--proto_path=#{tmp_dir}",
      "--proto_path=#{Mix.Project.deps_paths().google_protobuf}/src",
      "--elixir_out=#{tmp_dir}",
      "--elixir_opt=gen_descriptors=true",
      "--plugin=./protoc-gen-elixir",
      proto_path
    ])

    assert [message_mod, extension_mod] =
             compile_file_and_clean_modules_on_exit("#{tmp_dir}/extensions.pb.ex")

    assert %Google.Protobuf.MessageOptions{} = options = message_mod.descriptor().options
    assert options.__pb_extensions__ == %{{extension_mod, :notes} => "This messge is cool"}
  end

  defp protoc!(args) do
    {output, exit_code} = System.cmd("protoc", args, stderr_to_stdout: true)

    assert exit_code == 0, """
    non-zero exit code (#{exit_code}) from protoc invocation. protoc was called as:

      protoc #{Enum.map_join(args, " ", &inspect/1)}

    and the output was:

    #{output}
    """
  end

  defp compile_file_and_clean_modules_on_exit(path) do
    modules =
      path
      |> Code.compile_file()
      |> Enum.map(fn {mod, _bytecode} -> mod end)

    on_exit(fn ->
      Enum.each(modules, fn mod ->
        :code.delete(mod)
        :code.purge(mod)
      end)
    end)

    modules
  end
end
