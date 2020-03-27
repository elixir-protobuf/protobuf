defmodule Protobuf.Builder do
  @moduledoc false

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
      # If the attrs is the module, we just return it
      %{__struct__: ^mod} ->
        attrs

      # If the module in the attrs doesn't match with mod
      # raise error in strict and try changing it to a map in non-strict
      %{__struct__: _} ->
        if strict? do
          raise ArgumentError,
            message: "The __struct__ in the struct doesn't with the message module"
        else
          do_new_maybe_strict(mod, Map.from_struct(attrs), strict?)
        end

      _ ->
        do_new_maybe_strict(mod, attrs, strict?)
    end
  end

  defp do_new_maybe_strict(mod, attrs, strict?) do
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
                Enum.map(v, &protobuf_or_term(&1, f_props.type))
              else
                protobuf_or_term(v, f_props.type)
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

  defp protobuf_or_term(value, type),
    do: if(encodable?(value), do: value, else: type.new(value))

  defp encodable?(v), do: Protobuf.Encodable.impl_for(v) != Protobuf.Encodable.Any
end
