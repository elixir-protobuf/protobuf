defmodule Protobuf.Wire.Types do
  @moduledoc "Internal wire type"

  @type wire_type() :: 0..5

  # From: https://developers.google.com/protocol-buffers/docs/encoding
  defmacro wire_varint, do: 0
  defmacro wire_64bits, do: 1
  defmacro wire_delimited, do: 2
  defmacro wire_start_group, do: 3
  defmacro wire_end_group, do: 4
  defmacro wire_32bits, do: 5
end
