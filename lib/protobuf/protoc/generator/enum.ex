defmodule Protobuf.Protoc.Generator.Enum do
  alias Protobuf.Protoc.Generator.Util

  def generate_list(ctx, descs) do
    Enum.map(descs, fn desc -> generate(ctx, desc) end)
  end

  def generate(%{namespace: ns} = ctx, desc) do
    name = Util.trans_name(desc.name)
    fields = Enum.map(desc.value, fn f -> generate_field(f) end)
    msg_name = Util.mod_name(ctx, ns ++ [name])
    Protobuf.Protoc.Template.enum(msg_name, msg_opts(ctx, desc), fields, desc)
  end

  def generate_field(f) do
    ":#{f.name}, #{f.number}"
  end

  defp msg_opts(%{syntax: syntax}, desc) do
    opts = %{syntax: syntax, enum: true}
    str = Util.options_to_str(opts)
    ", " <> str
  end
end
