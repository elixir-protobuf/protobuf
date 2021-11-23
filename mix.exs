defmodule Protobuf.Mixfile do
  use Mix.Project

  @source_url "https://github.com/elixir-protobuf/protobuf"
  @version "0.8.0"
  @description "A pure Elixir implementation of Google Protobuf."

  def project do
    [
      app: :protobuf,
      version: @version,
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      dialyzer: [plt_add_apps: [:mix, :jason]],
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        conformance_tests: :conformance
      ],
      deps: deps(),
      escript: escript(Mix.env()),
      description: @description,
      package: package(),
      docs: docs(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "test/protobuf/protoc/proto_gen"]
  defp elixirc_paths(:conformance), do: ["lib", "conformance", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:jason, "~> 1.2", optional: true},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:stream_data, "~> 0.5.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.14.4", only: :test},
      {:google_protobuf,
       github: "protocolbuffers/protobuf",
       ref: "61e0395c89fe520ae7569aea6838313195e05ec5",
       app: false,
       compile: false,
       only: [:dev, :test]}
    ]
  end

  defp escript(:conformance) do
    [main_module: Conformance.Protobuf.Runner, name: "conformance_client"]
  end

  defp escript(_env) do
    [main_module: Protobuf.Protoc.CLI, name: "protoc-gen-elixir"]
  end

  defp package do
    [
      maintainers: ["Bing Han", "Andrea Leopardi"],
      licenses: ["MIT"],
      files: ~w(
        mix.exs
        README.md
        lib/google
        lib/protobuf
        lib/*.ex
        src
        LICENSE
        priv/templates
        .formatter.exs
      ),
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}"
    ]
  end

  defp aliases do
    [
      test: ["escript.build", "test"],
      # This needs to be automated.
      gen_test_protos: [
        "escript.build",
        "cmd protoc -I src -I test/protobuf/protoc/proto --elixir_out=test/protobuf/protoc/proto_gen --plugin=./protoc-gen-elixir test/protobuf/protoc/proto/extension.proto",
        "cmd protoc -I src -I test/protobuf/protoc/proto --elixir_out=test/protobuf/protoc/proto_gen --elixir_opt=package_prefix=my --plugin=./protoc-gen-elixir test/protobuf/protoc/proto/test.proto",
        "format"
      ],
      gen_bootstrap_protos: &gen_bootstrap_protos/1,
      # $PROTO_BENCH should be your local path to https://github.com/google/protobuf/tree/master/benchmarks
      gen_bench_protos: [
        "escript.build",
        require_env_variable("PROTO_BENCH"),
        "cmd protoc -I $PROTO_BENCH --elixir_out=bench/lib --plugin=./protoc-gen-elixir #{Enum.join(benchmark_proto_files(), " ")}",
        "format"
      ],
      gen_conformance_protos: [],
      conformance_tests: ["escript.build", &run_conformance_tests/1]
    ]
  end

  # These files are necessary to bootstrap the protoc-gen-elixir plugin that we generate. They
  # are committed to version control.
  defp gen_bootstrap_protos(_args) do
    proto_src = Path.join([Mix.Project.deps_paths().google_protobuf, "src", "google", "protobuf"])

    Mix.Task.run("escript.build")

    Mix.shell().cmd(
      "protoc -I \"#{proto_src}\" --elixir_out=./lib/google --plugin=./protoc-gen-elixir descriptor.proto"
    )

    Mix.shell().cmd(
      "protoc -I \"#{proto_src}\" --elixir_out=./lib/google --plugin=./protoc-gen-elixir compiler/plugin.proto"
    )

    Mix.shell().cmd(
      "protoc -I src --elixir_out=./lib --plugin=./protoc-gen-elixir elixirpb.proto"
    )

    Mix.Task.rerun("format", ["lib/elixirpb.pb.ex", "lib/google/**/*.pb.ex"])
  end

  defp require_env_variable(var) do
    fn _args ->
      System.get_env("#{var}") || Mix.raise("$#{var} not set")
    end
  end

  defp benchmark_proto_files do
    [
      "benchmarks.proto",
      "datasets/google_message1/proto3/benchmark_message1_proto3.proto",
      "datasets/google_message1/proto2/benchmark_message1_proto2.proto",
      "datasets/google_message2/benchmark_message2.proto",
      "datasets/google_message3/benchmark_message3.proto",
      "datasets/google_message3/benchmark_message3_1.proto",
      "datasets/google_message3/benchmark_message3_2.proto",
      "datasets/google_message3/benchmark_message3_3.proto",
      "datasets/google_message3/benchmark_message3_4.proto",
      "datasets/google_message3/benchmark_message3_5.proto",
      "datasets/google_message3/benchmark_message3_6.proto",
      "datasets/google_message3/benchmark_message3_7.proto",
      "datasets/google_message3/benchmark_message3_8.proto",
      "datasets/google_message4/benchmark_message4.proto",
      "datasets/google_message4/benchmark_message4_1.proto",
      "datasets/google_message4/benchmark_message4_2.proto",
      "datasets/google_message4/benchmark_message4_3.proto"
    ]
  end

  defp run_conformance_tests(args) do
    {options, _args} = OptionParser.parse!(args, strict: [runner: :string, verbose: :boolean])

    runner =
      options
      |> Keyword.get_lazy(:runner, fn -> Mix.raise("Missing required option --runner") end)
      |> Path.expand()

    verbose? = Keyword.get(options, :verbose, false)

    args = [
      "--enforce_recommended",
      "--failure_list",
      "conformance/exemptions.txt",
      "./conformance_client"
    ]

    args = if verbose?, do: ["--verbose"] ++ args, else: args

    case Mix.shell().cmd("#{runner} #{Enum.join(args, " ")}", stderr_to_stdout: true) do
      0 -> :ok
      other -> Mix.raise("#{runner} exited with non-zero status: #{other}")
    end
  end
end
