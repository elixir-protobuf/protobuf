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
      preferred_cli_env: [coveralls: :test, "coveralls.html": :test],
      deps: deps(),
      escript: escript(),
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
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:jason, "~> 1.2", optional: true},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:stream_data, "~> 0.5.0", only: [:dev, :test]},
      {:excoveralls, "~> 0.14.4", only: :test}
    ]
  end

  defp escript do
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
      gen_test_protos: [
        "escript.build",
        "cmd protoc -I src -I test/protobuf/protoc/proto --elixir_out=test/protobuf/protoc/proto_gen --plugin=./protoc-gen-elixir test/protobuf/protoc/proto/extension.proto",
        "cmd protoc -I src -I test/protobuf/protoc/proto --elixir_out=test/protobuf/protoc/proto_gen --elixir_opt=package_prefix=my --plugin=./protoc-gen-elixir test/protobuf/protoc/proto/test.proto",
        "cmd protoc -I src --elixir_out=lib --plugin=./protoc-gen-elixir elixirpb.proto"
      ],
      # $PROTO_LIB should be your local path to https://github.com/google/protobuf/tree/master/src/google/protobuf
      gen_google_protos: [
        "escript.build",
        require_env_variable("PROTO_LIB"),
        "cmd protoc -I $PROTO_LIB --elixir_out=lib/google --plugin=./protoc-gen-elixir descriptor.proto",
        "cmd protoc -I $PROTO_LIB --elixir_out=lib/google --plugin=./protoc-gen-elixir compiler/plugin.proto"
      ],
      # $PROTO_BENCH should be your local path to https://github.com/google/protobuf/tree/master/benchmarks
      gen_bench_protos: [
        "escript.build",
        require_env_variable("PROTO_BENCH"),
        "cmd protoc -I $PROTO_BENCH --elixir_out=bench/lib --plugin=./protoc-gen-elixir #{Enum.join(benchmark_proto_files(), " ")}"
      ]
    ]
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
end
