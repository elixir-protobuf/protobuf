defmodule Protobuf.Protoc.CLI do
  @moduledoc """
  `protoc` plugin for generating Elixir code.

  `protoc-gen-elixir` (this name is important) **must** be in `$PATH`. You are not supposed
  to call it directly, but only through `protoc`.

  ## Examples

      $ protoc --elixir_out=./lib your.proto
      $ protoc --elixir_out=plugins=grpc:./lib/ *.proto
      $ protoc -I protos --elixir_out=./lib protos/namespace/*.proto

  Options:

    * --version       Print version of protobuf-elixir
    * --help (-h)     Print this help

  """

  alias Protobuf.Protoc.Context

  # Entrypoint for the escript (protoc-gen-elixir).
  @doc false
  @spec main([String.t()]) :: :ok
  def main(args)

  def main(["--version"]) do
    {:ok, version} = :application.get_key(:protobuf, :vsn)
    IO.puts(version)
  end

  def main([opt]) when opt in ["--help", "-h"] do
    IO.puts(@moduledoc)
  end

  # When called through protoc, all input is passed through stdin.
  def main([] = _args) do
    Protobuf.load_extensions()

    # See https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI.
    :io.setopts(:standard_io, encoding: :latin1)

    # Read the standard input that protoc feeds us.
    bin = IO.binread(:stdio, :all)

    request = Protobuf.Decoder.decode(bin, Google.Protobuf.Compiler.CodeGeneratorRequest)

    ctx =
      %Context{}
      |> parse_params(request.parameter || "")
      |> find_types(request.proto_file)

    files =
      for desc <- request.proto_file,
          desc.name in request.file_to_generate,
          do: Protobuf.Protoc.Generator.generate(ctx, desc)

    response = Google.Protobuf.Compiler.CodeGeneratorResponse.new(file: files)

    IO.binwrite(Protobuf.Encoder.encode(response))
  end

  def main(_args) do
    fail_and_halt("Invalid arguments. See protoc-gen-elixir --help.")
  end

  # Made public for testing.
  @doc false
  def parse_params(%Context{} = ctx, params_str) when is_binary(params_str) do
    params_str
    |> String.split(",")
    |> Enum.reduce(ctx, &parse_param/2)
  end

  defp parse_param("plugins=" <> plugins, ctx) do
    %Context{ctx | plugins: String.split(plugins, "+")}
  end

  defp parse_param("gen_descriptors=" <> value, ctx) do
    case value do
      "true" ->
        %Context{ctx | gen_descriptors?: true}

      other ->
        fail_and_halt(
          "Invalid value for gen_descriptors option, expected \"true\", got: #{inspect(other)}"
        )
    end
  end

  defp parse_param("package_prefix=" <> package, ctx) do
    if package == "" do
      fail_and_halt("package_prefix can't be empty")
    else
      %Context{ctx | package_prefix: package}
    end
  end

  defp parse_param("transform_module=" <> module, ctx) do
    %Context{ctx | transform_module: Module.concat([module])}
  end

  defp parse_param(_unknown, ctx) do
    ctx
  end

  defp fail_and_halt(message) do
    IO.puts(:stderr, message)
    System.halt(1)
  end

  # Made public for testing.
  @doc false
  def find_types(%Context{} = ctx, descs) do
    global_type_mapping =
      Map.new(descs, fn desc ->
        {desc.name, find_types_in_proto(ctx, desc)}
      end)

    %Context{ctx | global_type_mapping: global_type_mapping}
  end

  # Made public for testing.
  @doc false
  def find_types_in_proto(%Context{} = ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    ctx =
      %Protobuf.Protoc.Context{
        namespace: [],
        package_prefix: ctx.package_prefix,
        package: desc.package
      }
      |> Protobuf.Protoc.Context.custom_file_options_from_file_desc(desc)

    find_types_in_proto(_types = %{}, ctx, desc.message_type ++ desc.enum_type)
  end

  defp find_types_in_proto(types, ctx, descs) when is_list(descs) do
    Enum.reduce(descs, types, fn desc, acc ->
      find_types_in_proto(acc, ctx, desc)
    end)
  end

  defp find_types_in_proto(types, ctx, %Google.Protobuf.DescriptorProto{name: name} = desc) do
    new_ctx = Map.update!(ctx, :namespace, &(&1 ++ [name]))

    types
    |> update_types(ctx, name)
    |> find_types_in_proto(new_ctx, desc.enum_type)
    |> find_types_in_proto(new_ctx, desc.nested_type)
  end

  defp find_types_in_proto(types, ctx, %Google.Protobuf.EnumDescriptorProto{name: name}) do
    update_types(types, ctx, name)
  end

  defp update_types(types, %{namespace: ns, package: pkg} = ctx, name) do
    type_name = Protobuf.Protoc.Generator.Util.mod_name(ctx, ns ++ [name])

    mapping_name =
      ([pkg] ++ ns ++ [name])
      |> Enum.reject(&is_nil/1)
      |> Enum.join(".")

    Map.put(types, "." <> mapping_name, %{type_name: type_name})
  end
end
