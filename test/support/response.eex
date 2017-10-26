defmodule Defs.Status do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: String.t
  }
  defstruct [:status]

  field :status, 1, type: :string
end

defmodule Defs.Ping do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    payload: String.t
  }
  defstruct [:payload]

  field :payload, 1, type: :string
end

defmodule Defs.Pong do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    payload: String.t
  }
  defstruct [:payload]

  field :payload, 1, type: :string
end

defmodule Defs.PingRequest do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    ping: Defs.Ping.t
  }
  defstruct [:ping]

  field :ping, 1, type: Defs.Ping
end

defmodule Defs.PongResponse do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Defs.Status.t,
    pong:   Defs.Pong.t
  }
  defstruct [:status, :pong]

  field :status, 1, type: Defs.Status
  field :pong, 2, type: Defs.Pong
end

defmodule Defs.StatusRequest do
  use Protobuf, syntax: :proto3

  defstruct []

end

defmodule Defs.StatusResponse do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    status: Defs.Status.t
  }
  defstruct [:status]

  field :status, 1, type: Defs.Status
end

defmodule Defs.ExampleService do
  use Protobuf.Service

  rpc :ping, Defs.PingRequest, Defs.PongResponse, post: "/ping"
  rpc :status, Defs.StatusRequest, Defs.StatusResponse, get: "/status"
end
