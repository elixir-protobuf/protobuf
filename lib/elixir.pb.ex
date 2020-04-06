defmodule Brex.Elixir.FieldOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          extype: String.t()
        }
  defstruct [:extype]

  field :extype, 1, optional: true, type: :string
end

defmodule Brex.Elixir.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Google.Protobuf.FieldOptions, :field, 65_007,
    optional: true,
    type: Brex.Elixir.FieldOptions
end
