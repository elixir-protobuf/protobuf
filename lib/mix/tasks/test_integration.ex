defmodule Mix.Tasks.Test.Integration do
  use Mix.Task

  @preferred_cli_env :test

  def run(args) do
    IO.puts("==> mix escript.build")
    {_, 0} = System.cmd("mix", ["escript.build"], into: IO.binstream(:stdio, :line))
    test_path = "test/protobuf/protoc"

    args1 = [
      "-I",
      "#{test_path}/proto",
      "--elixir_out=#{test_path}/proto_gen",
      "--plugin=protoc-gen-elixir=protoc-gen-elixir",
      "#{test_path}/proto/test.proto"
    ]

    IO.puts("==> protoc #{Enum.join(args1, " ")}")
    {_, 0} = System.cmd("protoc", args1, into: IO.binstream(:stdio, :line))
    args = ["--only", "integration" | args]
    args = if IO.ANSI.enabled?(), do: ["--color" | args], else: ["--no-color" | args]
    IO.puts("==> mix test #{Enum.join(args, " ")}")
    {_, res} = System.cmd("mix", ["test" | args], into: IO.binstream(:stdio, :line))

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
