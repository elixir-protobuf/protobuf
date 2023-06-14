defmodule Test.PbExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0"

  extend Test.Reply, :tag, 103, optional: true, type: :string

  extend Test.Reply, :donut, 106, optional: true, type: Test.OtherReplyExtensions
end
