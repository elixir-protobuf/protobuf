defmodule Protobuf.Protoc.Generator.Message do
  @moduledoc false

  alias Google.Protobuf.FieldDescriptorProto

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Util
  alias Protobuf.TypeUtil
  alias Protobuf.Protoc.Generator.Enum, as: EnumGenerator

  require EEx

  EEx.function_from_file(
    :defp,
    :message_template,
    Path.expand("./templates/message.ex.eex", :code.priv_dir(:protobuf)),
    [:assigns]
  )

  @spec generate_list(Context.t(), [Google.Protobuf.DescriptorProto.t()]) ::
          {enums :: [{mod_name :: String.t(), contents :: String.t()}],
           messages :: [{mod_name :: String.t(), contents :: String.t()}]}
  def generate_list(%Context{} = ctx, descs) when is_list(descs) do
    descs
    |> Enum.map(fn desc -> generate(ctx, desc) end)
    |> Enum.unzip()
  end

  @spec generate(Context.t(), Google.Protobuf.DescriptorProto.t()) :: {any(), any()}
  def generate(%Context{} = ctx, %Google.Protobuf.DescriptorProto{} = desc) do
    new_ns = ctx.namespace ++ [Macro.camelize(desc.name)]
    msg_name = Util.mod_name(ctx, new_ns)
    fields = get_fields(ctx, desc)
    extensions = get_extensions(desc)

    descriptor_fun_body =
      if ctx.gen_descriptors? do
        Util.descriptor_fun_body(desc)
      else
        nil
      end

    ctx = %Context{ctx | namespace: new_ns}
    {nested_enums, nested_msgs} = Enum.unzip(gen_nested_msgs(ctx, desc))

    msg =
      {msg_name,
       Util.format(
         message_template(
           module: msg_name,
           use_options: msg_opts_str(ctx, desc.options),
           struct_fields: struct_fields_with_defaults(ctx, desc, fields, extensions),
           struct_field_typespecs: struct_field_typespecs(fields, desc.oneof_decl, extensions),
           oneofs: desc.oneof_decl,
           fields: gen_fields(ctx.syntax, fields),
           descriptor_fun_body: descriptor_fun_body,
           transform_module: ctx.transform_module,
           extensions: extensions
         )
       )}

    {gen_nested_enums(ctx, desc) ++ nested_enums, nested_msgs ++ [msg]}
  end

  defp gen_nested_msgs(ctx, desc) do
    Enum.map(desc.nested_type, fn msg_desc -> generate(ctx, msg_desc) end)
  end

  defp gen_nested_enums(ctx, desc) do
    Enum.map(desc.enum_type, fn enum_desc -> EnumGenerator.generate(ctx, enum_desc) end)
  end

  defp gen_fields(syntax, fields) do
    Enum.map(fields, fn %{opts_str: opts_str} = f ->
      label_str =
        if syntax == :proto3 && f[:label] != "repeated", do: "", else: "#{f[:label]}: true, "

      ":#{f[:name]}, #{f[:number]}, #{label_str}type: #{f[:type]}#{opts_str}"
    end)
  end

  defp msg_opts_str(%{syntax: syntax}, opts) do
    msg_options = opts

    opts = %{
      syntax: syntax,
      map: msg_options && msg_options.map_entry,
      deprecated: msg_options && msg_options.deprecated
    }

    str = Util.options_to_str(opts)
    if String.length(str) > 0, do: ", " <> str, else: ""
  end

  defp struct_fields_with_defaults(ctx, desc, fields, extensions) do
    oneof_fields = Enum.map(desc.oneof_decl, &{&1.name, _default = "nil"})

    fields =
      for field <- fields,
          is_nil(field.oneof),
          do: {field.name, struct_default_value(field, ctx)}

    extensions_fields =
      if Enum.empty?(extensions), do: [], else: [{:__pb_extensions__, _default = "nil"}]

    oneof_fields ++ fields ++ extensions_fields
  end

  defp struct_default_value(%{label: "optional"}, %{syntax: syntax}) when syntax != :proto3 do
    "nil"
  end

  defp struct_default_value(%{map: map}, _ctx) when not is_nil(map) do
    "%{}"
  end

  defp struct_default_value(%{label: "repeated"}, _ctx) do
    "[]"
  end

  defp struct_default_value(%{opts: %{default: default}}, _ctx) when not is_nil(default) do
    inspect(default)
  end

  defp struct_default_value(%{type_enum: :TYPE_ENUM, type: type}, %{enums: enums}) do
    case Map.fetch(enums, type) do
      {:ok, default} -> ":#{default}"
      :error -> "0"
    end
  end

  defp struct_default_value(%{type_enum: type}, _ctx) do
    type
    |> TypeUtil.from_enum()
    |> Protobuf.Builder.type_default()
    |> inspect()
  end

  defp struct_field_typespecs(fields, oneofs, extensions) do
    {oneof_fields, regular_fields} = Enum.split_with(fields, & &1[:oneof])

    oneof_types = oneof_types(oneofs, oneof_fields)
    regular_types = regular_types(regular_fields)
    extensions_types = extensions_types(extensions)

    oneof_types ++ regular_types ++ extensions_types
  end

  defp oneof_types(oneofs, oneof_fields) do
    oneofs
    |> Enum.with_index()
    |> Enum.map(fn {oneof, index} ->
      typespec =
        oneof_fields
        |> Enum.filter(&(&1.oneof == index))
        |> Enum.map_join(" | ", &"{:#{&1.name}, #{fmt_type(&1)}}")

      {oneof.name, typespec}
    end)
  end

  defp regular_types(fields) do
    for f <- fields, do: {f.name, fmt_type(f)}
  end

  defp extensions_types(_extensions = []), do: []

  defp extensions_types(_extensions) do
    [{:__pb_extensions__, "map"}]
  end

  defp fmt_type(%{opts: %{map: true}, map: {{k_type_enum, _k_type}, {v_type_enum, v_type}}}) do
    # Keys are guaranteed to be scalars. Values can be anything except another map. Map fields
    # cannot be `repeated`.
    k_spec = TypeUtil.enum_to_spec(k_type_enum)
    v_spec = type_to_spec(v_type_enum, v_type)
    v_spec = optional_if_message(v_type_enum, v_spec)

    "%{#{k_spec} => #{v_spec}}"
  end

  defp fmt_type(%{label: label, type_enum: type_enum, type: type}) do
    spec = type_to_spec(type_enum, type)

    if label == "repeated" do
      "[#{spec}]"
    else
      optional_if_message(type_enum, spec)
    end
  end

  defp type_to_spec(:TYPE_MESSAGE, type), do: "#{type}.t()"
  defp type_to_spec(:TYPE_ENUM, type), do: "#{type}.t()"
  defp type_to_spec(type_scalar, _type), do: TypeUtil.enum_to_spec(type_scalar)

  defp optional_if_message(:TYPE_MESSAGE, spec), do: "#{spec} | nil"
  defp optional_if_message(_type_others, spec), do: spec

  defp get_fields(ctx, desc) do
    oneofs = Enum.map(desc.oneof_decl, & &1.name)
    nested_maps = nested_maps(ctx, desc)
    for field <- desc.field, do: get_field(ctx, field, nested_maps, oneofs)
  end

  # Public and used by extensions.
  @spec get_field(Context.t(), FieldDescriptorProto.t()) :: map()
  def get_field(%Context{} = ctx, %FieldDescriptorProto{} = field) do
    get_field(ctx, field, _nested_maps = %{}, _oneofs = [])
  end

  defp get_field(ctx, %FieldDescriptorProto{} = field_desc, nested_maps, oneofs) do
    opts = field_options(field_desc, ctx.syntax)

    # Check if the field is a map.
    map = nested_maps[field_desc.type_name]
    opts = if map, do: Keyword.put(opts, :map, true), else: opts

    opts =
      case field_desc.oneof_index do
        _ when oneofs == [] -> opts
        nil -> opts
        index -> Keyword.put(opts, :oneof, index)
      end

    opts_str =
      opts
      |> sort_field_opts_to_reduce_changes()
      |> Enum.map_join(", ", fn {key, val} -> "#{key}: #{inspect(val)}" end)

    opts_str = if opts_str == "", do: "", else: ", " <> opts_str

    type = field_type_name(ctx, field_desc)

    %{
      name: field_desc.name,
      number: field_desc.number,
      label: label_name(field_desc.label),
      type: type,
      type_enum: field_desc.type,
      opts: Map.new(opts),
      opts_str: opts_str,
      map: map,
      oneof: field_desc.oneof_index
    }
  end

  # To avoid unnecessarily changing the files that users of this library generated with previous
  # versions, we try to guarantee an order of field options in the generated files.
  ordered_opts = [:json_name, :optional, :repeated, :type, :default, :enum, :packed, :deprecated]
  weights = Map.new(Enum.with_index(ordered_opts))

  defp sort_field_opts_to_reduce_changes(opts) do
    Enum.sort_by(opts, fn {key, _val} -> Map.fetch!(unquote(Macro.escape(weights)), key) end)
  end

  defp get_extensions(desc) do
    Enum.map(desc.extension_range, fn range ->
      {range.start, range.end}
    end)
  end

  defp field_type_name(ctx, f) do
    type = TypeUtil.from_enum(f.type)

    if f.type_name && (type == :enum || type == :message) do
      Util.type_from_type_name(ctx, f.type_name)
    else
      ":#{type}"
    end
  end

  # Map of protobuf are actually nested(one level) messages
  defp nested_maps(ctx, desc) do
    full_name = Enum.join([ctx.package | ctx.namespace] ++ [desc.name], ".")
    prefix = "." <> full_name

    Enum.reduce(desc.nested_type, %{}, fn desc, acc ->
      if desc.options && desc.options.map_entry do
        [k, v] = Enum.sort(desc.field, &(&1.number < &2.number))

        pair = {{k.type, field_type_name(ctx, k)}, {v.type, field_type_name(ctx, v)}}

        Map.put(acc, "#{prefix}.#{desc.name}", pair)
      else
        acc
      end
    end)
  end

  defp field_options(field_desc, syntax) do
    (_starting_opts = [])
    |> add_default_value_to_opts(field_desc)
    |> add_enum_to_opts(field_desc)
    |> add_json_name_to_opts(syntax, field_desc)
    |> add_field_opts_if_present(field_desc)
  end

  defp add_field_opts_if_present(opts, %FieldDescriptorProto{options: field_opts}) do
    opts =
      if field_opts && is_boolean(field_opts.packed) do
        Keyword.put(opts, :packed, field_opts.packed)
      else
        opts
      end

    opts =
      if field_opts && is_boolean(field_opts.deprecated) do
        Keyword.put(opts, :deprecated, field_opts.deprecated)
      else
        opts
      end

    opts
  end

  defp add_enum_to_opts(opts, %FieldDescriptorProto{type: type}) do
    if type == :TYPE_ENUM do
      Keyword.put(opts, :enum, true)
    else
      opts
    end
  end

  defp label_name(:LABEL_OPTIONAL), do: "optional"
  defp label_name(:LABEL_REQUIRED), do: "required"
  defp label_name(:LABEL_REPEATED), do: "repeated"

  defp add_default_value_to_opts(opts, %FieldDescriptorProto{
         default_value: default_value
       })
       when default_value in [nil, ""] do
    opts
  end

  defp add_default_value_to_opts(opts, %FieldDescriptorProto{
         default_value: default_value,
         type: type
       }) do
    value = cast_default_value(type, default_value)

    if is_nil(value) do
      opts
    else
      Keyword.put(opts, :default, value)
    end
  end

  int_types = [
    :TYPE_INT64,
    :TYPE_UINT64,
    :TYPE_INT32,
    :TYPE_FIXED64,
    :TYPE_FIXED32,
    :TYPE_UINT32,
    :TYPE_SFIXED32,
    :TYPE_SFIXED64,
    :TYPE_SINT32,
    :TYPE_SINT64
  ]

  float_types = [:TYPE_DOUBLE, :TYPE_FLOAT]

  defp cast_default_value(:TYPE_BOOL, "true"), do: true
  defp cast_default_value(:TYPE_BOOL, "false"), do: false
  defp cast_default_value(:TYPE_ENUM, val), do: String.to_atom(val)
  defp cast_default_value(type, val) when type in [:TYPE_STRING, :TYPE_BYTES], do: val
  defp cast_default_value(type, val) when type in unquote(int_types), do: int_default(val)
  defp cast_default_value(type, val) when type in unquote(float_types), do: float_default(val)

  defp float_default(value) do
    # A float can also be "inf", "NaN", and so on.
    case Float.parse(value) do
      {float, ""} -> float
      :error -> value
      {_float, _rest} -> raise "unparseable float/double default: #{inspect(value)}"
    end
  end

  defp int_default(value) do
    case Integer.parse(value) do
      {int, ""} -> int
      _other -> raise "unparseable number default: #{inspect(value)}"
    end
  end

  # Omit `json_name` from the options list when it matches the original field
  # name to keep the list small. Only Proto3 has JSON support for now.
  defp add_json_name_to_opts(opts, :proto3, %{name: name, json_name: name}), do: opts

  defp add_json_name_to_opts(opts, :proto3, %{json_name: json_name}),
    do: Keyword.put(opts, :json_name, json_name)

  defp add_json_name_to_opts(opts, _syntax, _props), do: opts
end
