defmodule Protobuf.Protoc.Generator.Extension do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Util

  require EEx

  @opaque extension() ::
            {namespace :: [String.t(), ...],
             [ext_field :: Google.Protobuf.FieldDescriptorProto.t()]}

  @ext_postfix "PbExtension"

  EEx.function_from_file(
    :defp,
    :extension_template,
    Path.expand("./templates/extension.ex.eex", :code.priv_dir(:protobuf)),
    [:assigns]
  )

  @spec generate(Context.t(), Google.Protobuf.FileDescriptorProto.t(), [extension()]) ::
          nil | {module_name :: String.t(), file_contents :: String.t()}
  def generate(
        %Context{namespace: ns} = ctx,
        %Google.Protobuf.FileDescriptorProto{} = desc,
        nested_extensions
      )
      when is_list(nested_extensions) do
    extends = Enum.map(desc.extension, &generate_extend(ctx, &1, _ns = ""))

    nested_extends =
      Enum.flat_map(nested_extensions, fn {ns, exts} ->
        ns = Enum.join(ns, ".")
        Enum.map(exts, &generate_extend(ctx, &1, ns))
      end)

    case extends ++ nested_extends do
      [] ->
        nil

      extends ->
        msg_name = Util.mod_name(ctx, ns ++ [Macro.camelize(@ext_postfix)])

        use_options =
          Util.options_to_str(%{
            syntax: ctx.syntax,
            protoc_gen_elixir_version: "\"#{Util.version()}\""
          })

        {msg_name,
         Util.format(
           extension_template(module: msg_name, use_options: use_options, extends: extends)
         )}
    end
  end

  defp generate_extend(ctx, f, ns) do
    extendee = Util.type_from_type_name(ctx, f.extendee)
    f = Protobuf.Protoc.Generator.Message.get_field(ctx, f)

    name =
      if ns == "" do
        f.name
      else
        inspect("#{ns}.#{f.name}")
      end

    "#{extendee}, :#{name}, #{f.number}, #{f.label}: true, type: #{f.type}#{f.opts_str}"
  end

  @spec get_nested_extensions(Context.t(), [Google.Protobuf.DescriptorProto.t()]) :: [extension()]
  def get_nested_extensions(%Context{} = ctx, descs) when is_list(descs) do
    get_nested_extensions(ctx.namespace, descs, _acc = [])
  end

  defp get_nested_extensions(_ns, _descs = [], acc) do
    Enum.reverse(acc)
  end

  defp get_nested_extensions(ns, descs, acc) do
    descs
    |> Enum.reject(&(&1.extension == []))
    |> Enum.reduce(acc, fn desc, acc ->
      new_ns = ns ++ [Macro.camelize(desc.name)]
      acc = [_extension = {new_ns, desc.extension} | acc]
      get_nested_extensions(new_ns, desc.nested_type, acc)
    end)
  end
end
