defmodule Protobuf.WireTypes do
  @moduledoc false

  defmacro wire_varint, do: 0
  defmacro wire_64bits, do: 1
  defmacro wire_delimited, do: 2
  # defmacro wire_start_group, do: 3
  # defmacro wire_end_group, do: 4
  defmacro wire_32bits, do: 5
end
