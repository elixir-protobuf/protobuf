defmodule Protobuf.Mixfile do
  use Mix.Project

  @version "0.7.1"

  def project do
    [
      app: :protobuf,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      description: description(),
      package: package()
    ]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:eqc_ex, "~> 1.4", only: [:dev, :test]}
    ]
  end

  defp escript do
    [main_module: Protobuf.Protoc.CLI, name: "protoc-gen-elixir"]
  end

  defp description do
    "A pure Elixir implementation of Google Protobuf."
  end

  defp package do
    [
      maintainers: ["Bing Han"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tony612/protobuf-elixir"},
      files:
        ~w(mix.exs README.md lib/google lib/protobuf lib/protobuf.ex src config LICENSE priv/templates .formatter.exs)
    ]
  end
end
