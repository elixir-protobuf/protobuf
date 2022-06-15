defmodule Protobuf.Protoc.Generator do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator

  @spec generate(Context.t(), %Google.Protobuf.FileDescriptorProto{}) ::
          [Google.Protobuf.Compiler.CodeGeneratorResponse.File.t()]
  def generate(%Context{} = ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    module_definitions =
      ctx
      |> generate_module_definitions(desc)
      |> Enum.reject(&is_nil/1)

    if ctx.one_file_per_module? do
      Enum.map(module_definitions, fn {mod_name, content} ->
        file_name = Macro.underscore(mod_name) <> ".pb.ex"

        Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
          name: file_name,
          content: content
        )
      end)
    else
      # desc.name is the filename, ending in ".proto".
      file_name = Path.rootname(desc.name) <> ".pb.ex"

      content =
        module_definitions
        |> Enum.map(fn {_mod_name, contents} -> [contents, ?\n] end)
        |> IO.iodata_to_binary()
        |> Generator.Util.format()

      [
        Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
          name: file_name,
          content: content
        )
      ]
    end
  end

  defp generate_module_definitions(ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    ctx =
      %Context{
        ctx
        | syntax: syntax(desc.syntax),
          package: desc.package,
          dep_type_mapping: get_dep_type_mapping(ctx, desc.dependency, desc.name)
      }
      |> Protobuf.Protoc.Context.custom_file_options_from_file_desc(desc)

    nested_extensions = Generator.Extension.get_nested_extensions(ctx, desc.message_type)

    enum_defmodules = Enum.map(desc.enum_type, &Generator.Enum.generate(ctx, &1))

    {nested_enum_defmodules, message_defmodules} =
      Generator.Message.generate_list(ctx, desc.message_type)

    extension_defmodules = Generator.Extension.generate(ctx, desc, nested_extensions)

    service_defmodules =
      if "grpc" in ctx.plugins do
        Enum.map(desc.service, &Generator.Service.generate(ctx, &1))
      else
        []
      end

    List.flatten([
      enum_defmodules,
      nested_enum_defmodules,
      message_defmodules,
      service_defmodules,
      extension_defmodules
    ])
  end

  defp get_dep_type_mapping(%Context{global_type_mapping: global_mapping}, deps, file_name) do
    mapping =
      Enum.reduce(deps, %{}, fn dep, acc ->
        Map.merge(acc, global_mapping[dep])
      end)

    Map.merge(mapping, global_mapping[file_name])
  end

  defp syntax("proto3"), do: :proto3
  defp syntax("proto2"), do: :proto2
  defp syntax(nil), do: :proto2
end
