defmodule Benchmarks.GoogleMessage3.Message11018 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message10800 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10808: String.t(),
          field10809: integer,
          field10810: boolean,
          field10811: float | :infinity | :negative_infinity | :nan
        }

  defstruct field10808: nil,
            field10809: nil,
            field10810: nil,
            field10811: nil

  field :field10808, 1, optional: true, type: :string
  field :field10809, 2, optional: true, type: :int64
  field :field10810, 3, optional: true, type: :bool
  field :field10811, 4, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message10802 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message10748 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10750: String.t(),
          field10751: integer,
          field10752: integer,
          field10753: integer
        }

  defstruct field10750: nil,
            field10751: nil,
            field10752: nil,
            field10753: nil

  field :field10750, 1, optional: true, type: :string
  field :field10751, 2, optional: true, type: :int32
  field :field10752, 3, optional: true, type: :int32
  field :field10753, 4, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message7966 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7969: String.t(),
          field7970: boolean
        }

  defstruct field7969: nil,
            field7970: nil

  field :field7969, 1, optional: true, type: :string
  field :field7970, 2, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message708 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field823: Benchmarks.GoogleMessage3.Message741.t() | nil,
          field824: [String.t()],
          field825: String.t(),
          field826: String.t(),
          field827: [String.t()],
          field828: [String.t()]
        }

  defstruct field823: nil,
            field824: [],
            field825: nil,
            field826: nil,
            field827: [],
            field828: []

  field :field823, 1, optional: true, type: Benchmarks.GoogleMessage3.Message741
  field :field824, 6, repeated: true, type: :string
  field :field825, 2, optional: true, type: :string
  field :field826, 3, optional: true, type: :string
  field :field827, 4, repeated: true, type: :string
  field :field828, 5, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8942 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message11011 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11752: binary,
          field11753: binary
        }

  defstruct field11752: "",
            field11753: ""

  field :field11752, 1, required: true, type: :bytes
  field :field11753, 2, required: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage3.UnusedEmptyMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message741 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field936: [String.t()]
        }

  defstruct field936: []

  field :field936, 1, repeated: true, type: :string
end
