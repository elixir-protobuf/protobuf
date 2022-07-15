defmodule Elixirpb.FileOptions do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :module_prefix, 1, optional: true, type: :string
end

defmodule Elixirpb.PbExtension do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  extend Google.Protobuf.FileOptions, :file, 1047, optional: true, type: Elixirpb.FileOptions
end
