defmodule Benchmarks.Proto2.GoogleMessage2.Group1 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11: float | :infinity | :negative_infinity | :nan,
          field26: float | :infinity | :negative_infinity | :nan,
          field12: String.t(),
          field13: String.t(),
          field14: [String.t()],
          field15: non_neg_integer,
          field5: integer,
          field27: String.t(),
          field28: integer,
          field29: String.t(),
          field16: String.t(),
          field22: [String.t()],
          field73: [integer],
          field20: integer,
          field24: String.t(),
          field31: Benchmarks.Proto2.GoogleMessage2GroupedMessage.t() | nil
        }

  defstruct field11: 0.0,
            field26: nil,
            field12: nil,
            field13: nil,
            field14: [],
            field15: 0,
            field5: nil,
            field27: nil,
            field28: nil,
            field29: nil,
            field16: nil,
            field22: [],
            field73: [],
            field20: nil,
            field24: nil,
            field31: nil

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

  @type t :: %__MODULE__{
          field1: String.t(),
          field3: integer,
          field4: integer,
          field30: integer,
          field75: boolean,
          field6: String.t(),
          field2: binary,
          field21: integer,
          field71: integer,
          field25: float | :infinity | :negative_infinity | :nan,
          field109: integer,
          field210: integer,
          field211: integer,
          field212: integer,
          field213: integer,
          field216: integer,
          field217: integer,
          field218: integer,
          field220: integer,
          field221: integer,
          field222: float | :infinity | :negative_infinity | :nan,
          field63: integer,
          group1: [any],
          field128: [String.t()],
          field131: integer,
          field127: [String.t()],
          field129: integer,
          field130: [integer],
          field205: boolean,
          field206: boolean
        }

  defstruct field1: nil,
            field3: nil,
            field4: nil,
            field30: nil,
            field75: nil,
            field6: nil,
            field2: nil,
            field21: nil,
            field71: nil,
            field25: nil,
            field109: nil,
            field210: nil,
            field211: nil,
            field212: nil,
            field213: nil,
            field216: nil,
            field217: nil,
            field218: nil,
            field220: nil,
            field221: nil,
            field222: nil,
            field63: nil,
            group1: [],
            field128: [],
            field131: nil,
            field127: [],
            field129: nil,
            field130: [],
            field205: nil,
            field206: nil

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

  @type t :: %__MODULE__{
          field1: float | :infinity | :negative_infinity | :nan,
          field2: float | :infinity | :negative_infinity | :nan,
          field3: float | :infinity | :negative_infinity | :nan,
          field4: boolean,
          field5: boolean,
          field6: boolean,
          field7: boolean,
          field8: float | :infinity | :negative_infinity | :nan,
          field9: boolean,
          field10: float | :infinity | :negative_infinity | :nan,
          field11: integer
        }

  defstruct field1: nil,
            field2: nil,
            field3: nil,
            field4: nil,
            field5: nil,
            field6: nil,
            field7: nil,
            field8: nil,
            field9: nil,
            field10: nil,
            field11: nil

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
