defmodule Protobuf.Protoc.CLI do
  @moduledoc """
  protoc plugin for generating Elixir code

  See `protoc -h` and protobuf-elixir for details.
  NOTICE: protoc-gen-elixir(this name is important) must be in $PATH

  ## Examples

      $ protoc --elixir_out=./lib your.proto
      $ protoc --elixir_out=plugins=grpc:./lib/ *.proto
      $ protoc -I protos --elixir_out=./lib protos/namespace/*.proto

  Options:
  * --version       Print version of protobuf-elixir
  * --help          Print this help
  """

  @doc false
  def main(["--version"]) do
    {:ok, version} = :application.get_key(:protobuf, :vsn)
    IO.puts(to_string(version))
  end

  def main([opt]) when opt in ["--help", "-h"] do
    IO.puts(@moduledoc)
  end

  def main(_) do
    Protobuf.Protoc.run(fn request ->
      # debug
      # raise inspect(request, limit: :infinity)
      ctx =
        %Protobuf.Protoc.Context{}
        |> parse_params(request.parameter)
        |> Protobuf.Protoc.find_types(request.proto_file)

      files =
        request.proto_file
        |> Enum.filter(fn desc -> Enum.member?(request.file_to_generate, desc.name) end)
        |> Enum.map(fn desc -> Protobuf.Protoc.Generator.generate(ctx, desc) end)

      Google.Protobuf.Compiler.CodeGeneratorResponse.new(file: files)
    end)
  end

  @doc false
  def parse_params(ctx, params_str) when is_binary(params_str) do
    params = String.split(params_str, ",")
    parse_params(ctx, params)
  end

  def parse_params(ctx, ["plugins=" <> plugins | t]) do
    plugins = String.split(plugins, "+")
    ctx = %{ctx | plugins: plugins}
    parse_params(ctx, t)
  end

  def parse_params(ctx, ["gen_descriptors=true" | t]) do
    ctx = %{ctx | gen_descriptors?: true}
    parse_params(ctx, t)
  end

  def parse_params(ctx, _), do: ctx
end
