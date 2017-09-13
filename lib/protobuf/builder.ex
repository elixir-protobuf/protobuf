defmodule Protobuf.Builder do
  def new(mod, attrs) do
    struct(mod.__default_struct__, attrs)
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
  def type_default(:enum), do: 0
  def type_default(:fixed32), do: 0
  def type_default(:sfixed32), do: 0
  def type_default(:fixed64), do: 0
  def type_default(:sfixed64), do: 0
  def type_default(:float), do: 0.0
  def type_default(:double), do: 0.0
  def type_default(:bytes), do: ""
  def type_default(:string), do: ""
  def type_default(_), do: nil
end
