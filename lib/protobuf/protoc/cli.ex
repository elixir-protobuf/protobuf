defmodule Protobuf.Protoc.CLI do
  @moduledoc false

  def main(["--version"]) do
    {:ok, version} = :application.get_key(:protobuf, :vsn)
    IO.puts to_string(version)
  end

  def main([opt]) when opt in ["--help", "-h"] do
    IO.puts """
    protoc plugin for generating Elixir code

    See `protoc -h` and protobuf-elixir for details.
    NOTICE: protoc-gen-elixir(this name is important) must be in $PATH

    Examples:
      $ protoc --elixir_out=./lib your.proto
      $ protoc --elixir_out=plugins=grpc:./lib/ *.proto
      $ protoc -I protos --elixir_out=./lib protos/namespace/*.proto

    Options:
    --version       Print version of protobuf-elixir
    """
  end

  def main(_) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI
    :io.setopts(:standard_io, encoding: :latin1)
    bin = IO.binread(:all)
    request = Protobuf.Decoder.decode(bin, Google.Protobuf.Compiler.CodeGeneratorRequest)
    # debug
    # raise inspect(request, limit: :infinity)

    ctx =
      %Protobuf.Protoc.Context{}
      |> parse_params(request.parameter)
      |> find_types(request.proto_file)

    files =
      request.proto_file
      |> Enum.filter(fn desc -> Enum.member?(request.file_to_generate, desc.name) end)
      |> Enum.map(fn desc -> Protobuf.Protoc.Generator.generate(ctx, desc) end)

    response = Google.Protobuf.Compiler.CodeGeneratorResponse.new(file: files)
    IO.binwrite(Protobuf.Encoder.encode(response))
  end

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

  def find_types(ctx, descs) do
    find_types(ctx, descs, %{})
  end

  def find_types(ctx, [], acc), do: %{ctx | global_type_mapping: acc}

  def find_types(ctx, [desc | t], acc) do
    types = find_types_in_proto(desc)
    find_types(ctx, t, Map.put(acc, desc.name, types))
  end

  def find_types_in_proto(%Google.Protobuf.FileDescriptorProto{} = desc) do
    ctx = %{
      module_prefix: desc.options && desc.options.elixir_module_prefix,
      package: desc.package,
      namespace: []
    }

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
    new_ctx = append_ns(ctx, name)

    types
    |> update_types(ctx, name)
    |> find_types_in_proto(new_ctx, desc.enum_type)
    |> find_types_in_proto(new_ctx, desc.nested_type)
  end

  defp find_types_in_proto(types, ctx, %Google.Protobuf.EnumDescriptorProto{name: name}) do
    update_types(types, ctx, name)
  end

  defp append_ns(%{namespace: ns} = ctx, name) do
    new_ns = ns ++ [name]
    Map.put(ctx, :namespace, new_ns)
  end

  defp update_types(types, %{namespace: ns, package: pkg, module_prefix: prefix}, name) do
    type_name =
      join_names(prefix || pkg, ns, name)
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
