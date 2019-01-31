defmodule Protobuf.Protoc.Generator.ServiceTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Service, as: Generator

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
        Google.Protobuf.MethodDescriptorProto.new(
          name: "MethodA",
          input_type: ".foo.Input0",
          output_type: ".foo.Output0"
        ),
        Google.Protobuf.MethodDescriptorProto.new(
          name: "MethodB",
          input_type: ".foo.Input1",
          output_type: ".foo.Output1",
          client_streaming: true
        ),
        Google.Protobuf.MethodDescriptorProto.new(
          name: "MethodC",
          input_type: ".foo.Input2",
          output_type: ".foo.Output2",
          server_streaming: true
        ),
        Google.Protobuf.MethodDescriptorProto.new(
          name: "MethodD",
          input_type: ".foo.Input3",
          output_type: ".foo.Output3",
          client_streaming: true,
          server_streaming: true
        )
      ]
    }

    msg = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.ServiceFoo.Service do\n"
    assert msg =~ "use GRPC.Service, name: \"foo.ServiceFoo\"\n"
    assert msg =~ "rpc :MethodA, Foo.Input0, Foo.Output0\n"
    assert msg =~ "rpc :MethodB, stream(Foo.Input1), Foo.Output1\n"
    assert msg =~ "rpc :MethodC, Foo.Input2, stream(Foo.Output2)\n"
    assert msg =~ "rpc :MethodD, stream(Foo.Input3), stream(Foo.Output3)\n"
  end
end
