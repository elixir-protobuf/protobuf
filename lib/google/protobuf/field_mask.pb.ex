defmodule Google.Protobuf.FieldMask do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :paths, 1, repeated: true, type: :string
end
