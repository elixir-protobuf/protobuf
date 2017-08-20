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

  defmacro __before_compile__(env) do
    fields = Module.get_attribute(env.module, :fields)
    options = Module.get_attribute(env.module, :options)
    msg_props = generate_msg_props(options, fields)
    default_fields = generate_default_fields(msg_props)
    embedded_fields = embedded_fields(msg_props)
    enum_fields = enum_fields(msg_props)
    quote do
      def __message_props__ do
        unquote(Macro.escape(msg_props))
      end

      unquote(def_enum_functions(msg_props))

      def __default_struct__ do
        struct = __MODULE__
        |> struct(unquote(Macro.escape(default_fields)))
        struct = Enum.reduce(unquote(embedded_fields), struct, fn({name, type}, acc) ->
          struct(acc, %{name => type.__default_struct__()})
        end)
        Enum.reduce(unquote(Macro.escape(enum_fields)), struct, fn({name, type, default}, acc) ->
          struct(acc, %{name => type.value(default)})
        end)
      end
    end
  end

  defp def_enum_functions(%{enum?: true, field_props: props}) do
    Enum.map(props, fn({_, %{fnum: fnum, name_atom: name_atom}}) ->
      quote do
        def value(unquote(name_atom)), do: unquote(fnum)
        def key(unquote(fnum)), do: unquote(name_atom)
      end
    end)
  end
  defp def_enum_functions(_), do: nil

  defp generate_msg_props(options, fields) do
    field_props = field_props_map(fields)
    repeated_fields =
      field_props
      |> Map.values
      |> Enum.filter(fn props -> props.repeated? end)
      |> Enum.map(fn props -> Map.get(props, :name_atom) end)
    %Protobuf.MessageProps{
      tags_map: tags_map(fields),
      ordered_tags: ordered_tags(fields),
      field_props: field_props,
      repeated_fields: repeated_fields,
      enum?: Keyword.get(options, :enum) == true,
      map?: Keyword.get(options, :map) == true
    }
  end

  defp tags_map(fields) do
    fields
    |> Enum.map(fn ({_, fnum, _}) -> {fnum, fnum} end)
    |> Enum.into(%{})
  end

  defp ordered_tags(fields) do
    fields
    |> Enum.map(fn ({_, fnum, _}) -> fnum end)
    |> Enum.sort
  end

  defp field_props_map(fields) do
    fields
    |> Enum.map(fn ({name, fnum, opts}) -> {fnum, field_props(name, fnum, opts)} end)
    |> Enum.into(%{})
  end

  defp field_props(name, fnum, opts) do
    props = %Protobuf.FieldProps{
      fnum: fnum,
      name: to_string(name),
      name_atom: name
    }
    opts_map = Enum.into(opts, %{})
    parts =
      opts
      |> parse_field_opts
      |> cal_type(opts_map)
      |> cal_embedded(opts_map)
      |> cal_packed(opts_map)
      |> cal_repeated(opts_map)
    struct(props, parts)
  end

  defp parse_field_opts(opts) do
    parse_field_opts(opts, %{})
  end
  defp parse_field_opts([{:optional, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :optional?, true))
  end
  defp parse_field_opts([{:required, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :required?, true))
  end
  defp parse_field_opts([{:enum, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :enum?, true))
  end
  defp parse_field_opts([{:map, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :map?, true))
  end
  defp parse_field_opts([{:type, type}|t], acc) do
    parse_field_opts(t, Map.put(acc, :type, type))
  end
  defp parse_field_opts([{:default, default}|t], acc) do
    parse_field_opts(t, Map.put(acc, :default, default))
  end
  defp parse_field_opts([{_, _}|t], acc) do
    parse_field_opts(t, acc)
  end
  defp parse_field_opts(_, acc), do: acc

  defp cal_type(%{enum?: true} = props, %{type: type}) do
    Map.merge(props, %{type: :enum, enum_type: type, wire_type: Protobuf.Encoder.wire_type(:enum)})
  end
  defp cal_type(props, %{type: type}) do
    Map.merge(props, %{type: type, wire_type: Protobuf.Encoder.wire_type(type)})
  end
  defp cal_type(props, _), do: props

  defp cal_embedded(%{type: type} = props, _) do
    case to_string(type) do
      "Elixir." <> _ -> Map.put(props, :embedded?, !props[:enum?])
      _              -> props
    end
  end
  defp cal_embedded(props, _), do: props

  defp cal_packed(props, %{packed: true, repeated: repeated}) do
    cond do
      props[:embedded?] -> raise ":packed can't be used with :embedded field"
      repeated -> Map.put(props, :packed?, true)
      true           -> raise ":packed must be used with :repeated"
    end
  end
  defp cal_packed(props, _), do: props

  defp cal_repeated(%{map?: true} = props, _), do: Map.put(props, :repeated?, false)
  defp cal_repeated(props, %{repeated: true}), do: Map.put(props, :repeated?, true)
  defp cal_repeated(props, _), do: props

  def generate_default_fields(msg_props) do
    msg_props.field_props
    |> Map.values()
    |> Enum.reduce(%{}, fn(props, acc) ->
         Map.put(acc, props.name_atom, Protobuf.Builder.field_default(props))
       end)
  end

  def embedded_fields(msg_props) do
    msg_props.field_props
    |> Map.values
    |> Enum.filter(fn(props) -> props.embedded? && !props.repeated? && !props.map? end)
    |> Enum.map(fn(props) -> {props.name_atom, props.type} end)
  end

  def enum_fields(msg_props) do
    msg_props.field_props
    |> Map.values
    |> Enum.filter(fn(props) -> props.enum? && props.default end)
    |> Enum.map(fn(props) -> {props.name_atom, props.enum_type, props.default} end)
  end
end
