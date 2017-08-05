defmodule Protobuf.Validator do

  def validate!(struct) do
    case valid?(struct) do
      true -> true
      {:invalid, msg} -> raise(Protobuf.InvalidError, message: msg)
    end
  end

  def valid?(%{__struct__: mod} = struct) do
    Enum.reduce_while(mod.__message_props__.field_props, true, fn({_, props}, _) ->
      if field_valid?(props, Map.get(struct, props.name_atom)) do
        {:cont, true}
      else
        {:halt, {:invalid, "#{inspect mod}##{props.name_atom} is invalid!"}}
      end
    end)
  end

  def field_valid?(%{repeated?: true, embedded?: true, type: type}, list) when is_list(list) do
    Enum.all?(list, fn(val) -> match_and_valid?(type, val) end)
  end
  def field_valid?(%{repeated?: true, embedded?: false, type: type}, list) when is_list(list) do
    Enum.all?(list, fn(val) -> type_valid?(type, val) end)
  end
  def field_valid?(%{map?: true, type: type}, map) when is_map(map) do
    key_type = type.__message_props__.field_props[1].type
    val_type = type.__message_props__.field_props[2].type
    Enum.all?(map, fn({k, v}) ->
      type_valid?(key_type, k) && match_and_valid?(val_type, v)
    end)
  end
  def field_valid?(%{embedded?: true, type: type}, val), do: match_and_valid?(type, val)
  def field_valid?(%{type: type}, val), do: type_valid?(type, val)

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
  defp type_valid?(:float, val) when is_float(val), do: true
  defp type_valid?(:double, val) when is_float(val), do: true
  defp type_valid?(:bytes, val) when is_binary(val), do: true
  defp type_valid?(:string, val) when is_binary(val), do: true
  # TODO
  defp type_valid?(:group, _), do: true
  defp type_valid?(_, _), do: false
end
