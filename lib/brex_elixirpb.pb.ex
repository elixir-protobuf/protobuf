defmodule Brex.Elixirpb.FieldOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          extype: String.t(),
          enum: String.t()
        }
  defstruct [:extype, :enum]

  field :extype, 1, optional: true, type: :string
  field :enum, 2, optional: true, type: :string, deprecated: true
end

defmodule Brex.Elixirpb.EnumOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          atomize: boolean,
          lowercase: boolean,
          deprefix: boolean
        }
  defstruct [:atomize, :lowercase, :deprefix]

  field :atomize, 1, optional: true, type: :bool
  field :lowercase, 2, optional: true, type: :bool
  field :deprefix, 3, optional: true, type: :bool
end

defmodule Brex.Elixirpb.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Google.Protobuf.FieldOptions, :field, 65007,
    optional: true,
    type: Brex.Elixirpb.FieldOptions

  extend Google.Protobuf.EnumOptions, :enum, 65008,
    optional: true,
    type: Brex.Elixirpb.EnumOptions
end
