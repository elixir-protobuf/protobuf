defmodule Mix.Tasks.Test.Integration do
  use Mix.Task

  @preferred_cli_env :test

  def run(args) do
    IO.puts("==> make clean")
    {_, 0} = System.cmd("make", ["clean"], into: IO.binstream(:stdio, :line))

    IO.puts("==> make gen-protos")
    {_, 0} = System.cmd("make", ["gen-protos"], into: IO.binstream(:stdio, :line))
    args = ["--only", "integration" | args]
    args = if IO.ANSI.enabled?(), do: ["--color" | args], else: ["--no-color" | args]
    IO.puts("==> mix test #{Enum.join(args, " ")}")
    {_, res} = System.cmd("mix", ["test" | args], into: IO.binstream(:stdio, :line))

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
