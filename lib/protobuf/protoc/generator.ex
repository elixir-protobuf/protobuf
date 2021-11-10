defmodule Protobuf.Protoc.Generator do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator

  @locals_without_parens [field: 2, field: 3, oneof: 2, rpc: 3, extend: 4, extensions: 1]

  @spec generate(Context.t(), %Google.Protobuf.FileDescriptorProto{}) ::
          [Google.Protobuf.Compiler.CodeGeneratorResponse.File.t()]
  def generate(%Context{} = ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    # desc.name is the filename, ending in ".proto".
    name = Path.rootname(desc.name) <> ".pb.ex"

    module_definitions = generate_module_definitions(ctx, desc)

    content =
      module_definitions
      |> Enum.join("\n")
      |> format_code_if_possible()
      |> append_newline_if_not_empty()

    [
      Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
        name: name,
        content: content
      )
    ]
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

    nested_extensions =
      Generator.Extension.get_nested_extensions(ctx, desc.message_type)
      |> Enum.reverse()

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
  defp syntax(_), do: :proto2

  defp format_code_if_possible(code) do
    if Code.ensure_loaded?(Code) and function_exported?(Code, :format_string!, 2) do
      code
      |> Code.format_string!(locals_without_parens: @locals_without_parens)
      |> IO.iodata_to_binary()
    else
      code
    end
  end

  defp append_newline_if_not_empty(""), do: ""
  defp append_newline_if_not_empty(str), do: str <> "\n"
end
