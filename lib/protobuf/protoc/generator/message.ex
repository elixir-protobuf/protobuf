defmodule Protobuf.Protoc.Generator.Message do
  alias Protobuf.Protoc.Generator.Util
  alias Protobuf.TypeUtil
  alias Protobuf.Protoc.Generator.Enum, as: EnumGenerator

  def generate_list(ctx, descs) do
    Enum.map(descs, fn(desc) -> generate(ctx, desc) end)
  end

  def generate(ctx, desc) do
    msg_struct = parse_desc(ctx, desc)
    ctx = %{ctx | namespace: msg_struct[:new_namespace]}
    [gen_msg(msg_struct)] ++ gen_nested_msgs(ctx, desc) ++ gen_nested_enums(ctx, desc)
  end

  def parse_desc(%{namespace: ns, package: pkg} = ctx, desc) do
    new_ns = ns ++ [Util.trans_name(desc.name)]
    %{
      new_namespace: new_ns,
      name: new_ns |> Util.join_name |> Util.attach_pkg(pkg),
      options: msg_opts_str(desc.options),
      structs: structs_str(desc.field),
      fields: get_fields(ctx, desc)
    }
  end

  defp gen_msg(msg_struct) do
    Protobuf.Protoc.Template.message(
      msg_struct[:name],
      msg_struct[:options],
      msg_struct[:structs],
      gen_fields(msg_struct[:fields])
    )
  end

  defp gen_nested_msgs(ctx, desc) do
    Enum.map(desc.nested_type, fn(msg_desc) -> generate(ctx, msg_desc) end)
  end

  defp gen_nested_enums(ctx, desc) do
    Enum.map(desc.enum_type, fn(enum_desc) -> EnumGenerator.generate(ctx, enum_desc) end)
  end

  defp gen_fields(fields) do
    Enum.map(fields, fn(%{opts_str: opts_str} = f) ->
      if String.length(opts_str) > 0 do
        ":#{f[:name]}, #{f[:number]}, #{f[:label]}: true, type: #{f[:type]}, #{opts_str}"
      else
        ":#{f[:name]}, #{f[:number]}, #{f[:label]}: true, type: #{f[:type]}"
      end
    end)
  end

  def msg_opts_str(opts) do
    msg_options = opts
    opts = %{map: msg_options.map_entry, deprecated: msg_options.deprecated}
    str = Util.options_to_str(opts)
    if String.length(str) > 0, do: ", " <> str, else: ""
  end

  def structs_str(fields) do
    Enum.map_join(fields, ", ", fn(f) -> ":#{f.name}" end)
  end

  def get_fields(ctx, desc) do
    nested_maps = nested_maps(ctx, desc)
    Enum.map(desc.field, fn(f) -> get_field(ctx, f, nested_maps) end)
  end

  def get_field(ctx, f, nested_maps) do
    opts = field_options(f)
    opts = Map.put(opts, :map, nested_maps[f.type_name])
    opts_str = Util.options_to_str(opts)
    type = TypeUtil.number_to_atom(f.type)
    type = if type == :enum || type == :message do
      Util.trans_type_name(f.type_name, ctx)
    else
      ":#{type}"
    end
    %{name: f.name, number: f.number, label: label_name(f.label), type: type, opts_str: opts_str}
  end

  defp nested_maps(ctx, desc) do
    full_name = Util.join_name [ctx.package|ctx.namespace] ++ [desc.name]
    prefix = "." <> full_name
    Enum.reduce(desc.nested_type, %{}, fn(desc, acc) ->
      if desc.options.map_entry do
        Map.put(acc, Util.join_name([prefix, desc.name]), true)
      else
        acc
      end
    end)
  end

  defp field_options(f) do
    opts = %{enum: f.type == 14, default: default_value(f.type, f.default_value)}
    if f.options, do: merge_field_options(opts, f), else: opts
  end

  defp label_name(1), do: "optional"
  defp label_name(2), do: "required"
  defp label_name(3), do: "repeated"

  defp default_value(_, ""), do: nil
  defp default_value(type, value) do
    val = cond do
      type <= 2 ->
        case Float.parse(value) do
          {v, _} -> v
          :error -> value
        end
      type <= 7 || type == 13 || (type >= 15 && type <= 18) ->
        case Integer.parse(value) do
          {v, _} -> v
          :error -> value
        end
      type == 8 -> String.to_atom(value)
      type == 9 || type == 12 -> value
      type == 14 -> String.to_atom(value)
      true -> nil
    end
    if val == nil, do: val, else: inspect(val)
  end

  defp merge_field_options(opts, f) do
    opts
      |> Map.put(:packed, f.options.packed)
      |> Map.put(:deprecated, f.options.deprecated)
  end
end
