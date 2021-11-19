defmodule Mix.Tasks.Protobuf.Conformance do
  use Mix.Task

  @shortdoc "Runs the Google-provided Protobuf conformance test suite"

  @switches [runner: :string, verbose: :boolean]

  @impl true
  def run(args) do
    {options, args} = OptionParser.parse!(args, strict: @switches)

    if args != [] do
      Mix.raise("The protobuf.conformance task does not support any arguments")
    end

    runner =
      options
      |> Keyword.get_lazy(:runner, fn -> Mix.raise("Missing required option --runner") end)
      |> Path.expand()

    verbose? = Keyword.get(options, :verbose, false)

    Mix.Task.run("escript.build")

    args = [
      "--enforce_recommended",
      "--failure_list",
      "conformance/protobuf/exemptions.txt",
      "./conformance_client"
    ]

    args = if verbose?, do: ["--verbose"] ++ args, else: args

    case Mix.shell().cmd("#{runner} #{Enum.join(args, " ")}", stderr_to_stdout: true) do
      0 -> :ok
      other -> Mix.raise("#{runner} exited with non-zero status: #{other}")
    end
  end
end
