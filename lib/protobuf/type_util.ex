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
end
