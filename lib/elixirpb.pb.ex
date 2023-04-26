defmodule Elixirpb.FileOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :module_prefix, 1, optional: true, type: :string
end
