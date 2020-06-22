defmodule ProtoBench.MixProject do
  use Mix.Project

  def project do
    [
      app: :proto_bench,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: true,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:protobuf, path: ".."},
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_html, "~> 1.0", only: :dev}
    ]
  end
end
