defmodule Mix.Tasks.Test.Integration do
  use Mix.Task

  @preferred_cli_env :test

  def run(args) do
    IO.puts("==> make clean")
    {_, 0} = System.cmd("make", ["clean"], into: IO.binstream(:stdio, :line))
    test_path = "test/protobuf/protoc"

    IO.puts("==> make gen_test_protos")
    {_, 0} = System.cmd("make", ["gen_test_protos"], into: IO.binstream(:stdio, :line))
    args = ["--only", "integration" | args]
    args = if IO.ANSI.enabled?(), do: ["--color" | args], else: ["--no-color" | args]
    IO.puts("==> mix test #{Enum.join(args, " ")}")
    {_, res} = System.cmd("mix", ["test" | args], into: IO.binstream(:stdio, :line))

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
