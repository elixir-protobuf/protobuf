defmodule Protobuf.Protoc.Generator.Extension do
  @moduledoc false

  alias Protobuf.Protoc.Generator.Util

  require EEx

  @ext_postfix "PbExtension"

  EEx.function_from_file(
    :defp,
    :extension_template,
    Path.expand("./templates/extension.ex.eex", :code.priv_dir(:protobuf)),
    [:assigns],
    trim: true
  )

  def generate(%{namespace: ns} = ctx, desc, nested_extensions) do
    extends = Enum.map(desc.extension, fn ext -> generate_extend(ctx, ext) end)

    nested_extends =
      Enum.map(nested_extensions, fn {ns, exts} ->
        ns = Enum.join(ns, ".")

        Enum.map(exts, fn ext ->
          generate_extend(ctx, ext, ns)
        end)
      end)
      |> Enum.concat()

    extends = extends ++ nested_extends

    if Enum.empty?(extends) do
      nil
    else
      name = Macro.camelize(@ext_postfix)
      msg_name = Util.mod_name(ctx, ns ++ [name])
      use_options = Util.options_to_str(%{syntax: ctx.syntax})

      {msg_name,
       Util.format(
         extension_template(module: msg_name, use_options: use_options, extends: extends)
       )}
    end
  end

  def generate_extend(ctx, f, ns \\ "") do
    extendee = Util.type_from_type_name(ctx, f.extendee)
    f = Protobuf.Protoc.Generator.Message.get_field(ctx, f, %{}, [])
    label_str = "#{f.label}: true, "

    name =
      if ns == "" do
        f.name
      else
        inspect("#{ns}.#{f.name}")
      end

    "#{extendee}, :#{name}, #{f.number}, #{label_str}type: #{f.type}#{f.opts_str}"
  end

  def get_nested_extensions(%{namespace: ns} = ctx, msgs, acc0 \\ []) do
    msgs
    |> Enum.filter(fn m -> !Enum.empty?(m.extension) end)
    |> Enum.reduce(acc0, fn m, acc ->
      new_ns = ns ++ [Macro.camelize(m.name)]
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
