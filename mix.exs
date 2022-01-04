defmodule Protobuf.Mixfile do
  use Mix.Project

  @source_url "https://github.com/elixir-protobuf/protobuf"
  @version "0.9.0"
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
        conformance_test: :test
      ],
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

  defp elixirc_paths(:test), do: ["lib", "conformance", "test/support", "generated"]
  defp elixirc_paths(_env), do: ["lib"]

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
       tag: "v3.19.1",
       app: false,
       compile: false,
       only: [:dev, :test]}
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
      gen_bootstrap_protos: [&build_escript/1, &gen_bootstrap_protos/1],
      gen_test_protos: [&build_escript/1, &create_generated_dir/1, &gen_test_protos/1],
      test: [
        &build_escript/1,
        &create_generated_dir/1,
        &gen_test_protos/1,
        &gen_google_test_protos/1,
        "test"
      ],
      conformance_test: [
        &build_escript/1,
        &create_generated_dir/1,
        &gen_google_test_protos/1,
        &gen_conformance_protos/1,
        fn _ -> Mix.Task.reenable("escript.build") end,
        &build_escript/1,
        &run_conformance_tests/1
      ],
      gen_bench_protos: [&build_escript/1, &gen_bench_protos/1],
      build_conformance_runner: &build_conformance_runner/1
    ]
  end

  # We need to do this in a separate shell because we want to compile "from scratch" when we do
  # things like running tests, since we usually generated some .pb.ex files on the fly and stick
  # them in a directory. That directory is in the elixirc_paths, but no files are there *before*
  # we compile the project the first time to run escript.build. It's a chicken and egg problem.
  # This way, we compile the project first to generate the escript and we do so in a subshell.
  # Then, we generate the .pb.ex files. Then we actually run stuff (like "mix test"), so that
  # compilation happens again "from scratch" and it picks up the generated files. This fixes at
  # least one problem related to extensions, because extensions are discovered by looking at
  # :application.get_key(app, :modules), and if modules are added after the first compilation and
  # loading pass, then they don't get picked up in there.
  # There is very likely a better way to do this, but this works for now.
  defp build_escript(_args) do
    # We wanna pass down MIX_ENV here because we want escript.build to happen in the same Mix
    # environment of whoever is calling this function.
    Mix.shell().cmd("mix escript.build", env: %{"MIX_ENV" => Atom.to_string(Mix.env())})
  end

  defp create_generated_dir(_args) do
    File.mkdir_p!("generated")
  end

  # These files are necessary to bootstrap the protoc-gen-elixir plugin that we generate. They
  # are committed to version control.
  defp gen_bootstrap_protos(_args) do
    proto_src = path_in_protobuf_source(["src", "google", "protobuf"])

    protoc!("-I \"#{proto_src}\" --elixir_out=lib/google", ["descriptor.proto"])
    protoc!("-I \"#{proto_src}\" --elixir_out=lib/google", ["compiler/plugin.proto"])
    protoc!("-I src --elixir_out=lib", ["elixirpb.proto"])

    Mix.Task.rerun("format", ["lib/elixirpb.pb.ex", "lib/google/**/*.pb.ex"])
  end

  defp gen_test_protos(_args) do
    proto_src = path_in_protobuf_source(["src"])

    protoc!(
      "-I #{proto_src} -I src -I test/protobuf/protoc/proto --elixir_out=generated",
      ["test/protobuf/protoc/proto/extension.proto"]
    )

    protoc!(
      "-I test/protobuf/protoc/proto --elixir_opt=package_prefix=my --elixir_out=generated",
      ["test/protobuf/protoc/proto/test.proto"]
    )

    protoc!(
      "-I test/protobuf/protoc/proto -I #{path_in_protobuf_source("src")} --elixir_out=generated --elixir_opt=gen_descriptors=true",
      ["test/protobuf/protoc/proto/custom_options.proto"]
    )

    Mix.Task.rerun("format", ["generated/**/*.pb.ex"])
  end

  defp gen_bench_protos(_args) do
    proto_bench = path_in_protobuf_source(["benchmarks"])
    protoc!("-I \"#{proto_bench}\" --elixir_out=./bench/lib", benchmark_proto_files())
    Mix.Task.rerun("format", ["bench/**/*.pb.ex"])
  end

  defp gen_google_test_protos(_args) do
    proto_root = path_in_protobuf_source(["src"])

    files = ~w(
      google/protobuf/any.proto
      google/protobuf/duration.proto
      google/protobuf/empty.proto
      google/protobuf/field_mask.proto
      google/protobuf/struct.proto
      google/protobuf/timestamp.proto
      google/protobuf/wrappers.proto
      google/protobuf/test_messages_proto2.proto
      google/protobuf/test_messages_proto3.proto
    )

    protoc!("--elixir_out=./generated -I \"#{proto_root}\"", files)

    Mix.Task.rerun("format", ["generated/**/*.pb.ex"])
  end

  defp gen_conformance_protos(_args) do
    proto_src = path_in_protobuf_source(["conformance"])
    protoc!("--elixir_out=./generated -I \"#{proto_src}\"", ["conformance.proto"])
    Mix.Task.rerun("format", ["generated/**/*.pb.ex"])
  end

  defp path_in_protobuf_source(path) do
    Path.join([Mix.Project.deps_paths().google_protobuf | List.wrap(path)])
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

  defp protoc!(args, files_to_generate) when is_binary(args) and is_list(files_to_generate) do
    cmd!("protoc --plugin=./protoc-gen-elixir #{args} #{Enum.join(files_to_generate, " ")}")
  end

  defp run_conformance_tests(args) do
    {options, _args} = OptionParser.parse!(args, strict: [runner: :string, verbose: :boolean])

    runner =
      options
      |> Keyword.get_lazy(:runner, fn ->
        path = path_in_protobuf_source("conformance/conformance-test-runner")

        if File.exists?(path) do
          Mix.shell().info([:faint, "Using default conformance runner: ", :reset, path])
          path
        else
          Mix.raise("""
          No --runner option was passed and we didn't find the default runner we use,
          which should be in: #{path}

          If you want to build the conformance runner locally from the Google Protobuf
          dependency of this library, run:

              mix build_conformance_runner

          """)
        end
      end)
      |> Path.expand()

    verbose? = Keyword.get(options, :verbose, false)

    args = [
      "--enforce_recommended",
      "--failure_list",
      "conformance/exemptions.txt",
      "./conformance/runner.sh"
    ]

    args = if verbose?, do: ["--verbose"] ++ args, else: args
    cmd!("#{runner} #{Enum.join(args, " ")}")
  end

  defp build_conformance_runner(_args) do
    File.cd!(Mix.Project.deps_paths().google_protobuf, fn ->
      cmd!("./autogen.sh")
      cmd!("./configure")
      cmd!("make -C ./src protoc")
      cmd!("make -C ./conformance conformance-test-runner")
    end)
  end

  defp cmd!(cmd) do
    Mix.shell().info([:cyan, "Running: ", :reset, cmd])

    case Mix.shell().cmd(cmd) do
      0 -> :ok
      other -> Mix.raise("Command exited with non-zero status: #{other}")
    end
  end
end
