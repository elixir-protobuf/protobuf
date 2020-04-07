defmodule Elixirpb.FileOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          module_prefix: String.t(),
          __pb_extensions__: map
        }
  defstruct [:module_prefix, :__pb_extensions__]

  field :module_prefix, 1, optional: true, type: :string

  extensions [{1000, 536_870_912}]
end

defmodule Elixirpb.FieldOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{__pb_extensions__: map}
  defstruct [:__pb_extensions__]

  extensions [{1000, 536_870_912}]
end

defmodule Elixirpb.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Google.Protobuf.FileOptions, :file, 1047, optional: true, type: Elixirpb.FileOptions
  extend Google.Protobuf.FieldOptions, :field, 65007, optional: true, type: Elixirpb.FieldOptions
end
