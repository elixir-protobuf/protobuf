defmodule Protobuf.TypeUtil do
  def number_to_atom(1), do: :double
  def number_to_atom(2), do: :float
  def number_to_atom(3), do: :int64
  def number_to_atom(4), do: :uint64
  def number_to_atom(5), do: :int32
  def number_to_atom(6), do: :fixed64
  def number_to_atom(7), do: :fixed32
  def number_to_atom(8), do: :bool
  def number_to_atom(9), do: :string
  def number_to_atom(10), do: :group
  def number_to_atom(12), do: :bytes
  def number_to_atom(13), do: :uint32
  def number_to_atom(15), do: :sfixed32
  def number_to_atom(16), do: :sfixed64
  def number_to_atom(17), do: :sint32
  def number_to_atom(18), do: :sint64
  def number_to_atom(11), do: :message
  def number_to_atom(14), do: :enum

  def str_to_spec(1), do: "float"
  def str_to_spec(2), do: "float"
  def str_to_spec(3), do: "integer"
  def str_to_spec(4), do: "non_neg_integer"
  def str_to_spec(5), do: "integer"
  def str_to_spec(6), do: "non_neg_integer"
  def str_to_spec(7), do: "non_neg_integer"
  def str_to_spec(8), do: "boolean"
  def str_to_spec(9), do: "String.t"
  def str_to_spec(12), do: "String.t"
  def str_to_spec(13), do: "non_neg_integer"
  def str_to_spec(15), do: "integer"
  def str_to_spec(16), do: "integer"
  def str_to_spec(17), do: "integer"
  def str_to_spec(18), do: "integer"
  def str_to_spec(14), do: "integer"
  def str_to_spec(_), do: "any"
  def str_to_spec(11, type), do: "#{type}.t"
end
