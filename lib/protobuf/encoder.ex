defmodule Protobuf.Encoder do
  def encode(struct) do
    struct
  end

  def wire_type(:int32),     do: 0
  def wire_type(:int64),     do: 0
  def wire_type(:uint32),    do: 0
  def wire_type(:uint64),    do: 0
  def wire_type(:sint32),    do: 0
  def wire_type(:sint64),    do: 0
  def wire_type(:bool),      do: 0
  def wire_type(:enum),      do: 0
  def wire_type(:fixed64),   do: 1
  def wire_type(:sfixed64),  do: 1
  def wire_type(:double),    do: 1
  def wire_type(:string),    do: 2
  def wire_type(:bytes),     do: 2
  def wire_type(:fixed32),   do: 5
  def wire_type(:sfixed32),  do: 5
  def wire_type(:float),     do: 5
  def wire_type(mod) when is_atom(mod), do: 2
end
