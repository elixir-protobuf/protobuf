defmodule Protobuf.Protoc.Generator.Service do
  alias Protobuf.Protoc.Generator.Util

  def generate_list(ctx, descs) do
    if Enum.member?(ctx.plugins, "grpc") do
      Enum.map(descs, fn desc -> generate(ctx, desc) end)
    else
      []
    end
  end

  def generate(ctx, desc) do
    mod_name = desc.name |> Macro.camelize() |> Util.attach_pkg(ctx.package)
    name = Util.attach_raw_pkg(desc.name, ctx.package)
    methods = Enum.map(desc.method, fn m -> generate_service_method(ctx, m) end)
    Protobuf.Protoc.Template.service(mod_name, name, methods)
  end

  defp generate_service_method(ctx, m) do
    input = service_arg(Util.trans_type_name(m.input_type, ctx), m.client_streaming)
    output = service_arg(Util.trans_type_name(m.output_type, ctx), m.server_streaming)
    ":#{m.name}, #{input}, #{output}"
  end

  defp service_arg(type, true), do: "stream(#{type})"
  defp service_arg(type, _), do: type
end
