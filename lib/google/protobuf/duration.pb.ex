defmodule Google.Protobuf.Duration do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32
end
