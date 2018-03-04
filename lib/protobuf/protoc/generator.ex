defmodule Protobuf.Protoc.Generator do
  alias Protobuf.Protoc.Generator.Message, as: MessageGenerator
  alias Protobuf.Protoc.Generator.Enum, as: EnumGenerator
  alias Protobuf.Protoc.Generator.Service, as: ServiceGenerator

  def generate(ctx, desc) do
    name = new_file_name(desc.name)

    Google.Protobuf.Compiler.CodeGeneratorResponse.File.new(
      name: name,
      content: generate_content(ctx, desc)
    )
  end

  defp new_file_name(name) do
    String.replace_suffix(name, ".proto", ".pb.ex")
  end

  def generate_content(ctx, desc) do
    ctx = %{ctx | package: desc.package || "", syntax: syntax(desc.syntax)}
    ctx = %{ctx | dep_pkgs: get_dep_pkgs(ctx, desc.dependency)}

    list =
      MessageGenerator.generate_list(ctx, desc.message_type) ++
        EnumGenerator.generate_list(ctx, desc.enum_type) ++
        ServiceGenerator.generate_list(ctx, desc.service)

    list
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

  defp syntax("proto3"), do: :proto3
  defp syntax(_), do: :proto2

  def format_code(code) do
    formated =
      if Code.ensure_loaded?(Code) && function_exported?(Code, :format_string!, 2) do
        code
        |> Code.format_string!(locals_without_parens: [field: 2, field: 3, oneof: 2, rpc: 3])
        |> IO.iodata_to_binary()
      else
        code
      end

    if formated == "" do
      formated
    else
      formated <> "\n"
    end
  end
end
