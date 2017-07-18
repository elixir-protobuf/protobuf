defmodule Protobuf.Protoc.Generator do
  alias Protobuf.Protoc.Template

  def generate(ctx, desc) do
    name = new_file_name(desc.name)
    %Google_Protobuf_Compiler.CodeGeneratorResponse.File{name: name, content: generate_content(ctx, desc)}
  end

  defp new_file_name(name) do
    String.replace_suffix(name, ".proto", ".pb.ex")
  end

  def generate_content(ctx, desc) do
    ctx = %{ctx | package: desc.package || ""}
    ctx = %{ctx | dep_pkgs: get_dep_pkgs(ctx, desc.dependency || [])}
    list = Enum.map(desc.message_type || [], fn(msg_desc) -> generate_msg(ctx, msg_desc) end) ++
      Enum.map(desc.enum_type || [], fn(enum_desc) -> generate_enum(ctx, enum_desc) end) ++
      generate_services(ctx, desc) ++
      Enum.map(desc.extension || [], fn(ext_desc) -> generate_extension(ctx, ext_desc) end)
    list
    |> List.flatten
    |> Enum.join("\n")
  end

  @doc false
  def get_dep_pkgs(%{pkg_mapping: mapping, package: pkg}, deps) do
    pkgs = deps |> Enum.map(fn(dep) -> mapping[dep] end)
    pkgs = if pkg && String.length(pkg) > 0, do: [pkg | pkgs], else: pkgs
    Enum.sort(pkgs, &(byte_size(&2) <= byte_size(&1)))
  end

  def generate_services(ctx, desc) do
    if Enum.member?(ctx.plugins, "grpc") do
      Enum.map(desc.service || [], fn(svc_desc) -> generate_service(ctx, svc_desc) end)
    else
      []
    end
  end

  def generate_msg(%{namespace: ns, package: pkg} = ctx, desc) do
    name = trans_name(desc.name)
    new_namespace = ns ++ [name]
    structs = Enum.map_join(desc.field || [], ", ", fn(f) -> ":#{f.name}" end)
    fields = Enum.map(desc.field || [], fn(f) -> generate_message_field(ctx, f) end)
    msg_name = new_namespace |> join_name |> attach_pkg(pkg)
    [Template.message(msg_name, structs, fields)] ++
      Enum.map(desc.nested_type || [], fn(nested_msg_desc) -> generate_msg(Map.put(ctx, :namespace, new_namespace), nested_msg_desc) end) ++
      Enum.map(desc.enum_type || [], fn(enum_desc) -> generate_enum(Map.put(ctx, :namespace, new_namespace), enum_desc) end)
  end

  def generate_message_field(ctx, f) do
    opts_str = field_options(f)
    type = type_name(f)
    type = if type == :enum || type == :message do
      t = trans_type_name(f.type_name, ctx)
    else
      ":#{type}"
    end
    if String.length(opts_str) > 0 do
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: #{type}, #{field_options(f)}"
    else
      ":#{f.name}, #{f.number}, #{label_name(f.label)}: true, type: #{type}"
    end
  end

  def generate_enum(%{namespace: ns, package: pkg}, desc) do
    name = trans_name(desc.name)
    fields = Enum.map(desc.value, fn(f) -> generate_enum_field(f) end)
    msg_name = join_name(ns ++ [name]) |> attach_pkg(pkg)
    Template.enum(msg_name, fields)
  end

  def generate_enum_field(f) do
    # TODO: options
    ":#{f.name}, #{f.number}"
  end

  def generate_service(ctx, svc) do
    mod_name = svc.name |> Macro.camelize |> attach_pkg(ctx.package)
    name = "#{ctx.package}.#{svc.name}"
    methods = Enum.map(svc.method, fn(m) -> generate_service_method(ctx, m) end)
    Template.service(mod_name, name, methods)
  end

  defp generate_service_method(ctx, m) do
    input = service_arg(trans_type_name(m.input_type, ctx), m.client_streaming)
    output = service_arg(trans_type_name(m.output_type, ctx), m.server_streaming)
    ":#{m.name}, #{input}, #{output}"
  end

  defp service_arg(type, true), do: "stream(#{type})"
  defp service_arg(type, _), do: type

  def generate_extension(_, _) do
    ""
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

  def trans_name(name) do
    Macro.camelize(name)
  end

  defp attach_pkg(name, ""), do: name
  defp attach_pkg(name, pkg), do: normalize_pkg_name(pkg) <> "." <> name

  defp trans_type_name(name, ctx) do
    case find_type_package(name, ctx) do
      "" -> name |> String.trim_leading(".") |> normalize_type_name
      found_pkg ->
        name = name |> String.trim_leading("." <> found_pkg <> ".") |> normalize_type_name
        normalize_pkg_name(found_pkg) <> "." <> name
    end
  end

  defp normalize_pkg_name(pkg) do
    pkg
    |> String.split(".")
    |> Enum.map(&Macro.camelize(&1))
    |> Enum.join("_")
  end

  defp normalize_type_name(name) do
    name
    |> String.split(".")
    |> Enum.map(&Macro.camelize(&1))
    |> Enum.join(".")
  end

  defp find_type_package("." <> name, %{dep_pkgs: pkgs, package: pkg}) do
    case find_package_in_deps(name, pkgs) do
      nil -> pkg
      found_pkg -> found_pkg
    end
  end
  defp find_type_package(_, %{package: pkg}), do: pkg

  defp find_package_in_deps(_, []), do: nil
  defp find_package_in_deps(name, [pkg|tail]) do
    if String.starts_with?(name, pkg <> ".") do
      pkg
    else
      find_package_in_deps(name, tail)
    end
  end

end
