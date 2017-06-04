defmodule Protobuf.Protoc.Generator do
  def generate(desc) do
    name = new_name(desc.name)
    %Google_Protobuf_Compiler.CodeGeneratorResponse.File{name: name, content: generate_content(desc)}
  end

  def generate_content(desc) do
    list = Enum.map(desc.message_type || [], fn(msg_desc) -> generate_msg(msg_desc, []) end) ++
      Enum.map(desc.message_type || [], fn(enum_desc) -> generate_enum(enum_desc, []) end) ++
      Enum.map(desc.service || [], fn(svc_desc) -> generate_service(svc_desc) end) ++
      Enum.map(desc.extension || [], fn(ext_desc) -> generate_extension(ext_desc) end)
    Enum.join(list, "\n")
  end

  def generate_msg(desc, _namespace) do
    name = desc.name
    structs = Enum.map_join(desc.field, ", ", fn(f) -> ":#{f.name}" end)
    fields = Enum.map(desc.field, fn(f) -> generate_field(f) end)
    Protobuf.Protoc.Template.message(name, structs, fields)
  end

  def generate_field(f) do
    opts_str = field_options(f)
    if String.length(opts_str) > 0 do
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: :#{type_name(f)}, #{field_options(f)}"
    else
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: :#{type_name(f)}"
    end
  end

  def generate_enum(desc, namespace) do
    ""
  end

  def generate_service(svc) do
    ""
  end

  def generate_extension(desc) do
    ""
  end

  defp new_name(name) do
    name
    |> String.split("/")
    |> List.last
    |> String.replace_suffix(".proto", ".pb.ex")
  end

  def fail(reason) do
    IO.write("protoc-gen-elixir: #{reason}")
    System.halt(1)
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
      opts = opts
        |> Map.put(:packed, f.options.packed)
        |> Map.put(:deprecated, f.options.deprecated)
    end
    options_to_str(opts)
  end

  defp options_to_str(opts) do
    opts
    |> Enum.filter_map(fn({_, v}) -> v end, fn({k, v}) -> "#{k}: #{v}" end)
    |> Enum.join(", ")
  end

end
