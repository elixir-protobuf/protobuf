defmodule Protobuf.Protoc.Generator.Util do
  def trans_name(name) do
    Recase.to_snake(name)
  end

  def trans_type(type) do
    type
    |> atom_to_string()
    |> String.split(".")
    |> List.last()
    |> Recase.to_snake()
    |> to_gql()
  end

  def join_name(list) do
    Enum.join(list, ".")
  end

  def mod_name(%{module_prefix: prefix}, ns) do
    ns |> join_name() |> attach_pkg(prefix)
  end

  defp attach_pkg(name, ""), do: name
  defp attach_pkg(name, nil), do: name
  defp attach_pkg(name, pkg), do: normalize_type_name(pkg) <> "." <> name

  def attach_raw_pkg(name, ""), do: name
  def attach_raw_pkg(name, nil), do: name
  def attach_raw_pkg(name, pkg), do: pkg <> "." <> name

  def options_to_str(opts) do
    opts
    |> Enum.filter(fn {_, v} -> v end)
    |> Enum.map(fn {k, v} -> "#{k}: #{print(v)}" end)
    |> Enum.join(", ")
  end

  def type_from_type_name(ctx, type_name) do
    # The doc says there's a situation where type_name begins without a `.`, but I never got that.
    # Handle that later.
    metadata =
      ctx.dep_type_mapping[type_name] ||
        raise "There's something wrong to get #{type_name}'s type, please contact with the lib author."

    metadata[:type_name]
  end

  def normalize_type_name(name) do
    name
    |> String.split(".")
    |> Enum.map(&Macro.camelize(&1))
    |> Enum.join(".")
  end

  def print(v) when is_atom(v), do: inspect(v)
  def print(v), do: v

  defp atom_to_string(s) when is_binary(s), do: s
  defp atom_to_string(s), do: s |> Atom.to_string()

  defp to_gql("bytes"), do: "string"
  defp to_gql("bool"), do: "boolean"
  defp to_gql("int32"), do: "int"
  defp to_gql("uint32"), do: "int"
  defp to_gql("uint64"), do: "int"
  defp to_gql("sint64"), do: "int"
  defp to_gql("int64"), do: "int"
  defp to_gql("big_uint"), do: "string"
  defp to_gql("big_sint"), do: "string"
  defp to_gql(type), do: type
end
