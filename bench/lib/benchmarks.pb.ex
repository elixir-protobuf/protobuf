defmodule Benchmarks.BenchmarkDataset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  field :name, 1, type: :string
  field :message_name, 2, type: :string, json_name: "messageName"
  field :payload, 3, repeated: true, type: :bytes
end
