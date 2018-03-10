defmodule Protobuf.Validator do
  def validate!(struct) do
    case valid?(struct) do
      true -> true
      {:invalid, msg} -> raise(Protobuf.InvalidError, message: msg)
    end
  end

  def valid?(%{__struct__: mod} = struct) do
    msg_props = mod.__message_props__

    valid =
      if Protobuf.MessageProps.has_oneof?(msg_props),
        do: oneof_valid?(struct, msg_props),
        else: true

    ctx = %{syntax: msg_props.syntax}

    if valid == true do
      Enum.reduce_while(msg_props.field_props, true, fn {_, props}, _ ->
        if field_valid?(ctx, props, Map.get(struct, props.name_atom)) do
          {:cont, true}
        else
          {:halt, {:invalid, "#{inspect(mod)}##{props.name_atom} is invalid!"}}
        end
      end)
    else
      valid
    end
  end

  def field_valid?(_, %{required?: true}, nil), do: false

  def field_valid?(_, %{repeated?: true, embedded?: true, type: type}, list) when is_list(list) do
    Enum.all?(list, fn val -> match_and_valid?(type, val) end)
  end

  def field_valid?(_, %{repeated?: true, embedded?: false, type: type}, list)
      when is_list(list) do
    Enum.all?(list, fn val -> type_valid?(type, val) end)
  end

  def field_valid?(_, %{map?: true, type: type}, map) when is_map(map) do
    key_type = type.__message_props__.field_props[1].type
    val_type = type.__message_props__.field_props[2].type

    Enum.all?(map, fn {k, v} ->
      type_valid?(key_type, k) && match_and_valid?(val_type, v)
    end)
  end

  # oneof fields are not present in struct
  def field_valid?(_, %{oneof: oneof}, nil) when is_integer(oneof), do: true
  # nil is allowed for singular embedded message
  def field_valid?(_, %{embedded?: true}, nil), do: true

  def field_valid?(_, %{embedded?: true, type: type}, val) do
    match_and_valid?(type, val)
  end

  # nil is allowed for proto2
  def field_valid?(%{syntax: :proto2}, _, nil), do: true
  def field_valid?(_, %{type: type}, val), do: type_valid?(type, val)

  defp match_and_valid?(mod, %{__struct__: mod} = val) do
    valid?(val)
  end

  defp match_and_valid?(type, val), do: type_valid?(type, val)

  defp type_valid?(:int32, val) when is_integer(val), do: true
  defp type_valid?(:int64, val) when is_integer(val), do: true
  defp type_valid?(:uint32, val) when is_integer(val) and val >= 0, do: true
  defp type_valid?(:uint64, val) when is_integer(val) and val >= 0, do: true
  defp type_valid?(:sint32, val) when is_integer(val), do: true
  defp type_valid?(:sint64, val) when is_integer(val), do: true
  defp type_valid?(:bool, val) when is_boolean(val), do: true
  defp type_valid?(:enum, val) when is_integer(val), do: true
  defp type_valid?(:fixed32, val) when is_integer(val) and val >= 0, do: true
  defp type_valid?(:sfixed32, val) when is_integer(val), do: true
  defp type_valid?(:fixed64, val) when is_integer(val) and val >= 0, do: true
  defp type_valid?(:sfixed64, val) when is_integer(val), do: true
  defp type_valid?(:float, val) when is_number(val), do: true
  defp type_valid?(:double, val) when is_number(val), do: true
  defp type_valid?(:bytes, val) when is_binary(val), do: true
  defp type_valid?(:string, val) when is_binary(val), do: true
  # TODO
  defp type_valid?(:group, _), do: true
  defp type_valid?(_, _), do: false

  defp oneof_valid?(struct, msg_props) do
    field_tags = msg_props.field_tags
    field_props = msg_props.field_props
    ctx = %{syntax: msg_props.syntax}

    Enum.reduce_while(msg_props.oneof, true, fn {oneof_name, index}, _ ->
      case Map.get(struct, oneof_name) do
        {field, val} ->
          field_props = field_props[field_tags[field]]

          cond do
            field_props.oneof != index ->
              {:halt, {:invalid, ":#{field} doesn't match oneof field :#{oneof_name}"}}

            !field_valid?(ctx, field_props, val) ->
              {:halt, {:invalid, ":#{field} of :#{oneof_name} is invalid"}}

            true ->
              {:cont, true}
          end

        nil ->
          {:cont, true}

        _ ->
          {:halt, {:invalid, ":#{oneof_name} should be a tuple {:field, val}"}}
      end
    end)
  end
end
