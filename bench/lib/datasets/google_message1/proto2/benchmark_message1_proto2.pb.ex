defmodule Benchmarks.Proto2.GoogleMessage1 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  field :field1, 1, required: true, type: :string
  field :field9, 9, optional: true, type: :string
  field :field18, 18, optional: true, type: :string
  field :field80, 80, optional: true, type: :bool, default: false
  field :field81, 81, optional: true, type: :bool, default: true
  field :field2, 2, required: true, type: :int32
  field :field3, 3, required: true, type: :int32
  field :field280, 280, optional: true, type: :int32
  field :field6, 6, optional: true, type: :int32, default: 0
  field :field22, 22, optional: true, type: :int64
  field :field4, 4, optional: true, type: :string
  field :field5, 5, repeated: true, type: :fixed64
  field :field59, 59, optional: true, type: :bool, default: false
  field :field7, 7, optional: true, type: :string
  field :field16, 16, optional: true, type: :int32
  field :field130, 130, optional: true, type: :int32, default: 0
  field :field12, 12, optional: true, type: :bool, default: true
  field :field17, 17, optional: true, type: :bool, default: true
  field :field13, 13, optional: true, type: :bool, default: true
  field :field14, 14, optional: true, type: :bool, default: true
  field :field104, 104, optional: true, type: :int32, default: 0
  field :field100, 100, optional: true, type: :int32, default: 0
  field :field101, 101, optional: true, type: :int32, default: 0
  field :field102, 102, optional: true, type: :string
  field :field103, 103, optional: true, type: :string
  field :field29, 29, optional: true, type: :int32, default: 0
  field :field30, 30, optional: true, type: :bool, default: false
  field :field60, 60, optional: true, type: :int32, default: -1
  field :field271, 271, optional: true, type: :int32, default: -1
  field :field272, 272, optional: true, type: :int32, default: -1
  field :field150, 150, optional: true, type: :int32
  field :field23, 23, optional: true, type: :int32, default: 0
  field :field24, 24, optional: true, type: :bool, default: false
  field :field25, 25, optional: true, type: :int32, default: 0
  field :field15, 15, optional: true, type: Benchmarks.Proto2.GoogleMessage1SubMessage
  field :field78, 78, optional: true, type: :bool
  field :field67, 67, optional: true, type: :int32, default: 0
  field :field68, 68, optional: true, type: :int32
  field :field128, 128, optional: true, type: :int32, default: 0
  field :field129, 129, optional: true, type: :string, default: "xxxxxxxxxxxxxxxxxxxxx"
  field :field131, 131, optional: true, type: :int32, default: 0
end

defmodule Benchmarks.Proto2.GoogleMessage1SubMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  field :field1, 1, optional: true, type: :int32, default: 0
  field :field2, 2, optional: true, type: :int32, default: 0
  field :field3, 3, optional: true, type: :int32, default: 0
  field :field15, 15, optional: true, type: :string
  field :field12, 12, optional: true, type: :bool, default: true
  field :field13, 13, optional: true, type: :int64
  field :field14, 14, optional: true, type: :int64
  field :field16, 16, optional: true, type: :int32
  field :field19, 19, optional: true, type: :int32, default: 2
  field :field20, 20, optional: true, type: :bool, default: true
  field :field28, 28, optional: true, type: :bool, default: true
  field :field21, 21, optional: true, type: :fixed64
  field :field22, 22, optional: true, type: :int32
  field :field23, 23, optional: true, type: :bool, default: false
  field :field206, 206, optional: true, type: :bool, default: false
  field :field203, 203, optional: true, type: :fixed32
  field :field204, 204, optional: true, type: :int32
  field :field205, 205, optional: true, type: :string
  field :field207, 207, optional: true, type: :uint64
  field :field300, 300, optional: true, type: :uint64
end
