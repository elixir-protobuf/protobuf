defmodule Protobuf.Protoc.Generator.Enum do
  alias Protobuf.Protoc.Generator.Util

  def generate_list(ctx, descs) do
    Enum.map(descs, fn(desc) -> generate(ctx, desc) end)
  end

  def generate(%{namespace: ns, package: pkg}, desc) do
    name = Util.trans_name(desc.name)
    fields = Enum.map(desc.value, fn(f) -> generate_field(f) end)
    msg_name = Util.join_name(ns ++ [name]) |> Util.attach_pkg(pkg)
    Protobuf.Protoc.Template.enum(msg_name, fields)
  end

  def generate_field(f) do
    ":#{f.name}, #{f.number}"
  end
end
