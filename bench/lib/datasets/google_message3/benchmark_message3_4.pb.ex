defmodule Benchmarks.GoogleMessage3.Message24346 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message24401 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24679: Benchmarks.GoogleMessage3.Message24400.t() | nil
        }
  defstruct [:field24679]

  field :field24679, 1, optional: true, type: Benchmarks.GoogleMessage3.Message24400
end

defmodule Benchmarks.GoogleMessage3.Message24402 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24680: Benchmarks.GoogleMessage3.Message24400.t() | nil
        }
  defstruct [:field24680]

  field :field24680, 1, optional: true, type: Benchmarks.GoogleMessage3.Message24400
end

defmodule Benchmarks.GoogleMessage3.Message24379 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24603: String.t(),
          field24604: String.t(),
          field24605: String.t(),
          field24606: Benchmarks.GoogleMessage3.Message24380.t() | nil,
          field24607: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24608: String.t(),
          field24609: Benchmarks.GoogleMessage3.Message24381.t() | nil,
          field24610: [String.t()],
          field24611: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24612: [String.t()],
          field24613: [String.t()],
          field24614: [String.t()],
          field24615: String.t(),
          field24616: String.t(),
          field24617: String.t(),
          field24618: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24619: [String.t()],
          field24620: [String.t()]
        }
  defstruct [
    :field24603,
    :field24604,
    :field24605,
    :field24606,
    :field24607,
    :field24608,
    :field24609,
    :field24610,
    :field24611,
    :field24612,
    :field24613,
    :field24614,
    :field24615,
    :field24616,
    :field24617,
    :field24618,
    :field24619,
    :field24620
  ]

  field :field24603, 1, optional: true, type: :string
  field :field24604, 2, optional: true, type: :string
  field :field24605, 3, optional: true, type: :string
  field :field24606, 4, required: true, type: Benchmarks.GoogleMessage3.Message24380
  field :field24607, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24608, 6, optional: true, type: :string
  field :field24609, 7, optional: true, type: Benchmarks.GoogleMessage3.Message24381
  field :field24610, 8, repeated: true, type: :string
  field :field24611, 17, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24612, 9, repeated: true, type: :string
  field :field24613, 10, repeated: true, type: :string
  field :field24614, 11, repeated: true, type: :string
  field :field24615, 14, optional: true, type: :string
  field :field24616, 12, optional: true, type: :string
  field :field24617, 16, optional: true, type: :string
  field :field24618, 13, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24619, 15, repeated: true, type: :string
  field :field24620, 18, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message27358 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field27415: integer,
          field27416: integer
        }
  defstruct [:field27415, :field27416]

  field :field27415, 1, optional: true, type: :int32
  field :field27416, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message34381 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34398: String.t(),
          field34399: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34400: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34401: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34402: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34403: boolean,
          field34404: boolean,
          field34405: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34406: boolean,
          field34407: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field34398,
    :field34399,
    :field34400,
    :field34401,
    :field34402,
    :field34403,
    :field34404,
    :field34405,
    :field34406,
    :field34407
  ]

  field :field34398, 1, optional: true, type: :string
  field :field34399, 2, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34400, 3, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34401, 4, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34402, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34403, 6, optional: true, type: :bool
  field :field34404, 7, optional: true, type: :bool
  field :field34405, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34406, 9, optional: true, type: :bool
  field :field34407, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message34619 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34641: float | :infinity | :negative_infinity | :nan,
          field34642: float | :infinity | :negative_infinity | :nan,
          field34643: float | :infinity | :negative_infinity | :nan,
          field34644: float | :infinity | :negative_infinity | :nan,
          field34645: float | :infinity | :negative_infinity | :nan,
          field34646: float | :infinity | :negative_infinity | :nan,
          field34647: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field34641,
    :field34642,
    :field34643,
    :field34644,
    :field34645,
    :field34646,
    :field34647
  ]

  field :field34641, 1, optional: true, type: :double
  field :field34642, 2, optional: true, type: :double
  field :field34643, 3, optional: true, type: :double
  field :field34644, 4, optional: true, type: :double
  field :field34645, 11, optional: true, type: :double
  field :field34646, 5, optional: true, type: :double
  field :field34647, 100, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message730 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field897: String.t(),
          field898: [String.t()],
          field899: [String.t()],
          field900: [String.t()],
          field901: String.t(),
          field902: [non_neg_integer],
          field903: [non_neg_integer],
          field904: [String.t()],
          field905: [Benchmarks.GoogleMessage3.Message697.t()],
          field906: [Benchmarks.GoogleMessage3.Message704.t()],
          field907: [String.t()],
          field908: [Benchmarks.GoogleMessage3.Message703.t()],
          field909: [String.t()],
          field910: Benchmarks.GoogleMessage3.Message716.t() | nil,
          field911: Benchmarks.GoogleMessage3.Message718.t() | nil,
          field912: boolean,
          field913: [Benchmarks.GoogleMessage3.Message715.t()],
          field914: [String.t()],
          field915: [String.t()],
          field916: [Benchmarks.GoogleMessage3.Message719.t()],
          field917: [Benchmarks.GoogleMessage3.Message728.t()],
          field918: [Benchmarks.GoogleMessage3.Message702.t()],
          field919: String.t(),
          field920: [String.t()],
          field921: integer,
          field922: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field923: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field924: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field925: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field926: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field927: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field928: [String.t()],
          field929: binary,
          __pb_extensions__: map
        }
  defstruct [
    :field897,
    :field898,
    :field899,
    :field900,
    :field901,
    :field902,
    :field903,
    :field904,
    :field905,
    :field906,
    :field907,
    :field908,
    :field909,
    :field910,
    :field911,
    :field912,
    :field913,
    :field914,
    :field915,
    :field916,
    :field917,
    :field918,
    :field919,
    :field920,
    :field921,
    :field922,
    :field923,
    :field924,
    :field925,
    :field926,
    :field927,
    :field928,
    :field929,
    :__pb_extensions__
  ]

  field :field897, 19, optional: true, type: :string
  field :field898, 27, repeated: true, type: :string
  field :field899, 28, repeated: true, type: :string
  field :field900, 21, repeated: true, type: :string
  field :field901, 30, optional: true, type: :string
  field :field902, 20, repeated: true, type: :uint32
  field :field903, 32, repeated: true, type: :uint32
  field :field904, 16, repeated: true, type: :string
  field :field905, 6, repeated: true, type: Benchmarks.GoogleMessage3.Message697
  field :field906, 7, repeated: true, type: Benchmarks.GoogleMessage3.Message704
  field :field907, 18, repeated: true, type: :string
  field :field908, 8, repeated: true, type: Benchmarks.GoogleMessage3.Message703
  field :field909, 9, repeated: true, type: :string
  field :field910, 10, optional: true, type: Benchmarks.GoogleMessage3.Message716
  field :field911, 11, optional: true, type: Benchmarks.GoogleMessage3.Message718
  field :field912, 14, optional: true, type: :bool
  field :field913, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message715
  field :field914, 17, repeated: true, type: :string
  field :field915, 23, repeated: true, type: :string
  field :field916, 24, repeated: true, type: Benchmarks.GoogleMessage3.Message719
  field :field917, 26, repeated: true, type: Benchmarks.GoogleMessage3.Message728
  field :field918, 35, repeated: true, type: Benchmarks.GoogleMessage3.Message702
  field :field919, 36, optional: true, type: :string
  field :field920, 37, repeated: true, type: :string
  field :field921, 38, optional: true, type: :int64
  field :field922, 39, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field923, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field924, 2, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field925, 3, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field926, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field927, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field928, 22, repeated: true, type: :string
  field :field929, 31, optional: true, type: :bytes

  extensions [{25, 26}, {29, 30}, {34, 35}, {15, 16}]
end

defmodule Benchmarks.GoogleMessage3.Message33958.Message33959 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field33982: String.t(),
          field33983: String.t(),
          field33984: String.t(),
          field33985: non_neg_integer,
          field33986: boolean,
          field33987: Benchmarks.GoogleMessage3.Message0.t() | nil
        }
  defstruct [:field33982, :field33983, :field33984, :field33985, :field33986, :field33987]

  field :field33982, 3, required: true, type: :string
  field :field33983, 4, optional: true, type: :string
  field :field33984, 5, optional: true, type: :string
  field :field33985, 8, optional: true, type: :fixed64
  field :field33986, 10, optional: true, type: :bool
  field :field33987, 6, optional: true, type: Benchmarks.GoogleMessage3.Message0
end

defmodule Benchmarks.GoogleMessage3.Message33958 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field33977: String.t(),
          field33978: String.t(),
          message33959: [any],
          field33980: Benchmarks.GoogleMessage3.Enum33960.t()
        }
  defstruct [:field33977, :field33978, :message33959, :field33980]

  field :field33977, 1, optional: true, type: :string
  field :field33978, 9, optional: true, type: :string
  field :message33959, 2, repeated: true, type: :group
  field :field33980, 7, optional: true, type: Benchmarks.GoogleMessage3.Enum33960, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message6637 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6670: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6671: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field6672: integer,
          field6673: [String.t()],
          field6674: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }
  defstruct [:field6670, :field6671, :field6672, :field6673, :field6674]

  field :field6670, 2, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6671, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6672, 3, optional: true, type: :int32
  field :field6673, 4, repeated: true, type: :string
  field :field6674, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message6643 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6683: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6684: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6685: float | :infinity | :negative_infinity | :nan,
          field6686: float | :infinity | :negative_infinity | :nan,
          field6687: integer,
          field6688: integer,
          field6689: float | :infinity | :negative_infinity | :nan,
          field6690: binary,
          field6691: integer,
          field6692: boolean,
          field6693: boolean,
          field6694: Benchmarks.GoogleMessage3.Message6578.t() | nil,
          field6695: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field6696: integer,
          field6697: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field6698: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6699: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6700: integer
        }
  defstruct [
    :field6683,
    :field6684,
    :field6685,
    :field6686,
    :field6687,
    :field6688,
    :field6689,
    :field6690,
    :field6691,
    :field6692,
    :field6693,
    :field6694,
    :field6695,
    :field6696,
    :field6697,
    :field6698,
    :field6699,
    :field6700
  ]

  field :field6683, 3, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6684, 4, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6685, 5, optional: true, type: :double
  field :field6686, 6, optional: true, type: :double
  field :field6687, 1, optional: true, type: :int32
  field :field6688, 2, optional: true, type: :int32
  field :field6689, 9, optional: true, type: :double
  field :field6690, 10, optional: true, type: :bytes
  field :field6691, 11, optional: true, type: :int32
  field :field6692, 12, optional: true, type: :bool
  field :field6693, 13, optional: true, type: :bool
  field :field6694, 15, optional: true, type: Benchmarks.GoogleMessage3.Message6578
  field :field6695, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field6696, 17, optional: true, type: :int64
  field :field6697, 22, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6698, 19, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6699, 20, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6700, 21, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message6126 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6152: String.t(),
          field6153: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field6154: integer,
          field6155: binary,
          field6156: Benchmarks.GoogleMessage3.Message6024.t() | nil,
          field6157: integer,
          field6158: String.t(),
          field6159: integer,
          field6160: [integer],
          field6161: [integer],
          field6162: [Benchmarks.GoogleMessage3.Message6052.t()],
          field6163: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field6164: Benchmarks.GoogleMessage3.Enum6065.t(),
          field6165: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field6166: boolean,
          field6167: boolean,
          field6168: boolean,
          field6169: [Benchmarks.GoogleMessage3.Message6054.t()],
          field6170: integer
        }
  defstruct [
    :field6152,
    :field6153,
    :field6154,
    :field6155,
    :field6156,
    :field6157,
    :field6158,
    :field6159,
    :field6160,
    :field6161,
    :field6162,
    :field6163,
    :field6164,
    :field6165,
    :field6166,
    :field6167,
    :field6168,
    :field6169,
    :field6170
  ]

  field :field6152, 1, required: true, type: :string
  field :field6153, 9, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6154, 14, optional: true, type: :int32
  field :field6155, 10, optional: true, type: :bytes
  field :field6156, 12, optional: true, type: Benchmarks.GoogleMessage3.Message6024
  field :field6157, 4, optional: true, type: :int32
  field :field6158, 5, optional: true, type: :string
  field :field6159, 6, optional: true, type: :int32
  field :field6160, 2, repeated: true, type: :int32
  field :field6161, 3, repeated: true, type: :int32
  field :field6162, 7, repeated: true, type: Benchmarks.GoogleMessage3.Message6052
  field :field6163, 11, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6164, 15, optional: true, type: Benchmarks.GoogleMessage3.Enum6065, enum: true
  field :field6165, 8, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6166, 13, optional: true, type: :bool
  field :field6167, 16, optional: true, type: :bool
  field :field6168, 18, optional: true, type: :bool
  field :field6169, 17, repeated: true, type: Benchmarks.GoogleMessage3.Message6054
  field :field6170, 19, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message13083.Message13084 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13107: float | :infinity | :negative_infinity | :nan,
          field13108: integer,
          field13109: float | :infinity | :negative_infinity | :nan,
          field13110: [[Benchmarks.GoogleMessage3.Enum13092.t()]]
        }
  defstruct [:field13107, :field13108, :field13109, :field13110]

  field :field13107, 3, required: true, type: :float
  field :field13108, 4, required: true, type: :int32
  field :field13109, 5, optional: true, type: :float
  field :field13110, 6, repeated: true, type: Benchmarks.GoogleMessage3.Enum13092, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message13083.Message13085 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message13083.Message13086 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message13083.Message13087 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message13083 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13096: float | :infinity | :negative_infinity | :nan,
          message13084: [any],
          field13098: float | :infinity | :negative_infinity | :nan,
          field13099: float | :infinity | :negative_infinity | :nan,
          field13100: non_neg_integer,
          field13101: float | :infinity | :negative_infinity | :nan,
          message13085: any,
          message13086: [any],
          message13087: [any],
          field13105: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field13096,
    :message13084,
    :field13098,
    :field13099,
    :field13100,
    :field13101,
    :message13085,
    :message13086,
    :message13087,
    :field13105
  ]

  field :field13096, 1, optional: true, type: :float
  field :message13084, 2, repeated: true, type: :group
  field :field13098, 44, optional: true, type: :float
  field :field13099, 45, optional: true, type: :float
  field :field13100, 46, optional: true, type: :uint64
  field :field13101, 47, optional: true, type: :float
  field :message13085, 16, optional: true, type: :group
  field :message13086, 23, repeated: true, type: :group
  field :message13087, 29, repeated: true, type: :group
  field :field13105, 43, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message13088.Message13089 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13139: String.t(),
          field13140: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field13139, :field13140]

  field :field13139, 2, required: true, type: :string
  field :field13140, 3, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message13088 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message13089: [any],
          field13136: integer,
          field13137: boolean
        }
  defstruct [:message13089, :field13136, :field13137]

  field :message13089, 1, repeated: true, type: :group
  field :field13136, 4, optional: true, type: :int64
  field :field13137, 5, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message10391 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10411: Benchmarks.GoogleMessage3.Enum10392.t(),
          field10412: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field10413: integer,
          field10414: String.t(),
          field10415: String.t(),
          field10416: binary,
          field10417: boolean,
          field10418: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field10419: boolean
        }
  defstruct [
    :field10411,
    :field10412,
    :field10413,
    :field10414,
    :field10415,
    :field10416,
    :field10417,
    :field10418,
    :field10419
  ]

  field :field10411, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum10392, enum: true
  field :field10412, 2, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field10413, 3, optional: true, type: :int64
  field :field10414, 4, optional: true, type: :string
  field :field10415, 5, optional: true, type: :string
  field :field10416, 6, optional: true, type: :bytes
  field :field10417, 8, optional: true, type: :bool
  field :field10418, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field10419, 10, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message11873 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11876: String.t(),
          field11877: String.t(),
          field11878: Benchmarks.GoogleMessage3.Message10573.t() | nil,
          field11879: Benchmarks.GoogleMessage3.Message10582.t() | nil,
          field11880: Benchmarks.GoogleMessage3.Message10824.t() | nil,
          field11881: Benchmarks.GoogleMessage3.Message10773.t() | nil,
          field11882: Benchmarks.GoogleMessage3.Message11866.t() | nil,
          field11883: Benchmarks.GoogleMessage3.Message10818.t() | nil,
          field11884: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field11885: Benchmarks.GoogleMessage3.Message10155.t() | nil,
          field11886: Benchmarks.GoogleMessage3.Message10469.t() | nil,
          field11887: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          __pb_extensions__: map
        }
  defstruct [
    :field11876,
    :field11877,
    :field11878,
    :field11879,
    :field11880,
    :field11881,
    :field11882,
    :field11883,
    :field11884,
    :field11885,
    :field11886,
    :field11887,
    :__pb_extensions__
  ]

  field :field11876, 1, optional: true, type: :string
  field :field11877, 4, optional: true, type: :string
  field :field11878, 5, optional: true, type: Benchmarks.GoogleMessage3.Message10573
  field :field11879, 6, optional: true, type: Benchmarks.GoogleMessage3.Message10582
  field :field11880, 7, optional: true, type: Benchmarks.GoogleMessage3.Message10824
  field :field11881, 12, optional: true, type: Benchmarks.GoogleMessage3.Message10773
  field :field11882, 8, optional: true, type: Benchmarks.GoogleMessage3.Message11866
  field :field11883, 13, optional: true, type: Benchmarks.GoogleMessage3.Message10818
  field :field11884, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field11885, 11, optional: true, type: Benchmarks.GoogleMessage3.Message10155
  field :field11886, 14, optional: true, type: Benchmarks.GoogleMessage3.Message10469
  field :field11887, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  extensions [{9, 10}, {10, 11}]
end

defmodule Benchmarks.GoogleMessage3.Message35506 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35524: integer,
          field35525: String.t(),
          field35526: Benchmarks.GoogleMessage3.Enum35507.t(),
          field35527: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }
  defstruct [:field35524, :field35525, :field35526, :field35527]

  field :field35524, 1, optional: true, type: :int32
  field :field35525, 2, optional: true, type: :string
  field :field35526, 3, optional: true, type: Benchmarks.GoogleMessage3.Enum35507, enum: true
  field :field35527, 4, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message13151 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13158: [Benchmarks.GoogleMessage3.Message13145.t()]
        }
  defstruct [:field13158]

  field :field13158, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message13145
end

defmodule Benchmarks.GoogleMessage3.Message18253.Message18254 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18362: non_neg_integer,
          field18363: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field18362, :field18363]

  field :field18362, 2, required: true, type: :fixed64
  field :field18363, 3, required: true, type: :double
end

defmodule Benchmarks.GoogleMessage3.Message18253 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message18254: [any]
        }
  defstruct [:message18254]

  field :message18254, 1, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message16685 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16694: [Benchmarks.GoogleMessage3.Message16686.t()]
        }
  defstruct [:field16694]

  field :field16694, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message16686
end

defmodule Benchmarks.GoogleMessage3.Message16816.Message16817 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message16816.Message16818 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message16816 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16826: float | :infinity | :negative_infinity | :nan,
          field16827: Benchmarks.GoogleMessage3.Enum16819.t(),
          field16828: float | :infinity | :negative_infinity | :nan,
          message16817: [any],
          field16830: boolean,
          field16831: boolean,
          message16818: [any],
          field16833: String.t(),
          field16834: boolean,
          field16835: boolean
        }
  defstruct [
    :field16826,
    :field16827,
    :field16828,
    :message16817,
    :field16830,
    :field16831,
    :message16818,
    :field16833,
    :field16834,
    :field16835
  ]

  field :field16826, 1, optional: true, type: :float
  field :field16827, 2, optional: true, type: Benchmarks.GoogleMessage3.Enum16819, enum: true
  field :field16828, 3, optional: true, type: :float
  field :message16817, 4, repeated: true, type: :group
  field :field16830, 7, optional: true, type: :bool
  field :field16831, 8, optional: true, type: :bool
  field :message16818, 12, repeated: true, type: :group
  field :field16833, 10, optional: true, type: :string
  field :field16834, 13, optional: true, type: :bool
  field :field16835, 14, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message13168 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13212: integer,
          field13213: non_neg_integer,
          field13214: boolean,
          field13215: non_neg_integer,
          field13216: boolean,
          field13217: Benchmarks.GoogleMessage3.Message12796.t() | nil,
          field13218: float | :infinity | :negative_infinity | :nan,
          field13219: boolean,
          field13220: integer,
          field13221: boolean,
          field13222: integer
        }
  defstruct [
    :field13212,
    :field13213,
    :field13214,
    :field13215,
    :field13216,
    :field13217,
    :field13218,
    :field13219,
    :field13220,
    :field13221,
    :field13222
  ]

  field :field13212, 1, required: true, type: :int32
  field :field13213, 7, optional: true, type: :fixed64
  field :field13214, 8, optional: true, type: :bool
  field :field13215, 10, optional: true, type: :fixed64
  field :field13216, 11, optional: true, type: :bool
  field :field13217, 9, optional: true, type: Benchmarks.GoogleMessage3.Message12796
  field :field13218, 2, required: true, type: :double
  field :field13219, 3, required: true, type: :bool
  field :field13220, 4, optional: true, type: :int32
  field :field13221, 5, required: true, type: :bool
  field :field13222, 6, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message13167 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13199: integer,
          field13200: integer,
          field13201: integer,
          field13202: boolean,
          field13203: non_neg_integer,
          field13204: boolean,
          field13205: Benchmarks.GoogleMessage3.Message12796.t() | nil,
          field13206: non_neg_integer,
          field13207: boolean,
          field13208: [integer],
          field13209: integer,
          field13210: integer,
          field13211: integer
        }
  defstruct [
    :field13199,
    :field13200,
    :field13201,
    :field13202,
    :field13203,
    :field13204,
    :field13205,
    :field13206,
    :field13207,
    :field13208,
    :field13209,
    :field13210,
    :field13211
  ]

  field :field13199, 1, required: true, type: :int32
  field :field13200, 2, optional: true, type: :int32
  field :field13201, 3, optional: true, type: :int32
  field :field13202, 8, optional: true, type: :bool
  field :field13203, 12, optional: true, type: :fixed64
  field :field13204, 13, optional: true, type: :bool
  field :field13205, 11, optional: true, type: Benchmarks.GoogleMessage3.Message12796
  field :field13206, 9, optional: true, type: :fixed64
  field :field13207, 10, optional: true, type: :bool
  field :field13208, 4, repeated: true, type: :int32
  field :field13209, 5, optional: true, type: :int32
  field :field13210, 6, optional: true, type: :int32
  field :field13211, 7, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message1374 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field1375: String.t(),
          field1376: String.t()
        }
  defstruct [:field1375, :field1376]

  field :field1375, 1, required: true, type: :string
  field :field1376, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message18943 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message18944 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message18856 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18857: String.t(),
          field18858: String.t(),
          field18859: boolean,
          field18860: String.t(),
          field18861: String.t(),
          field18862: String.t(),
          field18863: String.t(),
          field18864: String.t(),
          field18865: String.t(),
          field18866: String.t(),
          field18867: String.t(),
          field18868: String.t(),
          field18869: String.t(),
          field18870: String.t(),
          field18871: String.t(),
          field18872: String.t(),
          field18873: String.t(),
          field18874: String.t(),
          field18875: String.t(),
          field18876: String.t(),
          field18877: String.t(),
          field18878: String.t(),
          field18879: String.t(),
          field18880: String.t(),
          field18881: String.t(),
          field18882: String.t(),
          field18883: String.t(),
          field18884: String.t(),
          field18885: [String.t()],
          field18886: String.t(),
          field18887: String.t()
        }
  defstruct [
    :field18857,
    :field18858,
    :field18859,
    :field18860,
    :field18861,
    :field18862,
    :field18863,
    :field18864,
    :field18865,
    :field18866,
    :field18867,
    :field18868,
    :field18869,
    :field18870,
    :field18871,
    :field18872,
    :field18873,
    :field18874,
    :field18875,
    :field18876,
    :field18877,
    :field18878,
    :field18879,
    :field18880,
    :field18881,
    :field18882,
    :field18883,
    :field18884,
    :field18885,
    :field18886,
    :field18887
  ]

  field :field18857, 1, optional: true, type: :string
  field :field18858, 2, optional: true, type: :string
  field :field18859, 31, optional: true, type: :bool
  field :field18860, 26, optional: true, type: :string
  field :field18861, 3, optional: true, type: :string
  field :field18862, 4, optional: true, type: :string
  field :field18863, 5, optional: true, type: :string
  field :field18864, 17, optional: true, type: :string
  field :field18865, 6, optional: true, type: :string
  field :field18866, 7, optional: true, type: :string
  field :field18867, 8, optional: true, type: :string
  field :field18868, 9, optional: true, type: :string
  field :field18869, 10, optional: true, type: :string
  field :field18870, 11, optional: true, type: :string
  field :field18871, 21, optional: true, type: :string
  field :field18872, 18, optional: true, type: :string
  field :field18873, 19, optional: true, type: :string
  field :field18874, 20, optional: true, type: :string
  field :field18875, 22, optional: true, type: :string
  field :field18876, 23, optional: true, type: :string
  field :field18877, 24, optional: true, type: :string
  field :field18878, 25, optional: true, type: :string
  field :field18879, 12, optional: true, type: :string
  field :field18880, 13, optional: true, type: :string
  field :field18881, 29, optional: true, type: :string
  field :field18882, 30, optional: true, type: :string
  field :field18883, 15, optional: true, type: :string
  field :field18884, 16, optional: true, type: :string
  field :field18885, 14, repeated: true, type: :string
  field :field18886, 27, optional: true, type: :string
  field :field18887, 28, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message3850 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3924: Benchmarks.GoogleMessage3.Enum3851.t(),
          field3925: boolean,
          field3926: integer,
          field3927: boolean,
          field3928: boolean,
          field3929: boolean
        }
  defstruct [:field3924, :field3925, :field3926, :field3927, :field3928, :field3929]

  field :field3924, 2, optional: true, type: Benchmarks.GoogleMessage3.Enum3851, enum: true
  field :field3925, 12, optional: true, type: :bool
  field :field3926, 4, optional: true, type: :int32
  field :field3927, 10, optional: true, type: :bool
  field :field3928, 13, optional: true, type: :bool
  field :field3929, 14, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message6721 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6744: Benchmarks.GoogleMessage3.Message6722.t() | nil,
          field6745: boolean,
          field6746: boolean,
          field6747: boolean
        }
  defstruct [:field6744, :field6745, :field6746, :field6747]

  field :field6744, 1, optional: true, type: Benchmarks.GoogleMessage3.Message6722
  field :field6745, 2, optional: true, type: :bool
  field :field6746, 3, optional: true, type: :bool
  field :field6747, 4, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message6742 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6758: boolean
        }
  defstruct [:field6758]

  field :field6758, 1, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message6726 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6752: integer,
          field6753: [Benchmarks.GoogleMessage3.Message6727.t()]
        }
  defstruct [:field6752, :field6753]

  field :field6752, 1, optional: true, type: :int64
  field :field6753, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message6727
end

defmodule Benchmarks.GoogleMessage3.Message6733 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6754: integer,
          field6755: integer,
          field6756: boolean
        }
  defstruct [:field6754, :field6755, :field6756]

  field :field6754, 1, optional: true, type: :int64
  field :field6755, 2, optional: true, type: :int64
  field :field6756, 3, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message6723 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6748: integer,
          field6749: [Benchmarks.GoogleMessage3.Message6724.t()]
        }
  defstruct [:field6748, :field6749]

  field :field6748, 1, optional: true, type: :int64
  field :field6749, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message6724
end

defmodule Benchmarks.GoogleMessage3.Message6725 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6750: integer,
          field6751: integer
        }
  defstruct [:field6750, :field6751]

  field :field6750, 1, optional: true, type: :int32
  field :field6751, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message6734 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6757: [Benchmarks.GoogleMessage3.Message6735.t()]
        }
  defstruct [:field6757]

  field :field6757, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6735
end

defmodule Benchmarks.GoogleMessage3.Message8184 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8228: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8229: boolean,
          field8230: [Benchmarks.GoogleMessage3.Message8183.t()]
        }
  defstruct [:field8228, :field8229, :field8230]

  field :field8228, 1, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8229, 2, optional: true, type: :bool
  field :field8230, 3, repeated: true, type: Benchmarks.GoogleMessage3.Message8183
end

defmodule Benchmarks.GoogleMessage3.Message8477 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8486: Benchmarks.GoogleMessage3.Message7966.t() | nil,
          field8487: integer,
          field8488: String.t()
        }
  defstruct [:field8486, :field8487, :field8488]

  field :field8486, 1, optional: true, type: Benchmarks.GoogleMessage3.Message7966
  field :field8487, 2, optional: true, type: :int64
  field :field8488, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8454 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8465: Benchmarks.GoogleMessage3.Message8449.t() | nil,
          field8466: integer,
          field8467: integer,
          field8468: boolean
        }
  defstruct [:field8465, :field8466, :field8467, :field8468]

  field :field8465, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8449
  field :field8466, 3, optional: true, type: :int64
  field :field8467, 4, optional: true, type: :int32
  field :field8468, 5, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message8476 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8483: String.t(),
          field8484: String.t(),
          field8485: String.t()
        }
  defstruct [:field8483, :field8484, :field8485]

  field :field8483, 1, optional: true, type: :string
  field :field8484, 2, optional: true, type: :string
  field :field8485, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message8455 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8470: Benchmarks.GoogleMessage3.Message8449.t() | nil,
          field8471: [Benchmarks.GoogleMessage3.Message8456.t()],
          field8472: Benchmarks.GoogleMessage3.Message8457.t() | nil,
          field8473: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }
  defstruct [:field8470, :field8471, :field8472, :field8473]

  field :field8470, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8449
  field :field8471, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message8456
  field :field8472, 5, optional: true, type: Benchmarks.GoogleMessage3.Message8457
  field :field8473, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message8475 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8481: String.t(),
          field8482: integer
        }
  defstruct [:field8481, :field8482]

  field :field8481, 1, optional: true, type: :string
  field :field8482, 2, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage3.Message12559 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message12817 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12826: integer,
          field12827: integer,
          field12828: integer
        }
  defstruct [:field12826, :field12827, :field12828]

  field :field12826, 1, optional: true, type: :int32
  field :field12827, 2, optional: true, type: :int32
  field :field12828, 3, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message16480 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16490: Benchmarks.GoogleMessage3.Message13358.t() | nil,
          field16491: Benchmarks.GoogleMessage3.Enum16042.t(),
          field16492: Benchmarks.GoogleMessage3.Message13912.t() | nil,
          field16493: String.t(),
          field16494: String.t(),
          field16495: String.t(),
          field16496: String.t(),
          field16497: Benchmarks.GoogleMessage3.Message13358.t() | nil,
          field16498: non_neg_integer
        }
  defstruct [
    :field16490,
    :field16491,
    :field16492,
    :field16493,
    :field16494,
    :field16495,
    :field16496,
    :field16497,
    :field16498
  ]

  field :field16490, 1, optional: true, type: Benchmarks.GoogleMessage3.Message13358
  field :field16491, 2, optional: true, type: Benchmarks.GoogleMessage3.Enum16042, enum: true
  field :field16492, 3, optional: true, type: Benchmarks.GoogleMessage3.Message13912
  field :field16493, 4, optional: true, type: :string
  field :field16494, 5, optional: true, type: :string
  field :field16495, 6, optional: true, type: :string
  field :field16496, 7, optional: true, type: :string
  field :field16497, 8, optional: true, type: Benchmarks.GoogleMessage3.Message13358
  field :field16498, 9, optional: true, type: :fixed32
end

defmodule Benchmarks.GoogleMessage3.Message24317 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24446: String.t(),
          field24447: Benchmarks.GoogleMessage3.Message24312.t() | nil,
          field24448: [Benchmarks.GoogleMessage3.Message24315.t()],
          field24449: [Benchmarks.GoogleMessage3.Message24313.t()],
          field24450: [Benchmarks.GoogleMessage3.Message24316.t()],
          field24451: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24452: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24453: [String.t()],
          field24454: [String.t()],
          field24455: [String.t()],
          field24456: [String.t()],
          field24457: String.t(),
          field24458: String.t(),
          field24459: String.t(),
          field24460: String.t(),
          field24461: [String.t()],
          field24462: String.t(),
          field24463: [String.t()],
          field24464: [String.t()],
          field24465: [String.t()],
          field24466: [String.t()],
          field24467: [String.t()],
          field24468: [String.t()],
          field24469: [String.t()],
          field24470: [String.t()],
          field24471: String.t(),
          field24472: String.t(),
          field24473: [String.t()],
          field24474: boolean
        }
  defstruct [
    :field24446,
    :field24447,
    :field24448,
    :field24449,
    :field24450,
    :field24451,
    :field24452,
    :field24453,
    :field24454,
    :field24455,
    :field24456,
    :field24457,
    :field24458,
    :field24459,
    :field24460,
    :field24461,
    :field24462,
    :field24463,
    :field24464,
    :field24465,
    :field24466,
    :field24467,
    :field24468,
    :field24469,
    :field24470,
    :field24471,
    :field24472,
    :field24473,
    :field24474
  ]

  field :field24446, 1, optional: true, type: :string
  field :field24447, 2, optional: true, type: Benchmarks.GoogleMessage3.Message24312
  field :field24448, 3, repeated: true, type: Benchmarks.GoogleMessage3.Message24315
  field :field24449, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message24313
  field :field24450, 5, repeated: true, type: Benchmarks.GoogleMessage3.Message24316
  field :field24451, 6, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24452, 7, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24453, 8, repeated: true, type: :string
  field :field24454, 9, repeated: true, type: :string
  field :field24455, 10, repeated: true, type: :string
  field :field24456, 28, repeated: true, type: :string
  field :field24457, 11, optional: true, type: :string
  field :field24458, 12, optional: true, type: :string
  field :field24459, 13, optional: true, type: :string
  field :field24460, 14, optional: true, type: :string
  field :field24461, 15, repeated: true, type: :string
  field :field24462, 16, optional: true, type: :string
  field :field24463, 17, repeated: true, type: :string
  field :field24464, 18, repeated: true, type: :string
  field :field24465, 19, repeated: true, type: :string
  field :field24466, 20, repeated: true, type: :string
  field :field24467, 21, repeated: true, type: :string
  field :field24468, 22, repeated: true, type: :string
  field :field24469, 23, repeated: true, type: :string
  field :field24470, 24, repeated: true, type: :string
  field :field24471, 25, optional: true, type: :string
  field :field24472, 26, optional: true, type: :string
  field :field24473, 27, repeated: true, type: :string
  field :field24474, 40, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Benchmarks.GoogleMessage3.Message0, :"Message33958.field33981", 10_747_482,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message33958

  extend Benchmarks.GoogleMessage3.Message8301, :"Message8454.field8469", 66,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message8454

  extend Benchmarks.GoogleMessage3.Message8302, :"Message8455.field8474", 66,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message8455
end
