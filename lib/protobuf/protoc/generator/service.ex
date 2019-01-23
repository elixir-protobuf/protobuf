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
    Protobuf.Protoc.Template.service(mod_name, name, methods)
  end

  defp generate_service_method(_ctx, m) do
    {m.name, get_service_type(m.name), Util.trans_type(m.input_type), m.client_streaming,
     Util.trans_type(m.output_type), m.server_streaming}
  end

  defp get_service_type("create" <> _), do: "mutation"
  defp get_service_type("declare" <> _), do: "mutation"
  defp get_service_type("send" <> _), do: "mutation"
  defp get_service_type("set" <> _), do: "mutation"
  defp get_service_type("store" <> _), do: "mutation"
  defp get_service_type("recover" <> _), do: "mutation"
  defp get_service_type("remove" <> _), do: "mutation"
  defp get_service_type("unsubscribe" <> _), do: "mutation"
  defp get_service_type("subscribe" <> _), do: "subscription"
  defp get_service_type(_), do: "query"
end
