defmodule Protobuf.Protoc do
  @type gen_fn ::
          (Google.Protobuf.Compiler.CodeGeneratorRequest.t() ->
             Google.Protobuf.Compiler.CodeGeneratorResponse.t())

  @doc """

  """
  @spec run(gen_fn) :: :ok | {:error, term()}
  def run(gen_fn) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI
    :io.setopts(:standard_io, encoding: :latin1)
    bin = IO.binread(:all)
    request = Protobuf.Decoder.decode(bin, Google.Protobuf.Compiler.CodeGeneratorRequest)

    response = gen_fn.(request)

    IO.binwrite(Protobuf.Encoder.encode(response))
  end

  def find_types(ctx, descs) do
    find_types(ctx, descs, %{})
  end

  def find_types(ctx, [], acc), do: %{ctx | global_type_mapping: acc}

  def find_types(ctx, [desc | t], acc) do
    types = find_types_in_proto(desc)
    find_types(ctx, t, Map.put(acc, desc.name, types))
  end

  def join_name(list) when is_list(list) do
    Enum.join(list, ".")
  end

  def normalize_type_name(name) do
    name
    |> String.split(".")
    |> Enum.map(&Macro.camelize(&1))
    |> Enum.join(".")
  end

  defp find_types_in_proto(%Google.Protobuf.FileDescriptorProto{} = desc) do
    ctx =
      %Protobuf.Protoc.Context{
        package: desc.package,
        namespace: []
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
      |> normalize_type_name()

    Map.put(types, "." <> join_names(pkg, ns, name), %{type_name: type_name})
  end

  defp join_names(pkg, ns, name) do
    ns_str = join_name(ns)

    [pkg, ns_str, name]
    |> Enum.filter(&(&1 && &1 != ""))
    |> Enum.join(".")
  end
end
