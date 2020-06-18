# Modules mentioned in doctests

defmodule Color do
  @moduledoc false
  use Protobuf, syntax: :proto3, enum: true

  field :GREEN, 0
  field :RED, 1
end

defmodule Car do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct [:color, :top_speed]

  field :color, 1, type: Color, enum: true
  field :top_speed, 2, type: :float, json_name: "topSpeed"
end
