defmodule Protobuf.Mixfile do
  use Mix.Project

  @version "0.5.4"

  def project do
    [
      app: :protobuf,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      aliases: ["test.integration": &test_integration/1],
      description: description(),
      package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:eqc_ex, "~> 1.4", only: :test}
    ]
  end

  defp escript do
    [main_module: Protobuf.Protoc.CLI, name: "protoc-gen-elixir", app: nil]
  end

  defp description do
    "A pure Elixir implementation of Google Protobuf."
  end

  defp package do
    [
      maintainers: ["Bing Han"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tony612/protobuf-elixir"},
      files: ~w(mix.exs README.md lib config LICENSE priv/templates .formatter.exs)
    ]
  end

  def test_integration(args) do
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
