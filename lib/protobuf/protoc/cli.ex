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

  # Entrypoint for the escript (protoc-gen-elixir).
  @doc false
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
      %Protobuf.Protoc.Context{}
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
  def parse_params(%Protobuf.Protoc.Context{} = ctx, params_str) when is_binary(params_str) do
    params_str
    |> String.split(",")
    |> Enum.reduce(ctx, &parse_param/2)
  end

  defp parse_param("plugins=" <> plugins, ctx) do
    %{ctx | plugins: String.split(plugins, "+")}
  end

  defp parse_param("gen_descriptors=" <> value, ctx) do
    case value do
      "true" ->
        %{ctx | gen_descriptors?: true}

      other ->
        fail_and_halt(
          "Invalid value for gen_descriptors option, expected \"true\", got: #{inspect(other)}"
        )
    end
  end

  defp parse_param("package_prefix=" <> package, ctx) do
    %{ctx | package_prefix: package}
  end

  defp parse_param("transform_module=" <> module, ctx) do
    %{ctx | transform_module: Module.concat([module])}
  end

  defp parse_param(_unknown, ctx) do
    ctx
  end

  defp fail_and_halt(message) do
    IO.puts(:stderr, message)
    System.halt(1)
  end

  @doc false
  def find_types(ctx, descs) do
    global_type_mapping =
      Enum.reduce(descs, %{}, fn desc, acc ->
        types = find_types_in_proto(ctx, desc)
        Map.put(acc, desc.name, types)
      end)

    %{ctx | global_type_mapping: global_type_mapping}
  end

  @doc false
  def find_types_in_proto(ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    ctx =
      %Protobuf.Protoc.Context{
        namespace: [],
        package_prefix: ctx.package_prefix,
        package: desc.package
      }
      |> Protobuf.Protoc.Context.cal_file_options(desc.options)

    %{}
    |> find_types_in_proto(ctx, desc.message_type)
    |> find_types_in_proto(ctx, desc.enum_type)
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
    type_name =
      ctx
      |> Protobuf.Protoc.Generator.Util.prefixed_name()
      |> join_names(ns, name)
      |> Protobuf.Protoc.Generator.Util.normalize_type_name()

    Map.put(types, "." <> join_names(pkg, ns, name), %{type_name: type_name})
  end

  defp join_names(pkg, ns, name) do
    ns_str = Protobuf.Protoc.Generator.Util.join_name(ns)

    [pkg, ns_str, name]
    |> Enum.filter(&(&1 && &1 != ""))
    |> Enum.join(".")
  end
end
