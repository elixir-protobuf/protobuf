defmodule Benchmarks.Proto2.GoogleMessage1 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field1: String.t(),
          field9: String.t(),
          field18: String.t(),
          field80: boolean,
          field81: boolean,
          field2: integer,
          field3: integer,
          field280: integer,
          field6: integer,
          field22: integer,
          field4: String.t(),
          field5: [non_neg_integer],
          field59: boolean,
          field7: String.t(),
          field16: integer,
          field130: integer,
          field12: boolean,
          field17: boolean,
          field13: boolean,
          field14: boolean,
          field104: integer,
          field100: integer,
          field101: integer,
          field102: String.t(),
          field103: String.t(),
          field29: integer,
          field30: boolean,
          field60: integer,
          field271: integer,
          field272: integer,
          field150: integer,
          field23: integer,
          field24: boolean,
          field25: integer,
          field15: Benchmarks.Proto2.GoogleMessage1SubMessage.t() | nil,
          field78: boolean,
          field67: integer,
          field68: integer,
          field128: integer,
          field129: String.t(),
          field131: integer
        }

  defstruct field1: "",
            field9: nil,
            field18: nil,
            field80: nil,
            field81: nil,
            field2: 0,
            field3: 0,
            field280: nil,
            field6: nil,
            field22: nil,
            field4: nil,
            field5: [],
            field59: nil,
            field7: nil,
            field16: nil,
            field130: nil,
            field12: nil,
            field17: nil,
            field13: nil,
            field14: nil,
            field104: nil,
            field100: nil,
            field101: nil,
            field102: nil,
            field103: nil,
            field29: nil,
            field30: nil,
            field60: nil,
            field271: nil,
            field272: nil,
            field150: nil,
            field23: nil,
            field24: nil,
            field25: nil,
            field15: nil,
            field78: nil,
            field67: nil,
            field68: nil,
            field128: nil,
            field129: nil,
            field131: nil

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

  @type t :: %__MODULE__{
          field1: integer,
          field2: integer,
          field3: integer,
          field15: String.t(),
          field12: boolean,
          field13: integer,
          field14: integer,
          field16: integer,
          field19: integer,
          field20: boolean,
          field28: boolean,
          field21: non_neg_integer,
          field22: integer,
          field23: boolean,
          field206: boolean,
          field203: non_neg_integer,
          field204: integer,
          field205: String.t(),
          field207: non_neg_integer,
          field300: non_neg_integer
        }

  defstruct field1: nil,
            field2: nil,
            field3: nil,
            field15: nil,
            field12: nil,
            field13: nil,
            field14: nil,
            field16: nil,
            field19: nil,
            field20: nil,
            field28: nil,
            field21: nil,
            field22: nil,
            field23: nil,
            field206: nil,
            field203: nil,
            field204: nil,
            field205: nil,
            field207: nil,
            field300: nil

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
