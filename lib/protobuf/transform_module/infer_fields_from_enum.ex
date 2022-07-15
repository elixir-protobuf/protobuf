defmodule Protobuf.TransformModule.InferFieldsFromEnum do
  @moduledoc """
  For structs with a `Protobuf.TransformModule` set, the `c:Protobuf.new/1` function
  does not get called. This transform module brings back the original behavior of calling
  `c:Protobuf.new/1` before the value is encoded.
  """

  @behaviour Protobuf.TransformModule

  @impl true
  def encode(value, type), do: type.new(value)

  @impl true
  def decode(value, _type), do: value
end
