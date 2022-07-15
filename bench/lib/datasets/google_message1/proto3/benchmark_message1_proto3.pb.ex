defmodule Benchmarks.Proto3.GoogleMessage1 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto3

  field :field1, 1, type: :string
  field :field9, 9, type: :string
  field :field18, 18, type: :string
  field :field80, 80, type: :bool
  field :field81, 81, type: :bool
  field :field2, 2, type: :int32
  field :field3, 3, type: :int32
  field :field280, 280, type: :int32
  field :field6, 6, type: :int32
  field :field22, 22, type: :int64
  field :field4, 4, type: :string
  field :field5, 5, repeated: true, type: :fixed64
  field :field59, 59, type: :bool
  field :field7, 7, type: :string
  field :field16, 16, type: :int32
  field :field130, 130, type: :int32
  field :field12, 12, type: :bool
  field :field17, 17, type: :bool
  field :field13, 13, type: :bool
  field :field14, 14, type: :bool
  field :field104, 104, type: :int32
  field :field100, 100, type: :int32
  field :field101, 101, type: :int32
  field :field102, 102, type: :string
  field :field103, 103, type: :string
  field :field29, 29, type: :int32
  field :field30, 30, type: :bool
  field :field60, 60, type: :int32
  field :field271, 271, type: :int32
  field :field272, 272, type: :int32
  field :field150, 150, type: :int32
  field :field23, 23, type: :int32
  field :field24, 24, type: :bool
  field :field25, 25, type: :int32
  field :field15, 15, type: Benchmarks.Proto3.GoogleMessage1SubMessage
  field :field78, 78, type: :bool
  field :field67, 67, type: :int32
  field :field68, 68, type: :int32
  field :field128, 128, type: :int32
  field :field129, 129, type: :string
  field :field131, 131, type: :int32
end

defmodule Benchmarks.Proto3.GoogleMessage1SubMessage do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto3

  field :field1, 1, type: :int32
  field :field2, 2, type: :int32
  field :field3, 3, type: :int32
  field :field15, 15, type: :string
  field :field12, 12, type: :bool
  field :field13, 13, type: :int64
  field :field14, 14, type: :int64
  field :field16, 16, type: :int32
  field :field19, 19, type: :int32
  field :field20, 20, type: :bool
  field :field28, 28, type: :bool
  field :field21, 21, type: :fixed64
  field :field22, 22, type: :int32
  field :field23, 23, type: :bool
  field :field206, 206, type: :bool
  field :field203, 203, type: :fixed32
  field :field204, 204, type: :int32
  field :field205, 205, type: :string
  field :field207, 207, type: :uint64
  field :field300, 300, type: :uint64
end
