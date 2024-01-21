defmodule Protobuf.Protoc.Generator.ServiceTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Service, as: Generator
  alias Protobuf.Protoc.Generator.Util

  test "generate/2 generates services" do
    ctx = %Context{
      package: "foo",
      dep_type_mapping: %{
        ".foo.Input0" => %{type_name: "Foo.Input0"},
        ".foo.Input1" => %{type_name: "Foo.Input1"},
        ".foo.Input2" => %{type_name: "Foo.Input2"},
        ".foo.Input3" => %{type_name: "Foo.Input3"},
        ".foo.Output0" => %{type_name: "Foo.Output0"},
        ".foo.Output1" => %{type_name: "Foo.Output1"},
        ".foo.Output2" => %{type_name: "Foo.Output2"},
        ".foo.Output3" => %{type_name: "Foo.Output3"}
      },
      module_prefix: "Foo"
    }

    desc = %Google.Protobuf.ServiceDescriptorProto{
      name: "ServiceFoo",
      method: [
        %Google.Protobuf.MethodDescriptorProto{
          name: "MethodA",
          input_type: ".foo.Input0",
          output_type: ".foo.Output0"
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "MethodB",
          input_type: ".foo.Input1",
          output_type: ".foo.Output1",
          client_streaming: true
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "MethodC",
          input_type: ".foo.Input2",
          output_type: ".foo.Output2",
          server_streaming: true
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "MethodD",
          input_type: ".foo.Input3",
          output_type: ".foo.Output3",
          client_streaming: true,
          server_streaming: true
        }
      ]
    }

    assert {"Foo.ServiceFoo", msg} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.ServiceFoo.Service do\n"

    assert msg =~
             "use GRPC.Service, name: \"foo.ServiceFoo\", protoc_gen_elixir_version: \"#{Util.version()}\"\n"

    assert msg =~ "rpc :MethodA, Foo.Input0, Foo.Output0\n"
    assert msg =~ "rpc :MethodB, stream(Foo.Input1), Foo.Output1\n"
    assert msg =~ "rpc :MethodC, Foo.Input2, stream(Foo.Output2)\n"
    assert msg =~ "rpc :MethodD, stream(Foo.Input3), stream(Foo.Output3)\n"
  end

  describe "generate/2 include_docs" do
    test "includes service comment for `@moduledoc` when flag is true" do
      test_pb = Protobuf.TestHelpers.read_generated_file("service.pb.ex")

      assert test_pb =~ """
             defmodule My.Test.TestService.Service do
               @moduledoc \"\"\"
               An example test service that has
               a test method. It expects a Request
               and returns a Reply.
               \"\"\"
             """
    end

    test "includes `@moduledoc false` by default" do
      ctx = %Context{include_docs?: false}
      desc = %Google.Protobuf.ServiceDescriptorProto{name: "ServiceFoo"}

      {_module, msg} = Generator.generate(ctx, desc)

      assert msg =~ "@moduledoc false\n"
    end
  end
end
