defmodule Protobuf.TypeUtil do
  def from_enum(:TYPE_DOUBLE), do: :double
  def from_enum(:TYPE_FLOAT), do: :float
  def from_enum(:TYPE_INT64), do: :int64
  def from_enum(:TYPE_UINT64), do: :uint64
  def from_enum(:TYPE_INT32), do: :int32
  def from_enum(:TYPE_FIXED64), do: :fixed64
  def from_enum(:TYPE_FIXED32), do: :fixed32
  def from_enum(:TYPE_BOOL), do: :bool
  def from_enum(:TYPE_STRING), do: :string
  def from_enum(:TYPE_GROUP), do: :group
  def from_enum(:TYPE_MESSAGE), do: :message
  def from_enum(:TYPE_BYTES), do: :bytes
  def from_enum(:TYPE_UINT32), do: :uint32
  def from_enum(:TYPE_ENUM), do: :enum
  def from_enum(:TYPE_SFIXED32), do: :sfixed32
  def from_enum(:TYPE_SFIXED64), do: :sfixed64
  def from_enum(:TYPE_SINT32), do: :sint32
  def from_enum(:TYPE_SINT64), do: :sint64

  def enum_to_spec(:TYPE_DOUBLE), do: "float | :infinity | :negative_infinity | :nan"
  def enum_to_spec(:TYPE_FLOAT), do: "float | :infinity | :negative_infinity | :nan"
  def enum_to_spec(:TYPE_INT64), do: "integer"
  def enum_to_spec(:TYPE_UINT64), do: "non_neg_integer"
  def enum_to_spec(:TYPE_INT32), do: "integer"
  def enum_to_spec(:TYPE_FIXED64), do: "non_neg_integer"
  def enum_to_spec(:TYPE_FIXED32), do: "non_neg_integer"
  def enum_to_spec(:TYPE_BOOL), do: "boolean"
  def enum_to_spec(:TYPE_STRING), do: "String.t"
  def enum_to_spec(:TYPE_BYTES), do: "binary"
  def enum_to_spec(:TYPE_UINT32), do: "non_neg_integer"
  def enum_to_spec(:TYPE_ENUM), do: "integer"
  def enum_to_spec(:TYPE_SFIXED32), do: "integer"
  def enum_to_spec(:TYPE_SFIXED64), do: "integer"
  def enum_to_spec(:TYPE_SINT32), do: "integer"
  def enum_to_spec(:TYPE_SINT64), do: "integer"
  def enum_to_spec(_), do: "any"
  def enum_to_spec(:TYPE_MESSAGE, type, true = _repeated), do: "#{type}.t"
  def enum_to_spec(:TYPE_MESSAGE, type, false = _repeated), do: "#{type}.t | nil"
  def enum_to_spec(:TYPE_ENUM, type, true = _repeated), do: "[#{type}.t]"
  def enum_to_spec(:TYPE_ENUM, type, false = _repeated), do: "#{type}.t"
end
