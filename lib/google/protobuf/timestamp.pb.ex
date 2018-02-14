defmodule Google.Protobuf.Timestamp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          seconds: integer,
          nanos: integer
        }

  defstruct [:seconds, :nanos]

  field :seconds, 1, optional: true, type: :int64
  field :nanos, 2, optional: true, type: :int32
end
