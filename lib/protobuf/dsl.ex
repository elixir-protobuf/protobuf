defmodule Protobuf.DSL do
  defmacro field(name, fnum, options) do
    quote do
      @fields {unquote(name), unquote(fnum), unquote(options)}
    end
  end

  defmacro __before_compile__(env) do
    fields = Module.get_attribute(env.module, :fields)
    quote do
      def __message_props__ do
        unquote(Macro.escape(generate_msg_props(fields)))
      end
    end
  end

  defp generate_msg_props(fields) do
    field_props = field_props_map(fields)
    repeated_fields =
      field_props
      |> Map.values
      |> Enum.filter(fn props -> props.repeated end)
      |> Enum.map(fn props -> Map.get(props, :name_atom) end)
    %Protobuf.MessageProps{
      tags_map: tags_map(fields),
      field_props: field_props,
      repeated_fields: repeated_fields
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
    struct(props, parse_field_opts(opts))
  end

  defp parse_field_opts(opts), do: parse_field_opts(opts, %{})
  defp parse_field_opts([{:optional, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :optional, true))
  end
  defp parse_field_opts([{:required, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :required, true))
  end
  defp parse_field_opts([{:repeated, true}|t], acc) do
    parse_field_opts(t, Map.put(acc, :repeated, true))
  end
  defp parse_field_opts([{:type, type}|t], acc) do
    props = Map.merge(acc, %{type: type, wire_type: Protobuf.Encoder.wire_type(type)})
    props =
      case to_string(type) do
        "Elixir." <> _ -> Map.put(props, :embedded, true)
        _              -> props
      end
    parse_field_opts(t, props)
  end
  defp parse_field_opts([{:packed, true}|t], acc) do
    if acc[:repeated] do
      parse_field_opts(t, Map.put(acc, :packed, true))
    else
      raise ":packed must be used with :repeated"
    end
  end
  defp parse_field_opts(_, acc), do: acc
end
