# Modules mentioned in doctests

defmodule Color do
  use Protobuf, syntax: :proto3, enum: true

  field :GREEN, 0
  field :RED, 1
end

defmodule Car do
  use Protobuf, syntax: :proto3

  field :color, 1, type: Color, enum: true
  field :top_speed, 2, type: :float, json_name: "topSpeed"
end
