defmodule Benchmarks.Proto3.GoogleMessage1 do
  @moduledoc false
  use Protobuf, syntax: :proto3

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
          field15: Benchmarks.Proto3.GoogleMessage1SubMessage.t() | nil,
          field78: boolean,
          field67: integer,
          field68: integer,
          field128: integer,
          field129: String.t(),
          field131: integer
        }

  defstruct field1: "",
            field9: "",
            field18: "",
            field80: false,
            field81: false,
            field2: 0,
            field3: 0,
            field280: 0,
            field6: 0,
            field22: 0,
            field4: "",
            field5: [],
            field59: false,
            field7: "",
            field16: 0,
            field130: 0,
            field12: false,
            field17: false,
            field13: false,
            field14: false,
            field104: 0,
            field100: 0,
            field101: 0,
            field102: "",
            field103: "",
            field29: 0,
            field30: false,
            field60: 0,
            field271: 0,
            field272: 0,
            field150: 0,
            field23: 0,
            field24: false,
            field25: 0,
            field15: nil,
            field78: false,
            field67: 0,
            field68: 0,
            field128: 0,
            field129: "",
            field131: 0

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
  use Protobuf, syntax: :proto3

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

  defstruct field1: 0,
            field2: 0,
            field3: 0,
            field15: "",
            field12: false,
            field13: 0,
            field14: 0,
            field16: 0,
            field19: 0,
            field20: false,
            field28: false,
            field21: 0,
            field22: 0,
            field23: false,
            field206: false,
            field203: 0,
            field204: 0,
            field205: "",
            field207: 0,
            field300: 0

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
