defmodule Protobuf.Protoc.Generator.ServiceTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Service, as: Generator

  test "generate/2 generates services" do
    ctx = %Context{package: "foo"}
    desc = %Google_Protobuf.ServiceDescriptorProto{name: "ServiceFoo",
      method: [
        %Google_Protobuf.MethodDescriptorProto{name: "MethodA", input_type: "Input0", output_type: "Output0"},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodB", input_type: "Input1", output_type: "Output1", client_streaming: true},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodC", input_type: "Input2", output_type: "Output2", server_streaming: true},
        %Google_Protobuf.MethodDescriptorProto{name: "MethodD", input_type: "Input3", output_type: "Output3", client_streaming: true, server_streaming: true}
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
