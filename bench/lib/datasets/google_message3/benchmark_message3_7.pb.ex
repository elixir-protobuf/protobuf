defmodule Benchmarks.GoogleMessage3.Message11018 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2
end

defmodule Benchmarks.GoogleMessage3.Message10800 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field10808, 1, optional: true, type: :string
  field :field10809, 2, optional: true, type: :int64
  field :field10810, 3, optional: true, type: :bool
  field :field10811, 4, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message10802 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2
end

defmodule Benchmarks.GoogleMessage3.Message10748 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field10750, 1, optional: true, type: :string
  field :field10751, 2, optional: true, type: :int32
  field :field10752, 3, optional: true, type: :int32
  field :field10753, 4, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message7966 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field7969, 1, optional: true, type: :string
  field :field7970, 2, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message708 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field823, 1, optional: true, type: Benchmarks.GoogleMessage3.Message741
  field :field824, 6, repeated: true, type: :string
  field :field825, 2, optional: true, type: :string
  field :field826, 3, optional: true, type: :string
  field :field827, 4, repeated: true, type: :string
  field :field828, 5, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8942 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2
end

defmodule Benchmarks.GoogleMessage3.Message11011 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field11752, 1, required: true, type: :bytes
  field :field11753, 2, required: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage3.UnusedEmptyMessage do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2
end

defmodule Benchmarks.GoogleMessage3.Message741 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.9.0-dev", syntax: :proto2

  field :field936, 1, repeated: true, type: :string
end
