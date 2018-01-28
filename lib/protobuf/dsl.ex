defmodule Protobuf.DSL do
  defmacro field(name, fnum, options) do
    quote do
      @fields {unquote(name), unquote(fnum), unquote(options)}
    end
  end

  defmacro field(name, fnum) do
    quote do
      @fields {unquote(name), unquote(fnum), []}
    end
  end

  defmacro oneof(name, index) do
    quote do
      @oneofs {unquote(name), unquote(index)}
    end
  end

  defmacro __before_compile__(env) do
    fields = Module.get_attribute(env.module, :fields)
    options = Module.get_attribute(env.module, :options)
    syntax = Keyword.get(options, :syntax, :proto2)
    oneofs = Module.get_attribute(env.module, :oneofs)
    msg_props = generate_msg_props(fields, oneofs, options)
    default_fields = generate_default_fields(syntax, msg_props)
    enum_fields = enum_fields(msg_props)

    quote do
      def __message_props__ do
        unquote(Macro.escape(msg_props))
      end

      unquote(def_enum_functions(msg_props))

      if unquote(syntax == :proto3) do
        def __default_struct__ do
          struct = struct(__MODULE__, unquote(Macro.escape(default_fields)))

          Enum.reduce(unquote(Macro.escape(enum_fields)), struct, fn {name, type, default}, acc ->
            struct(acc, %{name => type.value(default)})
          end)
        end
      else
        def __default_struct__ do
          struct(__MODULE__, unquote(Macro.escape(default_fields)))
        end
      end
    end
  end

  defp def_enum_functions(%{enum?: true, field_props: props}) do
    Enum.map(props, fn {_, %{fnum: fnum, name_atom: name_atom}} ->
      quote do
        def value(unquote(name_atom)), do: unquote(fnum)
        def key(unquote(fnum)), do: unquote(name_atom)
      end
    end)
  end

  defp def_enum_functions(_), do: nil

  defp generate_msg_props(fields, oneofs, options) do
    syntax = Keyword.get(options, :syntax, :proto2)
    field_props = field_props_map(syntax, fields)

    repeated_fields =
      field_props
      |> Map.values()
      |> Enum.filter(fn props -> props.repeated? end)
      |> Enum.map(fn props -> Map.get(props, :name_atom) end)

    %Protobuf.MessageProps{
      tags_map: tags_map(fields),
      ordered_tags: ordered_tags(fields),
      field_props: field_props,
      field_tags: field_tags(fields),
      repeated_fields: repeated_fields,
      syntax: syntax,
      oneof: Enum.reverse(oneofs),
      enum?: Keyword.get(options, :enum) == true,
      map?: Keyword.get(options, :map) == true
    }
  end

  defp tags_map(fields) do
    fields
    |> Enum.map(fn {_, fnum, _} -> {fnum, fnum} end)
    |> Enum.into(%{})
  end

  defp ordered_tags(fields) do
    fields
    |> Enum.map(fn {_, fnum, _} -> fnum end)
    |> Enum.sort()
  end

  defp field_props_map(syntax, fields) do
    fields
    |> Enum.map(fn {name, fnum, opts} -> {fnum, field_props(syntax, name, fnum, opts)} end)
    |> Enum.into(%{})
  end

  defp field_tags(fields) do
    fields
    |> Enum.map(fn {name, fnum, _} -> {name, fnum} end)
    |> Enum.into(%{})
  end

  defp field_props(syntax, name, fnum, opts) do
    props = %Protobuf.FieldProps{
      fnum: fnum,
      name: to_string(name),
      name_atom: name
    }

    opts_map = Enum.into(opts, %{})
    # parse simple fields then calculate others in cal_*
    parts =
      opts
      |> parse_field_opts(opts_map)
      |> cal_label(syntax)
      |> cal_type()
      |> cal_default(syntax)
      |> cal_embedded()
      |> cal_packed(syntax)
      |> cal_repeated(opts_map)

    struct(props, parts)
  end

  defp parse_field_opts([{:optional, true} | t], acc) do
    parse_field_opts(t, Map.put(acc, :optional?, true))
  end

  defp parse_field_opts([{:required, true} | t], acc) do
    parse_field_opts(t, Map.put(acc, :required?, true))
  end

  defp parse_field_opts([{:enum, true} | t], acc) do
    parse_field_opts(t, Map.put(acc, :enum?, true))
  end

  defp parse_field_opts([{:map, true} | t], acc) do
    parse_field_opts(t, Map.put(acc, :map?, true))
  end

  defp parse_field_opts([{:default, default} | t], acc) do
    parse_field_opts(t, Map.put(acc, :default, default))
  end

  defp parse_field_opts([{:oneof, oneof} | t], acc) do
    parse_field_opts(t, Map.put(acc, :oneof, oneof))
  end

  # skip unknown option
  defp parse_field_opts([{_, _} | t], acc) do
    parse_field_opts(t, acc)
  end

  defp parse_field_opts(_, acc), do: acc

  defp cal_label(%{required?: true}, :proto3) do
    raise Protobuf.InvalidError, message: "required can't be used in proto3"
  end

  defp cal_label(props, :proto3) do
    Map.put(props, :optional?, true)
  end

  defp cal_label(props, _), do: props

  defp cal_type(%{enum?: true, type: type} = props) do
    Map.merge(props, %{type: :enum, enum_type: type, wire_type: Protobuf.Encoder.wire_type(:enum)})
  end

  defp cal_type(%{type: type} = props) do
    Map.merge(props, %{type: type, wire_type: Protobuf.Encoder.wire_type(type)})
  end

  defp cal_type(props), do: props

  defp cal_default(%{default: default}, :proto3) when not is_nil(default) do
    raise Protobuf.InvalidError, message: "default can't be used in proto3"
  end

  defp cal_default(props, _), do: props

  defp cal_embedded(%{type: type} = props) do
    case to_string(type) do
      "Elixir." <> _ -> Map.put(props, :embedded?, !props[:enum?])
      _ -> props
    end
  end

  defp cal_embedded(props), do: props

  defp cal_packed(%{packed: true, repeated: repeated} = props, _) do
    cond do
      props[:embedded?] -> raise ":packed can't be used with :embedded field"
      repeated -> Map.put(props, :packed?, true)
      true -> raise ":packed must be used with :repeated"
    end
  end

  defp cal_packed(%{packed: false} = props, _) do
    Map.put(props, :packed?, false)
  end

  defp cal_packed(%{repeated: repeated, type: type} = props, :proto3) do
    packed = !props[:embedded?] && type_numeric?(type)

    if packed && !repeated do
      raise ":packed must be used with :repeated"
    else
      Map.put(props, :packed?, packed)
    end
  end

  defp cal_packed(props, _), do: props

  defp cal_repeated(%{map?: true} = props, _), do: Map.put(props, :repeated?, false)
  defp cal_repeated(props, %{repeated: true}), do: Map.put(props, :repeated?, true)
  defp cal_repeated(props, _), do: props

  def generate_default_fields(syntax, msg_props) do
    msg_props.field_props
    |> Map.values()
    |> Enum.reduce(%{}, fn props, acc ->
      Map.put(acc, props.name_atom, Protobuf.Builder.field_default(syntax, props))
    end)
  end

  def embedded_fields(msg_props) do
    msg_props.field_props
    |> Map.values()
    |> Enum.filter(fn props -> props.embedded? && !props.repeated? && !props.map? end)
    |> Enum.map(fn props -> {props.name_atom, props.type} end)
  end

  def enum_fields(msg_props) do
    msg_props.field_props
    |> Map.values()
    |> Enum.filter(fn props -> props.enum? && props.default end)
    |> Enum.map(fn props -> {props.name_atom, props.enum_type, props.default} end)
  end

  def type_numeric?(:int32), do: true
  def type_numeric?(:int64), do: true
  def type_numeric?(:uint32), do: true
  def type_numeric?(:uint64), do: true
  def type_numeric?(:sint32), do: true
  def type_numeric?(:sint64), do: true
  def type_numeric?(:bool), do: true
  def type_numeric?(:enum), do: true
  def type_numeric?(:fixed32), do: true
  def type_numeric?(:sfixed32), do: true
  def type_numeric?(:fixed64), do: true
  def type_numeric?(:sfixed64), do: true
  def type_numeric?(:float), do: true
  def type_numeric?(:double), do: true
  def type_numeric?(_), do: false
end
