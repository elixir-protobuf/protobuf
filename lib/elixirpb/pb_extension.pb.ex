defmodule Elixirpb.PbExtension do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.12.0"

  extend Google.Protobuf.FileOptions, :file, 1047, optional: true, type: Elixirpb.FileOptions
end
