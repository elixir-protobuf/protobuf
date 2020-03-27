defmodule Protobuf.Protoc.ExtTest.Foo do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          a: String.t()
        }
  defstruct [:a]

  field :a, 1, optional: true, type: :string
end

defmodule Protobuf.Protoc.ExtTest.UnixDateTime do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          microseconds: integer
        }
  defstruct [:microseconds]

  field :microseconds, 1, required: true, type: :int64
end

defmodule Protobuf.Protoc.ExtTest.FooWithUnixDateTime do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          inserted_at: DateTime.t() | nil
        }
  defstruct [:inserted_at]

  field :inserted_at, 1, optional: true, type: Protobuf.Protoc.ExtTest.UnixDateTime
end
