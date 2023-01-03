defmodule Protobuf.Protoc.Generator.Extension do
  @moduledoc false

  alias Google.Protobuf.{DescriptorProto, FieldDescriptorProto, FileDescriptorProto}
  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Util

  require EEx

  @ext_postfix "PbExtension"

  EEx.function_from_file(
    :defp,
    :extension_template,
    Path.expand("./templates/extension.ex.eex", :code.priv_dir(:protobuf)),
    [:assigns]
  )

  def generate_package_level(%Context{} = ctx, mod_name, extensions)
      when is_binary(mod_name) and is_list(extensions) do
    use_options =
      Util.options_to_str(%{
        syntax: ctx.syntax,
        protoc_gen_elixir_version: "\"#{Util.version()}\""
      })

    module_contents =
      Util.format(
        extension_template(use_options: use_options, module: mod_name, extends: extensions)
      )

    {mod_name, module_contents}
  end

  @spec generate(Context.t(), FileDescriptorProto.t()) :: {package_level_extensions, modules}
        when package_level_extensions:
               {module_name :: String.t(), extension_dsls :: [String.t()]} | nil,
             modules: [{module_name :: String.t(), contents :: String.t()}]
  def generate(%Context{} = ctx, %FileDescriptorProto{} = file_desc) do
    use_options =
      Util.options_to_str(%{
        syntax: ctx.syntax,
        protoc_gen_elixir_version: "\"#{Util.version()}\""
      })

    nested_modules = get_extensions_from_messages(ctx, use_options, file_desc.message_type)

    {package_level_extensions(ctx, file_desc), nested_modules}
  end

  defp package_level_extensions(%Context{}, %FileDescriptorProto{extension: []}) do
    nil
  end

  defp package_level_extensions(%Context{} = ctx, %FileDescriptorProto{extension: extensions}) do
    namespace = Util.mod_name(ctx, ctx.namespace ++ [Macro.camelize(@ext_postfix)])
    {namespace, Enum.map(extensions, &generate_extend_dsl(ctx, &1, _ns = ""))}
  end

  defp generate_extend_dsl(ctx, %FieldDescriptorProto{} = f, ns) do
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

  defp get_extensions_from_messages(%Context{} = ctx, use_options, descs) do
    Enum.flat_map(descs, fn %DescriptorProto{} = desc ->
      generate_module(ctx, use_options, desc) ++
        get_extensions_from_messages(
          %Context{ctx | namespace: ctx.namespace ++ [Macro.camelize(desc.name)]},
          use_options,
          desc.nested_type
        )
    end)
  end

  defp generate_module(%Context{}, _use_options, %mod{extension: []})
       when mod in [FileDescriptorProto, DescriptorProto] do
    []
  end

  # If the extensions we're compiling comes from a file, we need to make the extension's module
  # name unique. This is because if we have ext1.proto and ext2.proto, both of which define
  # extensions, then we'd end up with two modules named "<package>.PbExtension".
  # We also need to make the "unique" part of the module name reproducible, because we want
  # subsequent runs of protoc to generate the same output. The best thing I (Andrea) could
  # think of is the hash of all sorted extensions contained in the file, so that if you
  # don't change them (or only change their order) the module name stays the same.
  defp generate_module(%Context{} = ctx, use_options, %FileDescriptorProto{} = file_desc) do
    unique_module_name_part =
      file_desc.extension
      |> Enum.sort()
      |> :erlang.phash2()
      |> Integer.to_string()

    module_name =
      Util.mod_name(
        ctx,
        ctx.namespace ++ ["Extensions#{unique_module_name_part}", Macro.camelize(@ext_postfix)]
      )

    module_contents =
      Util.format(
        extension_template(
          module: module_name,
          use_options: use_options,
          extends: Enum.map(file_desc.extension, &generate_extend_dsl(ctx, &1, _ns = ""))
        )
      )

    [{module_name, module_contents}]
  end

  defp generate_module(%Context{} = ctx, use_options, %DescriptorProto{} = desc) do
    ns = ctx.namespace ++ [Macro.camelize(desc.name)]
    module_name = Util.mod_name(ctx, ns ++ [Macro.camelize(@ext_postfix)])

    module_contents =
      Util.format(
        extension_template(
          module: module_name,
          use_options: use_options,
          extends: Enum.map(desc.extension, &generate_extend_dsl(ctx, &1, _ns = ""))
        )
      )

    [{module_name, module_contents}]
  end
end
