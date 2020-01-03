defmodule Protobuf.Protoc.Generator.Extension do
  alias Protobuf.Protoc.Generator.Util

  @ext_postfix "PbExtension"

  def generate(%{namespace: ns} = ctx, desc, nested_extensions) do
    extends = Enum.map(desc.extension, fn ext -> generate_extend(ctx, ext) end)

    nested_extends = Enum.map(nested_extensions, fn {ns, exts} ->
      ns = Util.join_name(ns)
      Enum.map(exts, fn ext ->
        generate_extend(ctx, ext, ns)
      end)
    end)
    |> Enum.concat()

    extends = extends ++ nested_extends

    if Enum.empty?(extends) do
      ""
    else
      name = Util.trans_name(@ext_postfix)
      msg_name = Util.mod_name(ctx, ns ++ [name])
      Protobuf.Protoc.Template.extension(msg_name, msg_opts(ctx, desc), extends)
    end
  end

  def generate_extend(ctx, f, ns \\ "") do
    extendee = Util.type_from_type_name(ctx, f.extendee)
    f = Protobuf.Protoc.Generator.Message.get_field(ctx, f, %{}, [])
    label_str = "#{f.label}: true, "
    name = if ns == "" do
      f.name
    else
      inspect(Util.join_name([ns, f.name]))
    end
    "#{extendee}, :#{name}, #{f.number}, #{label_str}type: #{f.type}#{f.opts_str}"
  end

  defp msg_opts(%{syntax: syntax}, _desc) do
    opts = %{syntax: syntax}
    str = Util.options_to_str(opts)
    ", " <> str
  end

  def get_nested_extensions(%{namespace: ns} = ctx, msgs, acc0 \\ []) do
    msgs
    |> Enum.filter(fn m -> !Enum.empty?(m.extension) end)
    |> Enum.reduce(acc0, fn m, acc ->
      new_ns = ns ++ [Util.trans_name(m.name)]
      extension = {new_ns, m.extension}
      acc = [extension | acc]
      if m.nested_type == [] do
        acc
      else
        get_nested_extensions(%{ctx | namespace: new_ns}, m.nested_type, acc)
      end
    end)
  end
end
