defmodule Protobuf.Protoc.Generator.Util do
  @moduledoc false

  alias Protobuf.Protoc.Context

  @spec mod_name(Context.t(), [String.t()]) :: String.t()
  def mod_name(%Context{} = ctx, ns) when is_list(ns) do
    prefix = prefixed_name(ctx)
    ns |> Enum.join(".") |> attach_pkg(prefix)
  end

  def prefixed_name(%{package_prefix: nil, module_prefix: nil, package: pkg} = _ctx),
    do: pkg

  def prefixed_name(%{package_prefix: prefix, module_prefix: nil, package: pkg} = _ctx),
    do: attach_raw_pkg(pkg, prefix)

  def prefixed_name(%{module_prefix: module_prefix} = _ctx),
    do: module_prefix

  defp attach_pkg(name, ""), do: name
  defp attach_pkg(name, nil), do: name
  defp attach_pkg(name, pkg), do: normalize_type_name(pkg) <> "." <> name

  def attach_raw_pkg(name, ""), do: name
  def attach_raw_pkg(name, nil), do: name
  def attach_raw_pkg("", pkg), do: pkg
  def attach_raw_pkg(nil, pkg), do: pkg
  def attach_raw_pkg(name, pkg), do: pkg <> "." <> name

  @spec options_to_str(%{optional(atom()) => atom() | integer() | String.t()}) :: String.t()
  def options_to_str(opts) when is_map(opts) do
    opts
    |> Enum.reject(fn {_key, val} -> val in [nil, false] end)
    |> Enum.map_join(", ", fn {key, val} -> "#{key}: #{print(val)}" end)
  end

  defp print(atom) when is_atom(atom), do: inspect(atom)
  defp print(val), do: val

  @spec type_from_type_name(Context.t(), String.t()) :: String.t()
  def type_from_type_name(%Context{dep_type_mapping: mapping}, type_name)
      when is_binary(type_name) do
    # The doc says there's a situation where type_name begins without a `.`, but I never got that.
    # Handle that later.
    metadata =
      mapping[type_name] ||
        raise "There's something wrong to get #{type_name}'s type, please contact with the lib author."

    metadata[:type_name]
  end

  @spec normalize_type_name(String.t()) :: String.t()
  def normalize_type_name(name) when is_binary(name) do
    name
    |> String.split(".")
    |> Enum.map_join(".", &Macro.camelize/1)
  end

  @spec descriptor_fun_body(desc :: struct()) :: String.t()
  def descriptor_fun_body(%mod{} = desc) do
    desc
    |> Map.from_struct()
    |> Enum.filter(fn {_key, val} -> not is_nil(val) end)
    |> mod.new()
    |> mod.encode()
    |> mod.decode()
    |> inspect(limit: :infinity)
  end
end
