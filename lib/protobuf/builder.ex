defmodule Protobuf.Builder do
  def new(mod) do
    mod.__default_struct__()
  end

  def new(mod, attrs) do
    new_maybe_strict(mod, attrs, _strict? = false)
  end

  def new!(mod, attrs) do
    new_maybe_strict(mod, attrs, _strict? = true)
  end

  def field_default(_, %{default: default}) when not is_nil(default), do: default
  def field_default(_, %{repeated?: true}), do: []
  def field_default(_, %{map?: true}), do: %{}
  def field_default(:proto3, props), do: type_default(props.type)
  def field_default(_, _), do: nil

  def type_default(:int32), do: 0
  def type_default(:int64), do: 0
  def type_default(:uint32), do: 0
  def type_default(:uint64), do: 0
  def type_default(:sint32), do: 0
  def type_default(:sint64), do: 0
  def type_default(:bool), do: false
  def type_default({:enum, _}), do: 0
  def type_default(:fixed32), do: 0
  def type_default(:sfixed32), do: 0
  def type_default(:fixed64), do: 0
  def type_default(:sfixed64), do: 0
  def type_default(:float), do: 0.0
  def type_default(:double), do: 0.0
  def type_default(:bytes), do: <<>>
  def type_default(:string), do: ""
  def type_default(_), do: nil

  defp new_maybe_strict(mod, attrs, strict?) do
    case attrs do
      %{__struct__: _} ->
        attrs

      _ ->
        props = mod.__message_props__()
        default_struct = mod.__default_struct__()
        msg = if strict?, do: struct!(default_struct, attrs), else: struct(default_struct, attrs)

        Enum.reduce(props.embedded_fields, msg, fn k, acc ->
          case msg do
            %{^k => v} when not is_nil(v) ->
              f_props = props.field_props[props.field_tags[k]]

              v =
                if f_props.embedded? do
                  if f_props.repeated? do
                    Enum.map(v, fn i -> f_props.type.new(i) end)
                  else
                    f_props.type.new(v)
                  end
                else
                  v
                end

              Map.put(acc, k, v)

            _ ->
              acc
          end
        end)
    end
  end
end
