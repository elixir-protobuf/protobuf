defmodule Brex.Elixir.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Elixirpb.FieldOptions, :extype, 1000, optional: true, type: :string
end
