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
    ctx = %Context{
      ctx
      | syntax: syntax(desc.syntax),
        package: desc.package || "",
        dep_type_mapping: get_dep_type_mapping(ctx, desc.dependency, desc.name)
    }

    ctx = Protobuf.Protoc.Context.custom_file_options_from_file_desc(ctx, desc)

    nested_extensions =
      ExtensionGenerator.get_nested_extensions(ctx, desc.message_type)
      |> Enum.reverse()

    enum_list = EnumGenerator.generate_list(ctx, desc.enum_type)
    {enums, msgs} = MessageGenerator.generate_list(ctx, desc.message_type)
    service_list = ServiceGenerator.generate_list(ctx, desc.service)
    extension_list = ExtensionGenerator.generate(ctx, desc, nested_extensions)

    [enum_list, enums, msgs, service_list, extension_list]
    |> List.flatten()
    |> Enum.join("\n")
    |> format_code()
  end

  @doc false
  def get_dep_pkgs(%{pkg_mapping: mapping, package: pkg}, deps) do
    pkgs = deps |> Enum.map(fn dep -> mapping[dep] end)
    pkgs = if pkg && String.length(pkg) > 0, do: [pkg | pkgs], else: pkgs
    Enum.sort(pkgs, &(byte_size(&2) <= byte_size(&1)))
  end

  def get_dep_type_mapping(%{global_type_mapping: global_mapping}, deps, file_name) do
    mapping =
      Enum.reduce(deps, %{}, fn dep, acc ->
        Map.merge(acc, global_mapping[dep])
      end)

    Map.merge(mapping, global_mapping[file_name])
  end

  defp syntax("proto3"), do: :proto3
  defp syntax(_), do: :proto2

  defp format_code(code) do
    formatted =
      if Code.ensure_loaded?(Code) and function_exported?(Code, :format_string!, 2) do
        code
        |> Code.format_string!(locals_without_parens: @locals_without_parens)
        |> IO.iodata_to_binary()
      else
        code
      end

    if formatted == "" do
      formatted
    else
      formatted <> "\n"
    end
  end
end
