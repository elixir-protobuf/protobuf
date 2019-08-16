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
    # service can't be nested
    mod_name = Util.mod_name(ctx, [Util.trans_name(desc.name)])
    name = Util.attach_raw_pkg(desc.name, ctx.package)
    methods = Enum.map(desc.method, fn m -> generate_service_method(ctx, m) end)
    generate_desc = if ctx.gen_descriptors?, do: desc, else: nil
    Protobuf.Protoc.Template.service(mod_name, name, methods, generate_desc)
  end

  defp generate_service_method(ctx, m) do
    input = service_arg(Util.type_from_type_name(ctx, m.input_type), m.client_streaming)
    output = service_arg(Util.type_from_type_name(ctx, m.output_type), m.server_streaming)
    ":#{m.name}, #{input}, #{output}"
  end

  defp service_arg(type, true), do: "stream(#{type})"
  defp service_arg(type, _), do: type
end
