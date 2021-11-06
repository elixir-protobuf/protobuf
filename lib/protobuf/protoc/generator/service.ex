defmodule Protobuf.Protoc.Generator.Service do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Util

  require EEx

  EEx.function_from_file(
    :defp,
    :service_template,
    Path.expand("./templates/service.ex.eex", :code.priv_dir(:protobuf)),
    [:mod_name, :name, :methods, :descriptor_fun_body],
    trim: true
  )

  @spec generate_list(Context.t(), [Google.Protobuf.ServiceDescriptorProto.t()]) :: [String.t()]
  def generate_list(%Context{} = ctx, descs) when is_list(descs) do
    if Enum.member?(ctx.plugins, "grpc") do
      Enum.map(descs, fn desc -> generate(ctx, desc) end)
    else
      []
    end
  end

  @spec generate(Context.t(), Google.Protobuf.ServiceDescriptorProto.t()) :: String.t()
  def generate(%Context{} = ctx, %Google.Protobuf.ServiceDescriptorProto{} = desc) do
    # service can't be nested
    mod_name = Util.mod_name(ctx, [Macro.camelize(desc.name)])
    name = Util.attach_raw_pkg(desc.name, ctx.package)
    methods = Enum.map(desc.method, &generate_service_method(ctx, &1))

    descriptor_fun_body =
      if ctx.gen_descriptors? do
        descriptor_fun_body(desc)
      else
        nil
      end

    service_template(mod_name, name, methods, descriptor_fun_body)
  end

  defp generate_service_method(ctx, method) do
    input = service_arg(Util.type_from_type_name(ctx, method.input_type), method.client_streaming)

    output =
      service_arg(Util.type_from_type_name(ctx, method.output_type), method.server_streaming)

    {method.name, input, output}
  end

  defp service_arg(type, _streaming? = true), do: "stream(#{type})"
  defp service_arg(type, _streaming?), do: type

  defp descriptor_fun_body(%mod{} = desc) do
    desc
    |> Map.from_struct()
    |> Enum.filter(fn {_key, val} -> not is_nil(val) end)
    |> mod.new()
    |> mod.encode()
    |> mod.decode()
    |> inspect(limit: :infinity)
  end
end
