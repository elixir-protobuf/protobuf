defmodule Protobuf.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :protobuf,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     escript: escript(),

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
    [{:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
     {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp escript do
    [main_module: Protobuf.Protoc.CLI,
     name: "protoc-gen-elixir",
     app: nil]
  end

  defp description do
    "A pure Elixir implementation of Google Protobuf."
  end

  defp package do
    [maintainers: ["Tony Han"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/tony612/protobuf-elixir"},
     files: ~w(mix.exs README.md lib config LICENSE)]
  end

end
