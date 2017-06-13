defmodule Protobuf.Protoc.Generator do
  alias Protobuf.Protoc.Context

  def generate(desc) do
    name = new_name(desc.name)
    %Google_Protobuf_Compiler.CodeGeneratorResponse.File{name: name, content: generate_content(desc)}
  end

  def generate_content(desc) do
    ctx = %Context{package: desc.package, namespace: []}
    list = Enum.map(desc.message_type || [], fn(msg_desc) -> generate_msg(ctx, msg_desc) end) ++
      Enum.map(desc.enum_type || [], fn(enum_desc) -> generate_enum(ctx, enum_desc) end) ++
      Enum.map(desc.service || [], fn(svc_desc) -> generate_service(ctx, svc_desc) end) ++
      Enum.map(desc.extension || [], fn(ext_desc) -> generate_extension(ctx, ext_desc) end)
    list
    |> List.flatten
    |> Enum.join("\n")
  end

  def generate_msg(%{namespace: ns} = ctx, desc) do
    name = desc.name
    new_namespace = ns ++ [name]
    structs = Enum.map_join(desc.field || [], ", ", fn(f) -> ":#{f.name}" end)
    fields = Enum.map(desc.field || [], fn(f) -> generate_message_field(ctx, f) end)
    [Protobuf.Protoc.Template.message(join_name(new_namespace), structs, fields)] ++
      Enum.map(desc.nested_type || [], fn(nested_msg_desc) -> generate_msg(Map.put(ctx, :namespace, new_namespace), nested_msg_desc) end) ++
      Enum.map(desc.enum_type || [], fn(enum_desc) -> generate_enum(Map.put(ctx, :namespace, new_namespace), enum_desc) end)
  end

  def generate_message_field(ctx, f) do
    opts_str = field_options(f)
    type = type_name(f)
    type = if type == :enum do
      trim_package(f.type_name, ctx.package)
    else
      ":#{type}"
    end
    if String.length(opts_str) > 0 do
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: #{type}, #{field_options(f)}"
    else
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: #{type}"
    end
  end

  def generate_enum(%{namespace: ns}, desc) do
    name = desc.name
    fields = Enum.map(desc.value, fn(f) -> generate_enum_field(f) end)
    Protobuf.Protoc.Template.enum(join_name(ns ++ [name]), fields)
  end

  def generate_enum_field(f) do
    # TODO: options
    ":#{f.name}, #{f.number}"
  end

  def generate_service(ctx, svc) do
    ""
  end

  def generate_extension(ctx, desc) do
    ""
  end

  defp new_name(name) do
    name
    |> String.split("/")
    |> List.last
    |> String.replace_suffix(".proto", ".pb.ex")
  end

  defp label_name(1), do: "optional"
  defp label_name(2), do: "required"
  defp label_name(3), do: "repeated"

  defp type_name(%{type: 1}), do: :double
  defp type_name(%{type: 2}), do: :float
  defp type_name(%{type: 3}), do: :int64
  defp type_name(%{type: 4}), do: :uint64
  defp type_name(%{type: 5}), do: :int32
  defp type_name(%{type: 6}), do: :fixed64
  defp type_name(%{type: 7}), do: :fixed32
  defp type_name(%{type: 8}), do: :bool
  defp type_name(%{type: 9}), do: :string
  defp type_name(%{type: 10}), do: :group
  defp type_name(%{type: 12}), do: :bytes
  defp type_name(%{type: 13}), do: :uint32
  defp type_name(%{type: 15}), do: :sfixed32
  defp type_name(%{type: 16}), do: :sfixed64
  defp type_name(%{type: 17}), do: :sint32
  defp type_name(%{type: 18}), do: :sint63

  defp type_name(%{type: 11}), do: :message
  defp type_name(%{type: 14}), do: :enum

  defp field_options(f) do
    opts = %{enum: f.type == 14, default: f.default_value}
    if f.options do
      opts |> merge_field_options(f) |> options_to_str
    else
      options_to_str(opts)
    end
  end

  defp merge_field_options(opts, f) do
    opts
      |> Map.put(:packed, f.options.packed)
      |> Map.put(:deprecated, f.options.deprecated)
  end

  defp options_to_str(opts) do
    opts
    |> Enum.filter_map(fn({_, v}) -> v end, fn({k, v}) -> "#{k}: #{v}" end)
    |> Enum.join(", ")
  end

  defp join_name(list) do
    Enum.join(list, ".")
  end

  defp trim_package(name, pkg) do
    String.trim_leading(name, "." <> pkg <> ".")
  end

end
