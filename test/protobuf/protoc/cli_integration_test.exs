defmodule Protobuf.Protoc.CLIIntegrationTest do
  use ExUnit.Case, async: true

  # TODO: Remove when we depend on Elixir 1.11+.
  import Protobuf.TestHelpers, only: [tmp_dir: 1, fetch_docs_from_bytecode: 1], warn: false

  alias Protobuf.TestHelpers

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
        "--elixir_opt=transform_module=TestMsg.TransformModule",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      assert [mod] = compile_file_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert mod == Foo.User

      assert mod.transform_module() == TestMsg.TransformModule
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

      modules_and_docs = get_docs_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")
      assert [{Foo.User, docs}] = modules_and_docs
      assert {:docs_v1, _, :elixir, _, module_doc, _, _} = docs
      assert module_doc != :hidden
    end

    test "hides docs when include_docs is not true", %{tmp_dir: tmp_dir, proto_path: proto_path} do
      protoc!([
        "--proto_path=#{tmp_dir}",
        "--elixir_out=#{tmp_dir}",
        "--plugin=./protoc-gen-elixir",
        proto_path
      ])

      modules_and_docs = get_docs_and_clean_modules_on_exit("#{tmp_dir}/user.pb.ex")

      assert [{Foo.User, docs}] = modules_and_docs
      assert {:docs_v1, _, :elixir, _, :hidden, _, _} = docs
    end

    defp get_docs_and_clean_modules_on_exit(path) do
      Code.put_compiler_option(:docs, true)

      modules_and_docs =
        path
        |> Code.compile_file()
        |> Enum.map(fn {mod, bytecode} ->
          {mod, fetch_docs_from_bytecode(bytecode)}
        end)

      on_exit(fn ->
        modules_and_docs
        |> Enum.map(fn {mod, _docs} -> mod end)
        |> TestHelpers.purge_modules()
      end)

      modules_and_docs
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

  test "multiple extensions defined in different scopes", %{tmp_dir: tmp_dir} do
    proto_path_base = Path.join(tmp_dir, "base.proto")
    proto_path_ext1 = Path.join(tmp_dir, "ext1.proto")
    proto_path_ext2 = Path.join(tmp_dir, "ext2.proto")

    File.write!(proto_path_base, """
    // base.proto
    syntax = "proto2";
    package bugs;

    message Base {
      optional string name = 1;
      extensions 100 to max;
    }
    """)

    File.write!(proto_path_ext1, """
    // ext1.proto
    syntax = "proto2";
    import "base.proto";
    package bugs;

    extend Base {
      optional string top_first_name = 111;
    }

    message Ext1 {
      extend Base {
        optional string first_name = 101;
      }
    }
    """)

    File.write!(proto_path_ext2, """
    // ext2.proto
    syntax = "proto2";
    import "base.proto";
    package bugs;

    extend Base {
      optional string top_last_name = 112;
    }

    message Ext2 {
      extend Base {
        optional string first_name = 102;
      }
    }
    """)

    protoc!([
      "--proto_path=#{tmp_dir}",
      "--elixir_out=#{tmp_dir}",
      "--plugin=./protoc-gen-elixir",
      proto_path_base,
      proto_path_ext1,
      proto_path_ext2
    ])

    assert [Bugs.Base = base_mod] =
             compile_file_and_clean_modules_on_exit("#{tmp_dir}/base.pb.ex")

    assert [Bugs.Ext1, Bugs.Ext1.PbExtension] =
             compile_file_and_clean_modules_on_exit("#{tmp_dir}/ext1.pb.ex")

    assert [Bugs.Ext2, Bugs.Ext2.PbExtension] =
             compile_file_and_clean_modules_on_exit("#{tmp_dir}/ext2.pb.ex")

    assert [Bugs.PbExtension] =
             compile_file_and_clean_modules_on_exit("#{tmp_dir}/bugs/pb_extension.pb.ex")

    message = struct!(Bugs.Base, name: "Richard")

    message = base_mod.put_extension(message, Bugs.PbExtension, :top_first_name, "TFN")
    assert base_mod.get_extension(message, Bugs.PbExtension, :top_first_name) == "TFN"

    message = base_mod.put_extension(message, Bugs.PbExtension, :top_last_name, "TLN")
    assert base_mod.get_extension(message, Bugs.PbExtension, :top_last_name) == "TLN"

    message = base_mod.put_extension(message, Bugs.Ext1.PbExtension, :first_name, "Ext1 FN")
    assert base_mod.get_extension(message, Bugs.Ext1.PbExtension, :first_name) == "Ext1 FN"

    message = base_mod.put_extension(message, Bugs.Ext2.PbExtension, :first_name, "Ext2 FN")
    assert base_mod.get_extension(message, Bugs.Ext2.PbExtension, :first_name) == "Ext2 FN"
  end

  test "generates documentation tags from comments", %{tmp_dir: tmp_dir} do
    proto_path_one = Path.join(tmp_dir, "one.proto")
    proto_path_two = Path.join(tmp_dir, "two.proto")

    File.write!(proto_path_one, """
    syntax = "proto3";

    package tests;

    // This is the comment for module One
    message One {
      // Comment about optional name field
      optional string name = 1;

      // Here is a nested message for One
      message NestedOne {
        optional string name = 1;
      }

      // Field referencing nested message
      NestedOne nested_one = 2;
    }
    """)

    File.write!(proto_path_two, """
    syntax = "proto3";

    import "one.proto";

    package tests;

    // This enum represents days of the week.
    //
    // It is a multi line description.
    enum TestEnum {
      // Monday is the first day
      MONDAY = 0;
      // Tuesday the second
      TUESDAY = 1;
    }

    // This is a message that might be sent somewhere.
    message Request {
      // An enum of colors
      enum Color {
        RED = 0;
        GREEN = 1; // My favorite color!
        BLUE = 2;
      }
      //  optional imp.ImportedMessage imported_message = 2;
      optional Color hue = 3;  // no default
      optional One one = 4;

      // This is a map field. It will generate map[int32]string.
      map<int32, string> name_mapping = 14;
    }
    """)

    protoc!([
      "--proto_path=#{tmp_dir}",
      "--elixir_out=#{tmp_dir}",
      "--plugin=./protoc-gen-elixir",
      "--elixir_opt=include_docs=true",
      proto_path_one,
      proto_path_two
    ])

    elixir_one = File.read!("#{tmp_dir}/one.pb.ex")
    elixir_two = File.read!("#{tmp_dir}/two.pb.ex")

    assert elixir_one =~ """
           defmodule Tests.One do
             @moduledoc \"\"\"
             This is the comment for module One
             \"\"\"
           """

    assert elixir_one =~ """
           defmodule Tests.One.NestedOne do
             @moduledoc \"\"\"
             Here is a nested message for One
             \"\"\"
           """

    assert elixir_two =~ """
           defmodule Tests.TestEnum do
             @moduledoc \"\"\"
             This enum represents days of the week.

             It is a multi line description.
             \"\"\"
           """

    assert elixir_two =~ """
           defmodule Tests.Request do
             @moduledoc \"\"\"
             This is a message that might be sent somewhere.
             \"\"\"
           """

    assert elixir_two =~ """
           defmodule Tests.Request.Color do
             @moduledoc \"\"\"
             An enum of colors
             \"\"\"
           """
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
      TestHelpers.purge_modules(modules)
    end)

    modules
  end
end
