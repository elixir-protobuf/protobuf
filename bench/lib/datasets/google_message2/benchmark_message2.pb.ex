defmodule Benchmarks.Proto2.GoogleMessage2.Group1 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  field :field11, 11, required: true, type: :float
  field :field26, 26, optional: true, type: :float
  field :field12, 12, optional: true, type: :string
  field :field13, 13, optional: true, type: :string
  field :field14, 14, repeated: true, type: :string
  field :field15, 15, required: true, type: :uint64
  field :field5, 5, optional: true, type: :int32
  field :field27, 27, optional: true, type: :string
  field :field28, 28, optional: true, type: :int32
  field :field29, 29, optional: true, type: :string
  field :field16, 16, optional: true, type: :string
  field :field22, 22, repeated: true, type: :string
  field :field73, 73, repeated: true, type: :int32
  field :field20, 20, optional: true, type: :int32, default: 0
  field :field24, 24, optional: true, type: :string
  field :field31, 31, optional: true, type: Benchmarks.Proto2.GoogleMessage2GroupedMessage
end

defmodule Benchmarks.Proto2.GoogleMessage2 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  field :field1, 1, optional: true, type: :string
  field :field3, 3, optional: true, type: :int64
  field :field4, 4, optional: true, type: :int64
  field :field30, 30, optional: true, type: :int64
  field :field75, 75, optional: true, type: :bool, default: false
  field :field6, 6, optional: true, type: :string
  field :field2, 2, optional: true, type: :bytes
  field :field21, 21, optional: true, type: :int32, default: 0
  field :field71, 71, optional: true, type: :int32
  field :field25, 25, optional: true, type: :float
  field :field109, 109, optional: true, type: :int32, default: 0
  field :field210, 210, optional: true, type: :int32, default: 0
  field :field211, 211, optional: true, type: :int32, default: 0
  field :field212, 212, optional: true, type: :int32, default: 0
  field :field213, 213, optional: true, type: :int32, default: 0
  field :field216, 216, optional: true, type: :int32, default: 0
  field :field217, 217, optional: true, type: :int32, default: 0
  field :field218, 218, optional: true, type: :int32, default: 0
  field :field220, 220, optional: true, type: :int32, default: 0
  field :field221, 221, optional: true, type: :int32, default: 0
  field :field222, 222, optional: true, type: :float, default: 0.0
  field :field63, 63, optional: true, type: :int32
  field :group1, 10, repeated: true, type: :group
  field :field128, 128, repeated: true, type: :string
  field :field131, 131, optional: true, type: :int64
  field :field127, 127, repeated: true, type: :string
  field :field129, 129, optional: true, type: :int32
  field :field130, 130, repeated: true, type: :int64
  field :field205, 205, optional: true, type: :bool, default: false
  field :field206, 206, optional: true, type: :bool, default: false
end

defmodule Benchmarks.Proto2.GoogleMessage2GroupedMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  field :field1, 1, optional: true, type: :float
  field :field2, 2, optional: true, type: :float
  field :field3, 3, optional: true, type: :float, default: 0.0
  field :field4, 4, optional: true, type: :bool
  field :field5, 5, optional: true, type: :bool
  field :field6, 6, optional: true, type: :bool, default: true
  field :field7, 7, optional: true, type: :bool, default: false
  field :field8, 8, optional: true, type: :float
  field :field9, 9, optional: true, type: :bool
  field :field10, 10, optional: true, type: :float
  field :field11, 11, optional: true, type: :int64
end
