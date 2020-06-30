defmodule Benchmarks.GoogleMessage3.Message10576 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message10154 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10192: binary,
          field10193: integer
        }
  defstruct [:field10192, :field10193]

  field :field10192, 1, optional: true, type: :bytes
  field :field10193, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message8944 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9045: String.t(),
          field9046: String.t(),
          field9047: String.t(),
          field9048: String.t(),
          field9049: integer,
          field9050: integer,
          field9051: float | :infinity | :negative_infinity | :nan,
          field9052: float | :infinity | :negative_infinity | :nan,
          field9053: String.t(),
          field9054: integer,
          field9055: boolean,
          field9056: integer,
          field9057: integer,
          field9058: integer,
          field9059: float | :infinity | :negative_infinity | :nan,
          field9060: float | :infinity | :negative_infinity | :nan,
          field9061: float | :infinity | :negative_infinity | :nan,
          field9062: float | :infinity | :negative_infinity | :nan,
          field9063: float | :infinity | :negative_infinity | :nan,
          field9064: boolean,
          field9065: float | :infinity | :negative_infinity | :nan,
          field9066: integer,
          field9067: Benchmarks.GoogleMessage3.Enum8945.t(),
          field9068: integer,
          field9069: integer,
          field9070: float | :infinity | :negative_infinity | :nan,
          field9071: float | :infinity | :negative_infinity | :nan,
          field9072: integer,
          field9073: integer,
          field9074: float | :infinity | :negative_infinity | :nan,
          field9075: float | :infinity | :negative_infinity | :nan,
          field9076: integer,
          field9077: integer,
          field9078: Benchmarks.GoogleMessage3.Enum8951.t(),
          field9079: String.t(),
          field9080: String.t(),
          field9081: String.t(),
          field9082: float | :infinity | :negative_infinity | :nan,
          field9083: float | :infinity | :negative_infinity | :nan,
          field9084: float | :infinity | :negative_infinity | :nan,
          field9085: float | :infinity | :negative_infinity | :nan,
          field9086: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field9087: float | :infinity | :negative_infinity | :nan,
          field9088: float | :infinity | :negative_infinity | :nan,
          field9089: float | :infinity | :negative_infinity | :nan,
          field9090: float | :infinity | :negative_infinity | :nan,
          field9091: float | :infinity | :negative_infinity | :nan,
          field9092: float | :infinity | :negative_infinity | :nan,
          field9093: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field9094: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field9095: String.t(),
          field9096: String.t(),
          field9097: String.t(),
          field9098: String.t(),
          field9099: String.t(),
          field9100: String.t(),
          field9101: String.t(),
          field9102: String.t(),
          field9103: String.t(),
          field9104: String.t(),
          field9105: Benchmarks.GoogleMessage3.Message8939.t() | nil,
          field9106: integer
        }
  defstruct [
    :field9045,
    :field9046,
    :field9047,
    :field9048,
    :field9049,
    :field9050,
    :field9051,
    :field9052,
    :field9053,
    :field9054,
    :field9055,
    :field9056,
    :field9057,
    :field9058,
    :field9059,
    :field9060,
    :field9061,
    :field9062,
    :field9063,
    :field9064,
    :field9065,
    :field9066,
    :field9067,
    :field9068,
    :field9069,
    :field9070,
    :field9071,
    :field9072,
    :field9073,
    :field9074,
    :field9075,
    :field9076,
    :field9077,
    :field9078,
    :field9079,
    :field9080,
    :field9081,
    :field9082,
    :field9083,
    :field9084,
    :field9085,
    :field9086,
    :field9087,
    :field9088,
    :field9089,
    :field9090,
    :field9091,
    :field9092,
    :field9093,
    :field9094,
    :field9095,
    :field9096,
    :field9097,
    :field9098,
    :field9099,
    :field9100,
    :field9101,
    :field9102,
    :field9103,
    :field9104,
    :field9105,
    :field9106
  ]

  field :field9045, 2, optional: true, type: :string
  field :field9046, 3, optional: true, type: :string
  field :field9047, 23, optional: true, type: :string
  field :field9048, 52, optional: true, type: :string
  field :field9049, 53, optional: true, type: :int32
  field :field9050, 54, optional: true, type: :int32
  field :field9051, 55, optional: true, type: :float
  field :field9052, 56, optional: true, type: :float
  field :field9053, 57, optional: true, type: :string
  field :field9054, 1, optional: true, type: :int64
  field :field9055, 4, optional: true, type: :bool
  field :field9056, 5, optional: true, type: :int32
  field :field9057, 6, optional: true, type: :int32
  field :field9058, 7, optional: true, type: :int32
  field :field9059, 8, optional: true, type: :float
  field :field9060, 11, optional: true, type: :float
  field :field9061, 9, optional: true, type: :float
  field :field9062, 10, optional: true, type: :float
  field :field9063, 13, optional: true, type: :float
  field :field9064, 14, optional: true, type: :bool
  field :field9065, 70, optional: true, type: :float
  field :field9066, 71, optional: true, type: :int32
  field :field9067, 15, optional: true, type: Benchmarks.GoogleMessage3.Enum8945, enum: true
  field :field9068, 16, optional: true, type: :int32
  field :field9069, 17, optional: true, type: :int32
  field :field9070, 18, optional: true, type: :float
  field :field9071, 19, optional: true, type: :float
  field :field9072, 28, optional: true, type: :int32
  field :field9073, 29, optional: true, type: :int32
  field :field9074, 60, optional: true, type: :float
  field :field9075, 61, optional: true, type: :float
  field :field9076, 72, optional: true, type: :int32
  field :field9077, 73, optional: true, type: :int32
  field :field9078, 62, optional: true, type: Benchmarks.GoogleMessage3.Enum8951, enum: true
  field :field9079, 20, optional: true, type: :string
  field :field9080, 21, optional: true, type: :string
  field :field9081, 22, optional: true, type: :string
  field :field9082, 31, optional: true, type: :double
  field :field9083, 32, optional: true, type: :double
  field :field9084, 33, optional: true, type: :double
  field :field9085, 36, optional: true, type: :double
  field :field9086, 37, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field9087, 38, optional: true, type: :double
  field :field9088, 39, optional: true, type: :double
  field :field9089, 63, optional: true, type: :double
  field :field9090, 64, optional: true, type: :double
  field :field9091, 65, optional: true, type: :double
  field :field9092, 34, optional: true, type: :double
  field :field9093, 35, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field9094, 66, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field9095, 40, optional: true, type: :string
  field :field9096, 41, optional: true, type: :string
  field :field9097, 42, optional: true, type: :string
  field :field9098, 43, optional: true, type: :string
  field :field9099, 44, optional: true, type: :string
  field :field9100, 45, optional: true, type: :string
  field :field9101, 46, optional: true, type: :string
  field :field9102, 47, optional: true, type: :string
  field :field9103, 48, optional: true, type: :string
  field :field9104, 49, optional: true, type: :string
  field :field9105, 100, optional: true, type: Benchmarks.GoogleMessage3.Message8939
  field :field9106, 101, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage3.Message9182 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9205: String.t(),
          field9206: String.t(),
          field9207: float | :infinity | :negative_infinity | :nan,
          field9208: integer,
          field9209: integer,
          field9210: integer,
          field9211: integer,
          field9212: float | :infinity | :negative_infinity | :nan,
          field9213: float | :infinity | :negative_infinity | :nan,
          field9214: boolean,
          field9215: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field9216: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field9217: [Benchmarks.GoogleMessage3.Message9181.t()],
          field9218: boolean,
          field9219: boolean,
          field9220: boolean,
          field9221: Benchmarks.GoogleMessage3.Message9164.t() | nil,
          field9222: Benchmarks.GoogleMessage3.Message9165.t() | nil,
          field9223: Benchmarks.GoogleMessage3.Message9166.t() | nil,
          field9224: float | :infinity | :negative_infinity | :nan,
          field9225: Benchmarks.GoogleMessage3.Message9151.t() | nil,
          field9226: float | :infinity | :negative_infinity | :nan,
          field9227: float | :infinity | :negative_infinity | :nan,
          field9228: float | :infinity | :negative_infinity | :nan,
          field9229: float | :infinity | :negative_infinity | :nan,
          field9230: float | :infinity | :negative_infinity | :nan,
          __pb_extensions__: map
        }
  defstruct [
    :field9205,
    :field9206,
    :field9207,
    :field9208,
    :field9209,
    :field9210,
    :field9211,
    :field9212,
    :field9213,
    :field9214,
    :field9215,
    :field9216,
    :field9217,
    :field9218,
    :field9219,
    :field9220,
    :field9221,
    :field9222,
    :field9223,
    :field9224,
    :field9225,
    :field9226,
    :field9227,
    :field9228,
    :field9229,
    :field9230,
    :__pb_extensions__
  ]

  field :field9205, 1, optional: true, type: :string
  field :field9206, 2, optional: true, type: :string
  field :field9207, 16, optional: true, type: :float
  field :field9208, 17, optional: true, type: :int32
  field :field9209, 27, optional: true, type: :int32
  field :field9210, 7, optional: true, type: :int32
  field :field9211, 8, optional: true, type: :int32
  field :field9212, 26, optional: true, type: :float
  field :field9213, 22, optional: true, type: :float
  field :field9214, 28, optional: true, type: :bool
  field :field9215, 21, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field9216, 25, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field9217, 29, repeated: true, type: Benchmarks.GoogleMessage3.Message9181
  field :field9218, 18, optional: true, type: :bool
  field :field9219, 19, optional: true, type: :bool
  field :field9220, 20, optional: true, type: :bool
  field :field9221, 30, optional: true, type: Benchmarks.GoogleMessage3.Message9164
  field :field9222, 31, optional: true, type: Benchmarks.GoogleMessage3.Message9165
  field :field9223, 32, optional: true, type: Benchmarks.GoogleMessage3.Message9166
  field :field9224, 33, optional: true, type: :float
  field :field9225, 34, optional: true, type: Benchmarks.GoogleMessage3.Message9151
  field :field9226, 35, optional: true, type: :float
  field :field9227, 36, optional: true, type: :float
  field :field9228, 37, optional: true, type: :float
  field :field9229, 38, optional: true, type: :float
  field :field9230, 39, optional: true, type: :float

  extensions [{3, 7}, {9, 16}, {23, 24}, {24, 25}, {1000, 536_870_912}]
end

defmodule Benchmarks.GoogleMessage3.Message9160 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9161: integer,
          field9162: binary
        }
  defstruct [:field9161, :field9162]

  field :field9161, 1, optional: true, type: :int32
  field :field9162, 2, optional: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage3.Message9242 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9327: [[Benchmarks.GoogleMessage3.Enum9243.t()]]
        }
  defstruct [:field9327]

  field :field9327, 1, repeated: true, type: Benchmarks.GoogleMessage3.Enum9243, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message8890 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8916: [Benchmarks.GoogleMessage3.Message8888.t()]
        }
  defstruct [:field8916]

  field :field8916, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message8888
end

defmodule Benchmarks.GoogleMessage3.Message9123 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9135: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field9135]

  field :field9135, 1, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message9628 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9673: Benchmarks.GoogleMessage3.Message9627.t() | nil,
          field9674: String.t(),
          field9675: [integer],
          field9676: integer
        }
  defstruct [:field9673, :field9674, :field9675, :field9676]

  field :field9673, 1, optional: true, type: Benchmarks.GoogleMessage3.Message9627
  field :field9674, 2, optional: true, type: :string
  field :field9675, 3, repeated: true, type: :int32
  field :field9676, 4, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message11014 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11780: integer,
          field11781: String.t(),
          field11782: boolean,
          field11783: Benchmarks.GoogleMessage3.Enum11107.t(),
          field11784: integer,
          field11785: float | :infinity | :negative_infinity | :nan,
          field11786: integer,
          field11787: integer,
          field11788: float | :infinity | :negative_infinity | :nan,
          field11789: float | :infinity | :negative_infinity | :nan,
          field11790: integer,
          field11791: boolean,
          field11792: integer,
          field11793: boolean,
          field11794: Benchmarks.GoogleMessage3.Enum11541.t(),
          field11795: float | :infinity | :negative_infinity | :nan,
          field11796: float | :infinity | :negative_infinity | :nan,
          field11797: integer,
          field11798: integer,
          field11799: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field11800: Benchmarks.GoogleMessage3.Enum11468.t(),
          field11801: integer,
          field11802: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field11803: integer,
          field11804: integer,
          field11805: integer,
          field11806: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field11807: [Benchmarks.GoogleMessage3.Message11018.t()],
          field11808: boolean,
          field11809: boolean,
          field11810: boolean,
          field11811: boolean,
          field11812: boolean,
          field11813: boolean,
          field11814: boolean,
          field11815: Benchmarks.GoogleMessage3.Enum11107.t(),
          field11816: integer,
          field11817: float | :infinity | :negative_infinity | :nan,
          field11818: integer,
          field11819: integer,
          field11820: integer,
          field11821: integer,
          field11822: integer,
          field11823: integer,
          field11824: integer,
          field11825: float | :infinity | :negative_infinity | :nan,
          field11826: [Benchmarks.GoogleMessage3.Message11020.t()],
          field11827: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field11828: float | :infinity | :negative_infinity | :nan,
          field11829: String.t(),
          field11830: integer,
          field11831: integer,
          field11832: non_neg_integer,
          field11833: boolean,
          field11834: boolean,
          field11835: String.t(),
          field11836: integer,
          field11837: integer,
          field11838: integer,
          field11839: integer,
          field11840: Benchmarks.GoogleMessage3.Enum11022.t(),
          field11841: Benchmarks.GoogleMessage3.Message11013.t() | nil,
          field11842: float | :infinity | :negative_infinity | :nan,
          field11843: integer,
          field11844: boolean
        }
  defstruct [
    :field11780,
    :field11781,
    :field11782,
    :field11783,
    :field11784,
    :field11785,
    :field11786,
    :field11787,
    :field11788,
    :field11789,
    :field11790,
    :field11791,
    :field11792,
    :field11793,
    :field11794,
    :field11795,
    :field11796,
    :field11797,
    :field11798,
    :field11799,
    :field11800,
    :field11801,
    :field11802,
    :field11803,
    :field11804,
    :field11805,
    :field11806,
    :field11807,
    :field11808,
    :field11809,
    :field11810,
    :field11811,
    :field11812,
    :field11813,
    :field11814,
    :field11815,
    :field11816,
    :field11817,
    :field11818,
    :field11819,
    :field11820,
    :field11821,
    :field11822,
    :field11823,
    :field11824,
    :field11825,
    :field11826,
    :field11827,
    :field11828,
    :field11829,
    :field11830,
    :field11831,
    :field11832,
    :field11833,
    :field11834,
    :field11835,
    :field11836,
    :field11837,
    :field11838,
    :field11839,
    :field11840,
    :field11841,
    :field11842,
    :field11843,
    :field11844
  ]

  field :field11780, 40, optional: true, type: :int32
  field :field11781, 46, optional: true, type: :string
  field :field11782, 47, optional: true, type: :bool
  field :field11783, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum11107, enum: true
  field :field11784, 2, optional: true, type: :int32
  field :field11785, 4, optional: true, type: :double
  field :field11786, 5, optional: true, type: :int32
  field :field11787, 6, optional: true, type: :int32
  field :field11788, 7, optional: true, type: :double
  field :field11789, 8, optional: true, type: :double
  field :field11790, 9, optional: true, type: :int64
  field :field11791, 10, optional: true, type: :bool
  field :field11792, 28, optional: true, type: :int64
  field :field11793, 37, optional: true, type: :bool
  field :field11794, 44, optional: true, type: Benchmarks.GoogleMessage3.Enum11541, enum: true
  field :field11795, 49, optional: true, type: :double
  field :field11796, 51, optional: true, type: :double
  field :field11797, 54, optional: true, type: :int64
  field :field11798, 55, optional: true, type: :int64
  field :field11799, 57, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field11800, 58, optional: true, type: Benchmarks.GoogleMessage3.Enum11468, enum: true
  field :field11801, 59, optional: true, type: :int32
  field :field11802, 60, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field11803, 61, optional: true, type: :int32
  field :field11804, 62, optional: true, type: :int32
  field :field11805, 69, optional: true, type: :int32
  field :field11806, 68, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field11807, 71, repeated: true, type: Benchmarks.GoogleMessage3.Message11018
  field :field11808, 50, optional: true, type: :bool
  field :field11809, 56, optional: true, type: :bool
  field :field11810, 66, optional: true, type: :bool
  field :field11811, 63, optional: true, type: :bool
  field :field11812, 64, optional: true, type: :bool
  field :field11813, 65, optional: true, type: :bool
  field :field11814, 67, optional: true, type: :bool
  field :field11815, 15, optional: true, type: Benchmarks.GoogleMessage3.Enum11107, enum: true
  field :field11816, 16, optional: true, type: :int64
  field :field11817, 17, optional: true, type: :double
  field :field11818, 18, optional: true, type: :int64
  field :field11819, 19, optional: true, type: :int32
  field :field11820, 20, optional: true, type: :int64
  field :field11821, 42, optional: true, type: :int32
  field :field11822, 52, optional: true, type: :int64
  field :field11823, 53, optional: true, type: :int64
  field :field11824, 41, optional: true, type: :int64
  field :field11825, 48, optional: true, type: :double
  field :field11826, 70, repeated: true, type: Benchmarks.GoogleMessage3.Message11020
  field :field11827, 72, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field11828, 25, optional: true, type: :double
  field :field11829, 26, optional: true, type: :string
  field :field11830, 27, optional: true, type: :int64
  field :field11831, 32, optional: true, type: :int64
  field :field11832, 33, optional: true, type: :uint64
  field :field11833, 29, optional: true, type: :bool
  field :field11834, 34, optional: true, type: :bool
  field :field11835, 30, optional: true, type: :string
  field :field11836, 3, optional: true, type: :int32
  field :field11837, 31, optional: true, type: :int32
  field :field11838, 73, optional: true, type: :int32
  field :field11839, 35, optional: true, type: :int32
  field :field11840, 36, optional: true, type: Benchmarks.GoogleMessage3.Enum11022, enum: true
  field :field11841, 38, optional: true, type: Benchmarks.GoogleMessage3.Message11013
  field :field11842, 39, optional: true, type: :double
  field :field11843, 45, optional: true, type: :int32
  field :field11844, 74, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message10801 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10812: Benchmarks.GoogleMessage3.Message10800.t() | nil,
          field10813: [Benchmarks.GoogleMessage3.Message10802.t()],
          field10814: integer
        }
  defstruct [:field10812, :field10813, :field10814]

  field :field10812, 1, optional: true, type: Benchmarks.GoogleMessage3.Message10800
  field :field10813, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message10802
  field :field10814, 3, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message10749 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10754: [Benchmarks.GoogleMessage3.Message10748.t()]
        }
  defstruct [:field10754]

  field :field10754, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10748
end

defmodule Benchmarks.GoogleMessage3.Message8298 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8321: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8322: integer,
          field8323: String.t()
        }
  defstruct [:field8321, :field8322, :field8323]

  field :field8321, 1, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8322, 2, optional: true, type: :int64
  field :field8323, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8300 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8326: String.t(),
          field8327: Benchmarks.GoogleMessage3.Message7966.t() | nil
        }
  defstruct [:field8326, :field8327]

  field :field8326, 1, optional: true, type: :string
  field :field8327, 2, optional: true, type: Benchmarks.GoogleMessage3.Message7966
end

defmodule Benchmarks.GoogleMessage3.Message8291 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8306: String.t(),
          field8307: integer,
          field8308: String.t(),
          field8309: String.t(),
          field8310: Benchmarks.GoogleMessage3.Enum8292.t()
        }
  defstruct [:field8306, :field8307, :field8308, :field8309, :field8310]

  field :field8306, 1, optional: true, type: :string
  field :field8307, 2, optional: true, type: :int32
  field :field8308, 3, optional: true, type: :string
  field :field8309, 4, optional: true, type: :string
  field :field8310, 5, optional: true, type: Benchmarks.GoogleMessage3.Enum8292, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message8296 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8311: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8312: String.t(),
          field8313: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8314: integer,
          field8315: integer,
          field8316: String.t()
        }
  defstruct [:field8311, :field8312, :field8313, :field8314, :field8315, :field8316]

  field :field8311, 1, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8312, 2, optional: true, type: :string
  field :field8313, 3, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8314, 4, optional: true, type: :int32
  field :field8315, 5, optional: true, type: :int32
  field :field8316, 6, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message7965 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7967: integer,
          field7968: integer
        }
  defstruct [:field7967, :field7968]

  field :field7967, 1, optional: true, type: :int32
  field :field7968, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message8290 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8304: String.t(),
          field8305: String.t()
        }
  defstruct [:field8304, :field8305]

  field :field8304, 1, optional: true, type: :string
  field :field8305, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message717 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field876: [String.t()],
          field877: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field876, :field877]

  field :field876, 1, repeated: true, type: :string
  field :field877, 2, optional: true, type: :double
end

defmodule Benchmarks.GoogleMessage3.Message713 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field852: Benchmarks.GoogleMessage3.Message708.t() | nil,
          field853: [String.t()]
        }
  defstruct [:field852, :field853]

  field :field852, 1, required: true, type: Benchmarks.GoogleMessage3.Message708
  field :field853, 2, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message705 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field807: String.t(),
          field808: String.t(),
          field809: String.t(),
          field810: boolean,
          field811: String.t(),
          field812: String.t(),
          field813: [String.t()]
        }
  defstruct [:field807, :field808, :field809, :field810, :field811, :field812, :field813]

  field :field807, 1, required: true, type: :string
  field :field808, 2, optional: true, type: :string
  field :field809, 3, optional: true, type: :string
  field :field810, 4, optional: true, type: :bool
  field :field811, 5, optional: true, type: :string
  field :field812, 6, optional: true, type: :string
  field :field813, 7, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message709 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field829: [String.t()],
          field830: [String.t()],
          field831: [String.t()],
          field832: [String.t()],
          field833: [String.t()]
        }
  defstruct [:field829, :field830, :field831, :field832, :field833]

  field :field829, 1, repeated: true, type: :string
  field :field830, 2, repeated: true, type: :string
  field :field831, 3, repeated: true, type: :string
  field :field832, 4, repeated: true, type: :string
  field :field833, 5, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message702 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field793: String.t(),
          field794: String.t()
        }
  defstruct [:field793, :field794]

  field :field793, 1, optional: true, type: :string
  field :field794, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message714 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field854: String.t(),
          field855: String.t(),
          field856: String.t(),
          field857: String.t(),
          field858: non_neg_integer
        }
  defstruct [:field854, :field855, :field856, :field857, :field858]

  field :field854, 1, optional: true, type: :string
  field :field855, 2, optional: true, type: :string
  field :field856, 3, optional: true, type: :string
  field :field857, 4, optional: true, type: :string
  field :field858, 5, optional: true, type: :uint32
end

defmodule Benchmarks.GoogleMessage3.Message710 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field834: [String.t()],
          field835: String.t(),
          field836: String.t(),
          field837: [String.t()],
          field838: [String.t()]
        }
  defstruct [:field834, :field835, :field836, :field837, :field838]

  field :field834, 1, repeated: true, type: :string
  field :field835, 2, optional: true, type: :string
  field :field836, 3, optional: true, type: :string
  field :field837, 4, repeated: true, type: :string
  field :field838, 5, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message706 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field814: [String.t()],
          field815: String.t(),
          field816: [String.t()],
          field817: [String.t()]
        }
  defstruct [:field814, :field815, :field816, :field817]

  field :field814, 1, repeated: true, type: :string
  field :field815, 2, optional: true, type: :string
  field :field816, 3, repeated: true, type: :string
  field :field817, 4, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message707 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field818: String.t(),
          field819: String.t(),
          field820: String.t(),
          field821: boolean,
          field822: [String.t()]
        }
  defstruct [:field818, :field819, :field820, :field821, :field822]

  field :field818, 1, required: true, type: :string
  field :field819, 2, required: true, type: :string
  field :field820, 3, required: true, type: :string
  field :field821, 4, optional: true, type: :bool
  field :field822, 5, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message711 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field839: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field840: [String.t()],
          field841: [String.t()],
          field842: [String.t()]
        }
  defstruct [:field839, :field840, :field841, :field842]

  field :field839, 1, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field840, 4, repeated: true, type: :string
  field :field841, 2, repeated: true, type: :string
  field :field842, 3, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message712 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field843: [String.t()],
          field844: String.t(),
          field845: String.t(),
          field846: [String.t()],
          field847: [String.t()],
          field848: String.t(),
          field849: [String.t()],
          field850: String.t(),
          field851: String.t()
        }
  defstruct [
    :field843,
    :field844,
    :field845,
    :field846,
    :field847,
    :field848,
    :field849,
    :field850,
    :field851
  ]

  field :field843, 1, repeated: true, type: :string
  field :field844, 2, required: true, type: :string
  field :field845, 3, optional: true, type: :string
  field :field846, 4, repeated: true, type: :string
  field :field847, 5, repeated: true, type: :string
  field :field848, 6, optional: true, type: :string
  field :field849, 7, repeated: true, type: :string
  field :field850, 8, optional: true, type: :string
  field :field851, 9, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8939.Message8940 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message8939.Message8941 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9033: String.t(),
          field9034: String.t(),
          field9035: String.t(),
          field9036: String.t(),
          field9037: String.t(),
          field9038: String.t()
        }
  defstruct [:field9033, :field9034, :field9035, :field9036, :field9037, :field9038]

  field :field9033, 32, optional: true, type: :string
  field :field9034, 33, optional: true, type: :string
  field :field9035, 34, optional: true, type: :string
  field :field9036, 35, optional: true, type: :string
  field :field9037, 36, optional: true, type: :string
  field :field9038, 37, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8939.Message8943 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9039: String.t(),
          field9040: String.t(),
          field9041: String.t(),
          field9042: String.t(),
          field9043: String.t(),
          field9044: String.t()
        }
  defstruct [:field9039, :field9040, :field9041, :field9042, :field9043, :field9044]

  field :field9039, 1, optional: true, type: :string
  field :field9040, 2, optional: true, type: :string
  field :field9041, 3, optional: true, type: :string
  field :field9042, 4, optional: true, type: :string
  field :field9043, 5, optional: true, type: :string
  field :field9044, 6, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8939 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9010: String.t(),
          field9011: String.t(),
          field9012: String.t(),
          field9013: [String.t()],
          field9014: String.t(),
          message8940: [any],
          field9016: integer,
          field9017: integer,
          field9018: integer,
          message8941: any,
          field9020: Benchmarks.GoogleMessage3.Message8942.t() | nil,
          field9021: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field9022: [String.t()],
          field9023: String.t(),
          field9024: String.t(),
          field9025: String.t(),
          field9026: String.t(),
          field9027: String.t(),
          field9028: String.t(),
          field9029: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field9030: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          message8943: any
        }
  defstruct [
    :field9010,
    :field9011,
    :field9012,
    :field9013,
    :field9014,
    :message8940,
    :field9016,
    :field9017,
    :field9018,
    :message8941,
    :field9020,
    :field9021,
    :field9022,
    :field9023,
    :field9024,
    :field9025,
    :field9026,
    :field9027,
    :field9028,
    :field9029,
    :field9030,
    :message8943
  ]

  field :field9010, 1, optional: true, type: :string
  field :field9011, 2, optional: true, type: :string
  field :field9012, 3, optional: true, type: :string
  field :field9013, 4, repeated: true, type: :string
  field :field9014, 5, optional: true, type: :string
  field :message8940, 11, repeated: true, type: :group
  field :field9016, 21, optional: true, type: :int64
  field :field9017, 22, optional: true, type: :int64
  field :field9018, 23, optional: true, type: :int64
  field :message8941, 31, optional: true, type: :group
  field :field9020, 38, optional: true, type: Benchmarks.GoogleMessage3.Message8942
  field :field9021, 39, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field9022, 41, repeated: true, type: :string
  field :field9023, 42, optional: true, type: :string
  field :field9024, 43, optional: true, type: :string
  field :field9025, 44, optional: true, type: :string
  field :field9026, 45, optional: true, type: :string
  field :field9027, 46, optional: true, type: :string
  field :field9028, 47, optional: true, type: :string
  field :field9029, 48, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field9030, 49, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :message8943, 51, optional: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message9181 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9204: String.t()
        }
  defstruct [:field9204]

  field :field9204, 1, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message9164 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9168: integer,
          field9169: integer,
          field9170: integer
        }
  defstruct [:field9168, :field9169, :field9170]

  field :field9168, 1, optional: true, type: :int32
  field :field9169, 2, optional: true, type: :int32
  field :field9170, 3, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message9165 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9171: float | :infinity | :negative_infinity | :nan,
          field9172: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field9171, :field9172]

  field :field9171, 1, optional: true, type: :float
  field :field9172, 2, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message9166 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9173: float | :infinity | :negative_infinity | :nan,
          field9174: integer
        }
  defstruct [:field9173, :field9174]

  field :field9173, 1, optional: true, type: :float
  field :field9174, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message9151 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9152: float | :infinity | :negative_infinity | :nan,
          field9153: float | :infinity | :negative_infinity | :nan,
          field9154: float | :infinity | :negative_infinity | :nan,
          field9155: float | :infinity | :negative_infinity | :nan,
          field9156: float | :infinity | :negative_infinity | :nan,
          field9157: float | :infinity | :negative_infinity | :nan,
          field9158: float | :infinity | :negative_infinity | :nan,
          field9159: float | :infinity | :negative_infinity | :nan
        }
  defstruct [
    :field9152,
    :field9153,
    :field9154,
    :field9155,
    :field9156,
    :field9157,
    :field9158,
    :field9159
  ]

  field :field9152, 1, optional: true, type: :double
  field :field9153, 2, optional: true, type: :double
  field :field9154, 3, optional: true, type: :float
  field :field9155, 4, optional: true, type: :float
  field :field9156, 5, optional: true, type: :float
  field :field9157, 6, optional: true, type: :float
  field :field9158, 7, optional: true, type: :float
  field :field9159, 8, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message8888 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8908: integer,
          field8909: Benchmarks.GoogleMessage3.Enum8900.t(),
          field8910: [integer],
          field8911: binary
        }
  defstruct [:field8908, :field8909, :field8910, :field8911]

  field :field8908, 1, optional: true, type: :int32
  field :field8909, 4, optional: true, type: Benchmarks.GoogleMessage3.Enum8900, enum: true
  field :field8910, 2, repeated: true, type: :int32, packed: true
  field :field8911, 3, optional: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage3.Message9627 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9668: integer,
          field9669: integer,
          field9670: integer,
          field9671: integer,
          field9672: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field9668, :field9669, :field9670, :field9671, :field9672]

  field :field9668, 1, required: true, type: :int32
  field :field9669, 2, required: true, type: :int32
  field :field9670, 3, required: true, type: :int32
  field :field9671, 4, required: true, type: :int32
  field :field9672, 5, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message11020 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message11013 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11757: binary,
          field11758: binary,
          field11759: binary,
          field11760: binary,
          field11761: binary,
          field11762: binary,
          field11763: binary,
          field11764: binary,
          field11765: binary,
          field11766: binary,
          field11767: binary,
          field11768: binary,
          field11769: binary,
          field11770: binary,
          field11771: binary,
          field11772: binary,
          field11773: binary,
          field11774: binary,
          field11775: binary,
          field11776: binary,
          field11777: binary,
          field11778: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field11779: [Benchmarks.GoogleMessage3.Message11011.t()]
        }
  defstruct [
    :field11757,
    :field11758,
    :field11759,
    :field11760,
    :field11761,
    :field11762,
    :field11763,
    :field11764,
    :field11765,
    :field11766,
    :field11767,
    :field11768,
    :field11769,
    :field11770,
    :field11771,
    :field11772,
    :field11773,
    :field11774,
    :field11775,
    :field11776,
    :field11777,
    :field11778,
    :field11779
  ]

  field :field11757, 19, optional: true, type: :bytes
  field :field11758, 1, optional: true, type: :bytes
  field :field11759, 2, optional: true, type: :bytes
  field :field11760, 3, optional: true, type: :bytes
  field :field11761, 4, optional: true, type: :bytes
  field :field11762, 5, optional: true, type: :bytes
  field :field11763, 6, optional: true, type: :bytes
  field :field11764, 7, optional: true, type: :bytes
  field :field11765, 8, optional: true, type: :bytes
  field :field11766, 9, optional: true, type: :bytes
  field :field11767, 10, optional: true, type: :bytes
  field :field11768, 11, optional: true, type: :bytes
  field :field11769, 12, optional: true, type: :bytes
  field :field11770, 13, optional: true, type: :bytes
  field :field11771, 14, optional: true, type: :bytes
  field :field11772, 15, optional: true, type: :bytes
  field :field11773, 16, optional: true, type: :bytes
  field :field11774, 17, optional: true, type: :bytes
  field :field11775, 18, optional: true, type: :bytes
  field :field11776, 20, optional: true, type: :bytes
  field :field11777, 21, optional: true, type: :bytes
  field :field11778, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field11779, 22, repeated: true, type: Benchmarks.GoogleMessage3.Message11011
end
