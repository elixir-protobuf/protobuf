defmodule Protobuf.Protoc.Generator do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Message, as: MessageGenerator
  alias Protobuf.Protoc.Generator.Enum, as: EnumGenerator
  alias Protobuf.Protoc.Generator.Service, as: ServiceGenerator
  alias Protobuf.Protoc.Generator.Extension, as: ExtensionGenerator

  @locals_without_parens [field: 2, field: 3, oneof: 2, rpc: 3, extend: 4, extensions: 1]

  @spec generate(Context.t(), %Google.Protobuf.FileDescriptorProto{}) ::
          Google.Protobuf.Compiler.CodeGeneratorResponse.File.t()
  def generate(%Context{} = ctx, %Google.Protobuf.FileDescriptorProto{} = desc) do
    # desc.name is the filename, ending in ".proto".
    name = Path.rootname(desc.name) <> ".pb.ex"

    Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
      name: name,
      content: generate_content(ctx, desc)
    )
  end

  defp generate_content(ctx, desc) do
    ctx =
      %Context{
        ctx
        | syntax: syntax(desc.syntax),
          package: desc.package || "",
          dep_type_mapping: get_dep_type_mapping(ctx, desc.dependency, desc.name)
      }
      |> Protobuf.Protoc.Context.custom_file_options_from_file_desc(desc)

    nested_extensions =
      ExtensionGenerator.get_nested_extensions(ctx, desc.message_type)
      |> Enum.reverse()

    enum_defmodules = EnumGenerator.generate_list(ctx, desc.enum_type)

    {nested_enum_defmodules, message_defmodules} =
      MessageGenerator.generate_list(ctx, desc.message_type)

    service_defmodules = ServiceGenerator.generate_list(ctx, desc.service)
    extension_defmodules = ExtensionGenerator.generate(ctx, desc, nested_extensions)

    [
      enum_defmodules,
      nested_enum_defmodules,
      message_defmodules,
      service_defmodules,
      extension_defmodules
    ]
    |> List.flatten()
    |> Enum.join("\n")
    |> format_code_if_possible()
    |> append_newline_if_not_empty()
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
