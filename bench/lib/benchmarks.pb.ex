defmodule Benchmarks.BenchmarkDataset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          message_name: String.t(),
          payload: [String.t()]
        }
  defstruct [:name, :message_name, :payload]

  field :name, 1, type: :string
  field :message_name, 2, type: :string
  field :payload, 3, repeated: true, type: :bytes
end
