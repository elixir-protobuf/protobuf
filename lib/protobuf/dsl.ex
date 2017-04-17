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
    quote do
      def __message_props__ do
        unquote(Macro.escape(msg_props))
      end
      unquote(def_functions(msg_props))
    end
  end

  defp def_functions(%{enum?: true, field_props: props}) do
    Enum.map(props, fn({_, %{fnum: fnum, name_atom: name_atom}}) ->
      quote do
        def val(unquote(name_atom)), do: unquote(fnum)
      end
    end)
  end
  defp def_functions(_), do: nil

  defp generate_msg_props(options, fields) do
    field_props = field_props_map(fields)
    repeated_fields =
      field_props
      |> Map.values
      |> Enum.filter(fn props -> props.repeated? end)
      |> Enum.map(fn props -> Map.get(props, :name_atom) end)
    %Protobuf.MessageProps{
      tags_map: tags_map(fields),
      field_props: field_props,
      repeated_fields: repeated_fields,
      enum?: Keyword.get(options, :enum) == true
    }
  end

  defp tags_map(fields) do
    fields
    |> Enum.map(fn ({_, fnum, _}) -> {fnum, fnum} end)
    |> Enum.into(%{})
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
      parse_field_opts(opts)
      |> cal_type(opts_map)
      |> cal_embedded(opts_map)
      |> cal_packed(opts_map)
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
  defp parse_field_opts([{:repeated, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :repeated?, true))
  end
  defp parse_field_opts([{:enum, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :enum?, true))
  end
  defp parse_field_opts([{:type, type}|t], acc) do
    parse_field_opts(t, Map.put(acc, :type, type))
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

  defp cal_packed(props, %{packed: true}) do
    cond do
      props[:embedded?] -> raise ":packed can't be used with :embedded field"
      props[:repeated?] -> Map.put(props, :packed?, true)
      true           -> raise ":packed must be used with :repeated"
    end
  end
  defp cal_packed(props, _), do: props
end
