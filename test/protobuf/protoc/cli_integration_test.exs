defmodule Protobuf.Protoc.CLIIntegrationTest do
  use ExUnit.Case, async: true

  # TODO: Remove when we depend on Elixir 1.11+.
  import Protobuf.TestHelpers, only: [tmp_dir: 1], warn: false

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
