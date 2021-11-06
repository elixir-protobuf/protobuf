defmodule Benchmarks.GoogleMessage3.Message35546.Message35547 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35569: integer,
          field35570: integer
        }

  defstruct [:field35569, :field35570]

  field :field35569, 5, required: true, type: :int32
  field :field35570, 6, required: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message35546.Message35548 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35571: integer,
          field35572: integer
        }

  defstruct [:field35571, :field35572]

  field :field35571, 11, required: true, type: :int64
  field :field35572, 12, required: true, type: :int64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message35546 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35556: integer,
          field35557: integer,
          field35558: boolean,
          field35559: integer,
          message35547: any,
          message35548: any,
          field35562: boolean,
          field35563: boolean,
          field35564: integer,
          field35565: boolean,
          field35566: boolean,
          field35567: String.t()
        }

  defstruct [
    :field35556,
    :field35557,
    :field35558,
    :field35559,
    :message35547,
    :message35548,
    :field35562,
    :field35563,
    :field35564,
    :field35565,
    :field35566,
    :field35567
  ]

  field :field35556, 1, optional: true, type: :int64
  field :field35557, 2, optional: true, type: :int32
  field :field35558, 3, optional: true, type: :bool
  field :field35559, 13, optional: true, type: :int64
  field :message35547, 4, optional: true, type: :group
  field :message35548, 10, optional: true, type: :group
  field :field35562, 14, optional: true, type: :bool
  field :field35563, 15, optional: true, type: :bool
  field :field35564, 16, optional: true, type: :int32
  field :field35565, 17, optional: true, type: :bool
  field :field35566, 18, optional: true, type: :bool
  field :field35567, 100, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message2356.Message2357 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2399: integer,
          field2400: integer,
          field2401: integer,
          field2402: integer,
          field2403: integer,
          field2404: integer,
          field2405: integer,
          field2406: binary,
          field2407: integer,
          field2408: integer,
          field2409: boolean,
          field2410: binary
        }

  defstruct [
    :field2399,
    :field2400,
    :field2401,
    :field2402,
    :field2403,
    :field2404,
    :field2405,
    :field2406,
    :field2407,
    :field2408,
    :field2409,
    :field2410
  ]

  field :field2399, 9, optional: true, type: :int64
  field :field2400, 10, optional: true, type: :int32
  field :field2401, 11, optional: true, type: :int32
  field :field2402, 12, optional: true, type: :int32
  field :field2403, 13, optional: true, type: :int32
  field :field2404, 116, optional: true, type: :int32
  field :field2405, 106, optional: true, type: :int32
  field :field2406, 14, required: true, type: :bytes
  field :field2407, 45, optional: true, type: :int32
  field :field2408, 112, optional: true, type: :int32
  field :field2409, 122, optional: true, type: :bool
  field :field2410, 124, optional: true, type: :bytes
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message2356.Message2358 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message2356.Message2359 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2413: String.t(),
          field2414: String.t(),
          field2415: String.t(),
          field2416: String.t(),
          field2417: integer,
          field2418: String.t(),
          field2419: float | :infinity | :negative_infinity | :nan,
          field2420: float | :infinity | :negative_infinity | :nan
        }

  defstruct [
    :field2413,
    :field2414,
    :field2415,
    :field2416,
    :field2417,
    :field2418,
    :field2419,
    :field2420
  ]

  field :field2413, 41, optional: true, type: :string
  field :field2414, 42, optional: true, type: :string
  field :field2415, 43, optional: true, type: :string
  field :field2416, 44, optional: true, type: :string
  field :field2417, 46, optional: true, type: :int32
  field :field2418, 47, optional: true, type: :string
  field :field2419, 110, optional: true, type: :float
  field :field2420, 111, optional: true, type: :float
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message2356 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2368: Benchmarks.GoogleMessage3.Message1374.t() | nil,
          field2369: non_neg_integer,
          field2370: integer,
          field2371: integer,
          field2372: String.t(),
          field2373: integer,
          field2374: binary,
          field2375: String.t(),
          field2376: String.t(),
          field2377: integer,
          field2378: integer,
          field2379: integer,
          field2380: integer,
          field2381: integer,
          field2382: integer,
          field2383: integer,
          field2384: integer,
          field2385: integer,
          field2386: integer,
          field2387: binary,
          message2357: any,
          field2389: String.t(),
          message2358: any,
          message2359: [any],
          field2392: integer,
          field2393: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field2394: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field2395: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field2396: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field2397: String.t(),
          field2398: String.t()
        }

  defstruct [
    :field2368,
    :field2369,
    :field2370,
    :field2371,
    :field2372,
    :field2373,
    :field2374,
    :field2375,
    :field2376,
    :field2377,
    :field2378,
    :field2379,
    :field2380,
    :field2381,
    :field2382,
    :field2383,
    :field2384,
    :field2385,
    :field2386,
    :field2387,
    :message2357,
    :field2389,
    :message2358,
    :message2359,
    :field2392,
    :field2393,
    :field2394,
    :field2395,
    :field2396,
    :field2397,
    :field2398
  ]

  field :field2368, 121, optional: true, type: Benchmarks.GoogleMessage3.Message1374
  field :field2369, 1, optional: true, type: :uint64
  field :field2370, 2, optional: true, type: :int32
  field :field2371, 17, optional: true, type: :int32
  field :field2372, 3, required: true, type: :string
  field :field2373, 7, optional: true, type: :int32
  field :field2374, 8, optional: true, type: :bytes
  field :field2375, 4, optional: true, type: :string
  field :field2376, 101, optional: true, type: :string
  field :field2377, 102, optional: true, type: :int32
  field :field2378, 103, optional: true, type: :int32
  field :field2379, 104, optional: true, type: :int32
  field :field2380, 113, optional: true, type: :int32
  field :field2381, 114, optional: true, type: :int32
  field :field2382, 115, optional: true, type: :int32
  field :field2383, 117, optional: true, type: :int32
  field :field2384, 118, optional: true, type: :int32
  field :field2385, 119, optional: true, type: :int32
  field :field2386, 105, optional: true, type: :int32
  field :field2387, 5, optional: true, type: :bytes
  field :message2357, 6, optional: true, type: :group
  field :field2389, 120, optional: true, type: :string
  field :message2358, 107, optional: true, type: :group
  field :message2359, 40, repeated: true, type: :group
  field :field2392, 50, optional: true, type: :int32
  field :field2393, 60, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field2394, 70, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field2395, 80, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field2396, 90, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field2397, 100, optional: true, type: :string
  field :field2398, 123, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message7029.Message7030 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7226: String.t(),
          field7227: String.t(),
          field7228: integer
        }

  defstruct [:field7226, :field7227, :field7228]

  field :field7226, 14, optional: true, type: :string
  field :field7227, 15, optional: true, type: :string
  field :field7228, 16, optional: true, type: :int64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message7029.Message7031 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7229: String.t(),
          field7230: integer,
          field7231: integer,
          field7232: integer,
          field7233: integer,
          field7234: integer
        }

  defstruct [:field7229, :field7230, :field7231, :field7232, :field7233, :field7234]

  field :field7229, 22, optional: true, type: :string
  field :field7230, 23, optional: true, type: :int32
  field :field7231, 24, optional: true, type: :int32
  field :field7232, 30, optional: true, type: :int32
  field :field7233, 31, optional: true, type: :int32
  field :field7234, 35, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message7029 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7183: integer,
          field7184: integer,
          field7185: integer,
          field7186: integer,
          field7187: integer,
          field7188: integer,
          field7189: integer,
          field7190: integer,
          field7191: integer,
          field7192: integer,
          field7193: integer,
          field7194: integer,
          field7195: integer,
          field7196: integer,
          field7197: integer,
          field7198: integer,
          field7199: integer,
          field7200: integer,
          field7201: integer,
          field7202: integer,
          field7203: integer,
          field7204: integer,
          field7205: integer,
          field7206: integer,
          message7030: [any],
          message7031: [any],
          field7209: integer,
          field7210: float | :infinity | :negative_infinity | :nan,
          field7211: integer,
          field7212: integer,
          field7213: String.t(),
          field7214: boolean,
          field7215: integer,
          field7216: float | :infinity | :negative_infinity | :nan,
          field7217: boolean,
          field7218: boolean,
          field7219: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field7220: integer,
          field7221: integer,
          field7222: integer,
          field7223: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field7224: integer
        }

  defstruct [
    :field7183,
    :field7184,
    :field7185,
    :field7186,
    :field7187,
    :field7188,
    :field7189,
    :field7190,
    :field7191,
    :field7192,
    :field7193,
    :field7194,
    :field7195,
    :field7196,
    :field7197,
    :field7198,
    :field7199,
    :field7200,
    :field7201,
    :field7202,
    :field7203,
    :field7204,
    :field7205,
    :field7206,
    :message7030,
    :message7031,
    :field7209,
    :field7210,
    :field7211,
    :field7212,
    :field7213,
    :field7214,
    :field7215,
    :field7216,
    :field7217,
    :field7218,
    :field7219,
    :field7220,
    :field7221,
    :field7222,
    :field7223,
    :field7224
  ]

  field :field7183, 1, required: true, type: :int32
  field :field7184, 2, optional: true, type: :int32
  field :field7185, 3, optional: true, type: :int32
  field :field7186, 4, optional: true, type: :int32
  field :field7187, 5, optional: true, type: :int32
  field :field7188, 6, optional: true, type: :int32
  field :field7189, 17, optional: true, type: :int32
  field :field7190, 18, optional: true, type: :int32
  field :field7191, 49, optional: true, type: :int32
  field :field7192, 28, optional: true, type: :int32
  field :field7193, 33, optional: true, type: :int32
  field :field7194, 25, optional: true, type: :int32
  field :field7195, 26, optional: true, type: :int32
  field :field7196, 40, optional: true, type: :int32
  field :field7197, 41, optional: true, type: :int32
  field :field7198, 42, optional: true, type: :int32
  field :field7199, 43, optional: true, type: :int32
  field :field7200, 19, optional: true, type: :int32
  field :field7201, 7, optional: true, type: :int32
  field :field7202, 8, optional: true, type: :int32
  field :field7203, 9, optional: true, type: :int32
  field :field7204, 10, optional: true, type: :int32
  field :field7205, 11, optional: true, type: :int32
  field :field7206, 12, optional: true, type: :int32
  field :message7030, 13, repeated: true, type: :group
  field :message7031, 21, repeated: true, type: :group
  field :field7209, 20, optional: true, type: :int32
  field :field7210, 27, optional: true, type: :float
  field :field7211, 29, optional: true, type: :int32
  field :field7212, 32, optional: true, type: :int32
  field :field7213, 48, optional: true, type: :string
  field :field7214, 34, optional: true, type: :bool
  field :field7215, 36, optional: true, type: :int32
  field :field7216, 37, optional: true, type: :float
  field :field7217, 38, optional: true, type: :bool
  field :field7218, 39, optional: true, type: :bool
  field :field7219, 44, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field7220, 45, optional: true, type: :int32
  field :field7221, 46, optional: true, type: :int32
  field :field7222, 47, optional: true, type: :int32
  field :field7223, 50, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field7224, 51, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message35538 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35539: integer
        }

  defstruct [:field35539]

  field :field35539, 1, required: true, type: :int64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message18921.Message18922 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18959: non_neg_integer,
          field18960: String.t(),
          field18961: boolean,
          field18962: boolean,
          field18963: integer,
          field18964: integer,
          field18965: String.t(),
          field18966: Benchmarks.GoogleMessage3.Message18856.t() | nil,
          field18967: non_neg_integer,
          field18968: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18969: non_neg_integer,
          field18970: float | :infinity | :negative_infinity | :nan,
          field18971: [String.t()],
          field18972: boolean,
          field18973: boolean,
          field18974: float | :infinity | :negative_infinity | :nan,
          field18975: integer,
          field18976: integer,
          field18977: integer,
          field18978: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18979: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field18980: [String.t()],
          field18981: float | :infinity | :negative_infinity | :nan
        }

  defstruct [
    :field18959,
    :field18960,
    :field18961,
    :field18962,
    :field18963,
    :field18964,
    :field18965,
    :field18966,
    :field18967,
    :field18968,
    :field18969,
    :field18970,
    :field18971,
    :field18972,
    :field18973,
    :field18974,
    :field18975,
    :field18976,
    :field18977,
    :field18978,
    :field18979,
    :field18980,
    :field18981
  ]

  field :field18959, 6, optional: true, type: :uint64
  field :field18960, 13, optional: true, type: :string
  field :field18961, 21, optional: true, type: :bool
  field :field18962, 33, optional: true, type: :bool
  field :field18963, 7, optional: true, type: :int32
  field :field18964, 8, optional: true, type: :int32
  field :field18965, 9, optional: true, type: :string
  field :field18966, 10, optional: true, type: Benchmarks.GoogleMessage3.Message18856
  field :field18967, 34, optional: true, type: :uint64
  field :field18968, 11, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18969, 35, optional: true, type: :uint64
  field :field18970, 12, optional: true, type: :float
  field :field18971, 14, repeated: true, type: :string
  field :field18972, 15, optional: true, type: :bool
  field :field18973, 16, optional: true, type: :bool
  field :field18974, 22, optional: true, type: :float
  field :field18975, 18, optional: true, type: :int32
  field :field18976, 19, optional: true, type: :int32
  field :field18977, 20, optional: true, type: :int32
  field :field18978, 25, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18979, 26, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field18980, 27, repeated: true, type: :string
  field :field18981, 28, optional: true, type: :float
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message18921 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18946: String.t(),
          field18947: non_neg_integer,
          field18948: integer,
          field18949: float | :infinity | :negative_infinity | :nan,
          field18950: boolean,
          field18951: boolean,
          field18952: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          message18922: [any],
          field18954: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field18955: [Benchmarks.GoogleMessage3.Message18943.t()],
          field18956: [Benchmarks.GoogleMessage3.Message18944.t()],
          field18957: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct [
    :field18946,
    :field18947,
    :field18948,
    :field18949,
    :field18950,
    :field18951,
    :field18952,
    :message18922,
    :field18954,
    :field18955,
    :field18956,
    :field18957
  ]

  field :field18946, 1, optional: true, type: :string
  field :field18947, 2, optional: true, type: :fixed64
  field :field18948, 3, optional: true, type: :int32
  field :field18949, 4, optional: true, type: :double
  field :field18950, 17, optional: true, type: :bool
  field :field18951, 23, optional: true, type: :bool
  field :field18952, 24, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :message18922, 5, repeated: true, type: :group
  field :field18954, 29, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18955, 30, repeated: true, type: Benchmarks.GoogleMessage3.Message18943
  field :field18956, 31, repeated: true, type: Benchmarks.GoogleMessage3.Message18944
  field :field18957, 32, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message35540 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35541: boolean
        }

  defstruct [:field35541]

  field :field35541, 1, optional: true, type: :bool
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message3886.Message3887 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3932: String.t(),
          field3933: String.t(),
          field3934: Benchmarks.GoogleMessage3.Message3850.t() | nil,
          field3935: binary
        }

  defstruct [:field3932, :field3933, :field3934, :field3935]

  field :field3932, 2, required: true, type: :string
  field :field3933, 9, optional: true, type: :string
  field :field3934, 3, optional: true, type: Benchmarks.GoogleMessage3.Message3850
  field :field3935, 8, optional: true, type: :bytes
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message3886 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message3887: [any]
        }

  defstruct [:message3887]

  field :message3887, 1, repeated: true, type: :group
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message6743 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6759: Benchmarks.GoogleMessage3.Message6721.t() | nil,
          field6760: Benchmarks.GoogleMessage3.Message6723.t() | nil,
          field6761: Benchmarks.GoogleMessage3.Message6723.t() | nil,
          field6762: Benchmarks.GoogleMessage3.Message6725.t() | nil,
          field6763: Benchmarks.GoogleMessage3.Message6726.t() | nil,
          field6764: Benchmarks.GoogleMessage3.Message6733.t() | nil,
          field6765: Benchmarks.GoogleMessage3.Message6734.t() | nil,
          field6766: Benchmarks.GoogleMessage3.Message6742.t() | nil
        }

  defstruct [
    :field6759,
    :field6760,
    :field6761,
    :field6762,
    :field6763,
    :field6764,
    :field6765,
    :field6766
  ]

  field :field6759, 1, optional: true, type: Benchmarks.GoogleMessage3.Message6721
  field :field6760, 2, optional: true, type: Benchmarks.GoogleMessage3.Message6723
  field :field6761, 8, optional: true, type: Benchmarks.GoogleMessage3.Message6723
  field :field6762, 3, optional: true, type: Benchmarks.GoogleMessage3.Message6725
  field :field6763, 4, optional: true, type: Benchmarks.GoogleMessage3.Message6726
  field :field6764, 5, optional: true, type: Benchmarks.GoogleMessage3.Message6733
  field :field6765, 6, optional: true, type: Benchmarks.GoogleMessage3.Message6734
  field :field6766, 7, optional: true, type: Benchmarks.GoogleMessage3.Message6742
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message6773 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6794: Benchmarks.GoogleMessage3.Enum6769.t(),
          field6795: integer,
          field6796: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field6797: integer,
          field6798: integer,
          field6799: Benchmarks.GoogleMessage3.Enum6774.t(),
          field6800: float | :infinity | :negative_infinity | :nan,
          field6801: float | :infinity | :negative_infinity | :nan,
          field6802: float | :infinity | :negative_infinity | :nan,
          field6803: Benchmarks.GoogleMessage3.Enum6782.t()
        }

  defstruct [
    :field6794,
    :field6795,
    :field6796,
    :field6797,
    :field6798,
    :field6799,
    :field6800,
    :field6801,
    :field6802,
    :field6803
  ]

  field :field6794, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum6769, enum: true
  field :field6795, 9, optional: true, type: :int32
  field :field6796, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field6797, 11, optional: true, type: :int32
  field :field6798, 2, optional: true, type: :int32
  field :field6799, 3, optional: true, type: Benchmarks.GoogleMessage3.Enum6774, enum: true
  field :field6800, 5, optional: true, type: :double
  field :field6801, 7, optional: true, type: :double
  field :field6802, 8, optional: true, type: :double
  field :field6803, 6, optional: true, type: Benchmarks.GoogleMessage3.Enum6782, enum: true
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message8224 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8255: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8256: Benchmarks.GoogleMessage3.Message8184.t() | nil,
          field8257: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8258: String.t(),
          field8259: String.t(),
          field8260: boolean,
          field8261: integer,
          field8262: String.t(),
          field8263: integer,
          field8264: float | :infinity | :negative_infinity | :nan,
          field8265: integer,
          field8266: [String.t()],
          field8267: integer,
          field8268: integer,
          field8269: integer,
          field8270: integer,
          field8271: float | :infinity | :negative_infinity | :nan,
          field8272: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8273: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8274: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field8275: boolean,
          field8276: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8277: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8278: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field8279: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8280: boolean,
          field8281: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct [
    :field8255,
    :field8256,
    :field8257,
    :field8258,
    :field8259,
    :field8260,
    :field8261,
    :field8262,
    :field8263,
    :field8264,
    :field8265,
    :field8266,
    :field8267,
    :field8268,
    :field8269,
    :field8270,
    :field8271,
    :field8272,
    :field8273,
    :field8274,
    :field8275,
    :field8276,
    :field8277,
    :field8278,
    :field8279,
    :field8280,
    :field8281
  ]

  field :field8255, 1, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8256, 2, optional: true, type: Benchmarks.GoogleMessage3.Message8184
  field :field8257, 3, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8258, 4, optional: true, type: :string
  field :field8259, 5, optional: true, type: :string
  field :field8260, 6, optional: true, type: :bool
  field :field8261, 7, optional: true, type: :int64
  field :field8262, 8, optional: true, type: :string
  field :field8263, 9, optional: true, type: :int64
  field :field8264, 10, optional: true, type: :double
  field :field8265, 11, optional: true, type: :int64
  field :field8266, 12, repeated: true, type: :string
  field :field8267, 13, optional: true, type: :int64
  field :field8268, 14, optional: true, type: :int32
  field :field8269, 15, optional: true, type: :int32
  field :field8270, 16, optional: true, type: :int64
  field :field8271, 17, optional: true, type: :double
  field :field8272, 18, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8273, 19, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8274, 20, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8275, 21, optional: true, type: :bool
  field :field8276, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8277, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8278, 24, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8279, 25, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8280, 26, optional: true, type: :bool
  field :field8281, 27, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message8392 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8395: String.t(),
          field8396: String.t(),
          field8397: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8398: String.t(),
          field8399: String.t(),
          field8400: String.t(),
          field8401: String.t(),
          field8402: String.t(),
          field8403: String.t()
        }

  defstruct [
    :field8395,
    :field8396,
    :field8397,
    :field8398,
    :field8399,
    :field8400,
    :field8401,
    :field8402,
    :field8403
  ]

  field :field8395, 1, optional: true, type: :string
  field :field8396, 2, optional: true, type: :string
  field :field8397, 3, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8398, 4, optional: true, type: :string
  field :field8399, 5, optional: true, type: :string
  field :field8400, 6, optional: true, type: :string
  field :field8401, 7, optional: true, type: :string
  field :field8402, 8, optional: true, type: :string
  field :field8403, 9, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message8130 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8156: String.t(),
          field8157: String.t(),
          field8158: String.t(),
          field8159: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8160: [String.t()],
          field8161: integer,
          field8162: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8163: String.t(),
          field8164: String.t(),
          field8165: String.t(),
          field8166: String.t(),
          field8167: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8168: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8169: String.t(),
          field8170: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field8171: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field8172: boolean,
          field8173: boolean,
          field8174: float | :infinity | :negative_infinity | :nan,
          field8175: integer,
          field8176: integer,
          field8177: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field8178: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field8179: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct [
    :field8156,
    :field8157,
    :field8158,
    :field8159,
    :field8160,
    :field8161,
    :field8162,
    :field8163,
    :field8164,
    :field8165,
    :field8166,
    :field8167,
    :field8168,
    :field8169,
    :field8170,
    :field8171,
    :field8172,
    :field8173,
    :field8174,
    :field8175,
    :field8176,
    :field8177,
    :field8178,
    :field8179
  ]

  field :field8156, 1, optional: true, type: :string
  field :field8157, 2, optional: true, type: :string
  field :field8158, 4, optional: true, type: :string
  field :field8159, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8160, 7, repeated: true, type: :string
  field :field8161, 8, optional: true, type: :int64
  field :field8162, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8163, 10, optional: true, type: :string
  field :field8164, 11, optional: true, type: :string
  field :field8165, 12, optional: true, type: :string
  field :field8166, 13, optional: true, type: :string
  field :field8167, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8168, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8169, 16, optional: true, type: :string
  field :field8170, 17, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field8171, 18, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field8172, 19, optional: true, type: :bool
  field :field8173, 20, optional: true, type: :bool
  field :field8174, 21, optional: true, type: :double
  field :field8175, 22, optional: true, type: :int32
  field :field8176, 23, optional: true, type: :int32
  field :field8177, 24, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8178, 25, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field8179, 26, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message8478 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8489: String.t(),
          field8490: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8491: Benchmarks.GoogleMessage3.Message8476.t() | nil,
          field8492: integer,
          field8493: Benchmarks.GoogleMessage3.Message8476.t() | nil,
          field8494: [Benchmarks.GoogleMessage3.Message8477.t()],
          field8495: Benchmarks.GoogleMessage3.Message8454.t() | nil,
          field8496: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct [
    :field8489,
    :field8490,
    :field8491,
    :field8492,
    :field8493,
    :field8494,
    :field8495,
    :field8496
  ]

  field :field8489, 7, optional: true, type: :string
  field :field8490, 1, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8491, 2, optional: true, type: Benchmarks.GoogleMessage3.Message8476
  field :field8492, 3, optional: true, type: :int64
  field :field8493, 4, optional: true, type: Benchmarks.GoogleMessage3.Message8476
  field :field8494, 5, repeated: true, type: Benchmarks.GoogleMessage3.Message8477
  field :field8495, 6, optional: true, type: Benchmarks.GoogleMessage3.Message8454
  field :field8496, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message8479 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8497: Benchmarks.GoogleMessage3.Message8475.t() | nil,
          field8498: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8499: Benchmarks.GoogleMessage3.Message8476.t() | nil,
          field8500: Benchmarks.GoogleMessage3.Message8476.t() | nil,
          field8501: String.t(),
          field8502: String.t(),
          field8503: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8504: Benchmarks.GoogleMessage3.Message8455.t() | nil,
          field8505: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct [
    :field8497,
    :field8498,
    :field8499,
    :field8500,
    :field8501,
    :field8502,
    :field8503,
    :field8504,
    :field8505
  ]

  field :field8497, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8475
  field :field8498, 2, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8499, 3, optional: true, type: Benchmarks.GoogleMessage3.Message8476
  field :field8500, 4, optional: true, type: Benchmarks.GoogleMessage3.Message8476
  field :field8501, 6, optional: true, type: :string
  field :field8502, 7, optional: true, type: :string
  field :field8503, 8, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8504, 5, optional: true, type: Benchmarks.GoogleMessage3.Message8455
  field :field8505, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message10319 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10340: Benchmarks.GoogleMessage3.Enum10325.t(),
          field10341: integer,
          field10342: integer,
          field10343: binary,
          field10344: String.t(),
          field10345: String.t(),
          field10346: String.t()
        }

  defstruct [
    :field10340,
    :field10341,
    :field10342,
    :field10343,
    :field10344,
    :field10345,
    :field10346
  ]

  field :field10340, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum10325, enum: true
  field :field10341, 4, optional: true, type: :int32
  field :field10342, 5, optional: true, type: :int32
  field :field10343, 3, optional: true, type: :bytes
  field :field10344, 2, optional: true, type: :string
  field :field10345, 6, optional: true, type: :string
  field :field10346, 7, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message4016 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4017: integer,
          field4018: integer,
          field4019: integer,
          field4020: integer
        }

  defstruct [:field4017, :field4018, :field4019, :field4020]

  field :field4017, 1, required: true, type: :int32
  field :field4018, 2, required: true, type: :int32
  field :field4019, 3, required: true, type: :int32
  field :field4020, 4, required: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message12669 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12681: Benchmarks.GoogleMessage3.Message12559.t() | nil,
          field12682: float | :infinity | :negative_infinity | :nan,
          field12683: boolean,
          field12684: Benchmarks.GoogleMessage3.Enum12670.t()
        }

  defstruct [:field12681, :field12682, :field12683, :field12684]

  field :field12681, 1, optional: true, type: Benchmarks.GoogleMessage3.Message12559
  field :field12682, 2, optional: true, type: :float
  field :field12683, 3, optional: true, type: :bool
  field :field12684, 4, optional: true, type: Benchmarks.GoogleMessage3.Enum12670, enum: true
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message12819 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12834: float | :infinity | :negative_infinity | :nan,
          field12835: float | :infinity | :negative_infinity | :nan,
          field12836: float | :infinity | :negative_infinity | :nan,
          field12837: float | :infinity | :negative_infinity | :nan,
          field12838: float | :infinity | :negative_infinity | :nan,
          field12839: float | :infinity | :negative_infinity | :nan
        }

  defstruct [:field12834, :field12835, :field12836, :field12837, :field12838, :field12839]

  field :field12834, 1, optional: true, type: :double
  field :field12835, 2, optional: true, type: :double
  field :field12836, 3, optional: true, type: :double
  field :field12837, 4, optional: true, type: :double
  field :field12838, 5, optional: true, type: :double
  field :field12839, 6, optional: true, type: :double
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message12820 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12840: integer,
          field12841: integer,
          field12842: integer,
          field12843: integer,
          field12844: integer,
          field12845: integer,
          field12846: integer,
          field12847: integer
        }

  defstruct [
    :field12840,
    :field12841,
    :field12842,
    :field12843,
    :field12844,
    :field12845,
    :field12846,
    :field12847
  ]

  field :field12840, 1, optional: true, type: :int32
  field :field12841, 2, optional: true, type: :int32
  field :field12842, 3, optional: true, type: :int32
  field :field12843, 8, optional: true, type: :int32
  field :field12844, 4, optional: true, type: :int32
  field :field12845, 5, optional: true, type: :int32
  field :field12846, 6, optional: true, type: :int32
  field :field12847, 7, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message12821 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12848: integer,
          field12849: integer,
          field12850: integer,
          field12851: integer,
          field12852: integer
        }

  defstruct [:field12848, :field12849, :field12850, :field12851, :field12852]

  field :field12848, 1, optional: true, type: :int32
  field :field12849, 2, optional: true, type: :int32
  field :field12850, 3, optional: true, type: :int32
  field :field12851, 4, optional: true, type: :int32
  field :field12852, 5, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message12818 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12829: non_neg_integer,
          field12830: integer,
          field12831: integer,
          field12832: integer,
          field12833: [Benchmarks.GoogleMessage3.Message12817.t()]
        }

  defstruct [:field12829, :field12830, :field12831, :field12832, :field12833]

  field :field12829, 1, optional: true, type: :uint64
  field :field12830, 2, optional: true, type: :int32
  field :field12831, 3, optional: true, type: :int32
  field :field12832, 5, optional: true, type: :int32
  field :field12833, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message12817
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message16479 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16484: Benchmarks.GoogleMessage3.Message16480.t() | nil,
          field16485: integer,
          field16486: float | :infinity | :negative_infinity | :nan,
          field16487: non_neg_integer,
          field16488: boolean,
          field16489: non_neg_integer
        }

  defstruct [:field16484, :field16485, :field16486, :field16487, :field16488, :field16489]

  field :field16484, 1, optional: true, type: Benchmarks.GoogleMessage3.Message16480
  field :field16485, 5, optional: true, type: :int32
  field :field16486, 2, optional: true, type: :float
  field :field16487, 4, optional: true, type: :uint32
  field :field16488, 3, optional: true, type: :bool
  field :field16489, 6, optional: true, type: :uint32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message16722 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16752: String.t(),
          field16753: String.t(),
          field16754: String.t(),
          field16755: integer,
          field16756: String.t()
        }

  defstruct [:field16752, :field16753, :field16754, :field16755, :field16756]

  field :field16752, 1, optional: true, type: :string
  field :field16753, 2, optional: true, type: :string
  field :field16754, 3, optional: true, type: :string
  field :field16755, 5, optional: true, type: :int32
  field :field16756, 4, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message16724 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16761: integer,
          field16762: float | :infinity | :negative_infinity | :nan,
          field16763: integer,
          field16764: integer,
          field16765: boolean,
          field16766: [String.t()],
          field16767: [String.t()],
          field16768: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field16769: boolean,
          field16770: non_neg_integer,
          field16771: Benchmarks.GoogleMessage3.Enum16728.t(),
          field16772: [integer],
          field16773: boolean
        }

  defstruct [
    :field16761,
    :field16762,
    :field16763,
    :field16764,
    :field16765,
    :field16766,
    :field16767,
    :field16768,
    :field16769,
    :field16770,
    :field16771,
    :field16772,
    :field16773
  ]

  field :field16761, 1, optional: true, type: :int64
  field :field16762, 2, optional: true, type: :float
  field :field16763, 3, optional: true, type: :int64
  field :field16764, 4, optional: true, type: :int64
  field :field16765, 5, optional: true, type: :bool
  field :field16766, 6, repeated: true, type: :string
  field :field16767, 7, repeated: true, type: :string
  field :field16768, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16769, 9, optional: true, type: :bool
  field :field16770, 10, optional: true, type: :uint32
  field :field16771, 11, optional: true, type: Benchmarks.GoogleMessage3.Enum16728, enum: true
  field :field16772, 12, repeated: true, type: :int32
  field :field16773, 13, optional: true, type: :bool
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message17728 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message24356 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24559: String.t(),
          field24560: String.t(),
          field24561: integer,
          field24562: String.t(),
          field24563: String.t(),
          field24564: String.t(),
          field24565: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24566: String.t(),
          field24567: Benchmarks.GoogleMessage3.Enum24361.t(),
          field24568: String.t(),
          field24569: String.t(),
          field24570: String.t(),
          field24571: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24572: [String.t()],
          field24573: [String.t()]
        }

  defstruct [
    :field24559,
    :field24560,
    :field24561,
    :field24562,
    :field24563,
    :field24564,
    :field24565,
    :field24566,
    :field24567,
    :field24568,
    :field24569,
    :field24570,
    :field24571,
    :field24572,
    :field24573
  ]

  field :field24559, 1, optional: true, type: :string
  field :field24560, 2, optional: true, type: :string
  field :field24561, 14, optional: true, type: :int32
  field :field24562, 3, optional: true, type: :string
  field :field24563, 4, optional: true, type: :string
  field :field24564, 5, optional: true, type: :string
  field :field24565, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field24566, 6, optional: true, type: :string
  field :field24567, 12, optional: true, type: Benchmarks.GoogleMessage3.Enum24361, enum: true
  field :field24568, 7, optional: true, type: :string
  field :field24569, 8, optional: true, type: :string
  field :field24570, 9, optional: true, type: :string
  field :field24571, 10, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24572, 11, repeated: true, type: :string
  field :field24573, 15, repeated: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message24376 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24589: String.t(),
          field24590: String.t(),
          field24591: String.t(),
          field24592: Benchmarks.GoogleMessage3.Message24377.t() | nil,
          field24593: Benchmarks.GoogleMessage3.Message24317.t() | nil,
          field24594: String.t(),
          field24595: Benchmarks.GoogleMessage3.Message24378.t() | nil,
          field24596: [String.t()],
          field24597: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24598: [String.t()],
          field24599: [String.t()],
          field24600: [String.t()],
          field24601: String.t(),
          field24602: [String.t()]
        }

  defstruct [
    :field24589,
    :field24590,
    :field24591,
    :field24592,
    :field24593,
    :field24594,
    :field24595,
    :field24596,
    :field24597,
    :field24598,
    :field24599,
    :field24600,
    :field24601,
    :field24602
  ]

  field :field24589, 1, optional: true, type: :string
  field :field24590, 2, optional: true, type: :string
  field :field24591, 3, optional: true, type: :string
  field :field24592, 4, required: true, type: Benchmarks.GoogleMessage3.Message24377
  field :field24593, 5, optional: true, type: Benchmarks.GoogleMessage3.Message24317
  field :field24594, 6, optional: true, type: :string
  field :field24595, 7, optional: true, type: Benchmarks.GoogleMessage3.Message24378
  field :field24596, 8, repeated: true, type: :string
  field :field24597, 14, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24598, 9, repeated: true, type: :string
  field :field24599, 10, repeated: true, type: :string
  field :field24600, 11, repeated: true, type: :string
  field :field24601, 12, optional: true, type: :string
  field :field24602, 13, repeated: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage3.Message24366 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24574: String.t(),
          field24575: String.t(),
          field24576: String.t(),
          field24577: integer,
          field24578: String.t(),
          field24579: String.t(),
          field24580: String.t(),
          field24581: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24582: String.t(),
          field24583: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24584: String.t(),
          field24585: String.t(),
          field24586: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24587: [String.t()],
          field24588: [String.t()]
        }

  defstruct [
    :field24574,
    :field24575,
    :field24576,
    :field24577,
    :field24578,
    :field24579,
    :field24580,
    :field24581,
    :field24582,
    :field24583,
    :field24584,
    :field24585,
    :field24586,
    :field24587,
    :field24588
  ]

  field :field24574, 1, optional: true, type: :string
  field :field24575, 2, optional: true, type: :string
  field :field24576, 3, optional: true, type: :string
  field :field24577, 10, optional: true, type: :int32
  field :field24578, 13, optional: true, type: :string
  field :field24579, 4, optional: true, type: :string
  field :field24580, 5, optional: true, type: :string
  field :field24581, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field24582, 14, optional: true, type: :string
  field :field24583, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field24584, 6, optional: true, type: :string
  field :field24585, 12, optional: true, type: :string
  field :field24586, 7, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24587, 8, repeated: true, type: :string
  field :field24588, 11, repeated: true, type: :string
  def transform_module(), do: nil
end
