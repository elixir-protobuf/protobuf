defmodule Protobuf.Protoc.CLITest do
  use ExUnit.Case, async: true
  alias Protobuf.Protoc.{CLI, Context}

  test "parse_params/2 parse plugins" do
    ctx = %Context{}
    ctx = CLI.parse_params(ctx, "plugins=grpc")
    assert ctx == %Context{plugins: ["grpc"]}
  end
end
