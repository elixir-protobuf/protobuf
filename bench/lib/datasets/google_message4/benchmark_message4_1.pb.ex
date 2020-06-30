defmodule Benchmarks.GoogleMessage4.Message2463 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2498: [Benchmarks.GoogleMessage4.Message2462.t()]
        }
  defstruct [:field2498]

  field :field2498, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message2462
end

defmodule Benchmarks.GoogleMessage4.Message12686 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12699: String.t(),
          field12700: Benchmarks.GoogleMessage4.Message12685.t() | nil
        }
  defstruct [:field12699, :field12700]

  field :field12699, 1, optional: true, type: :string
  field :field12700, 2, optional: true, type: Benchmarks.GoogleMessage4.Message12685
end

defmodule Benchmarks.GoogleMessage4.Message11949 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message11975 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11992: String.t(),
          field11993: integer,
          field11994: [Benchmarks.GoogleMessage4.Message10320.t()],
          field11995: Benchmarks.GoogleMessage4.Message11947.t() | nil,
          field11996: Benchmarks.GoogleMessage4.Message11920.t() | nil,
          field11997: boolean,
          field11998: [String.t()],
          field11999: float | :infinity | :negative_infinity | :nan,
          field12000: [[Benchmarks.GoogleMessage4.UnusedEnum.t()]],
          field12001: integer
        }
  defstruct [
    :field11992,
    :field11993,
    :field11994,
    :field11995,
    :field11996,
    :field11997,
    :field11998,
    :field11999,
    :field12000,
    :field12001
  ]

  field :field11992, 1, optional: true, type: :string
  field :field11993, 2, optional: true, type: :int32
  field :field11994, 3, repeated: true, type: Benchmarks.GoogleMessage4.Message10320
  field :field11995, 4, optional: true, type: Benchmarks.GoogleMessage4.Message11947
  field :field11996, 5, optional: true, type: Benchmarks.GoogleMessage4.Message11920
  field :field11997, 6, optional: true, type: :bool
  field :field11998, 7, repeated: true, type: :string
  field :field11999, 8, optional: true, type: :float
  field :field12000, 9, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field12001, 11, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message7287 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7311: Benchmarks.GoogleMessage4.Message6133.t() | nil,
          field7312: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7313: String.t(),
          field7314: Benchmarks.GoogleMessage4.Message6643.t() | nil,
          field7315: Benchmarks.GoogleMessage4.Enum7288.t(),
          field7316: binary,
          field7317: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7318: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field7311,
    :field7312,
    :field7313,
    :field7314,
    :field7315,
    :field7316,
    :field7317,
    :field7318
  ]

  field :field7311, 1, optional: true, type: Benchmarks.GoogleMessage4.Message6133
  field :field7312, 8, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7313, 3, optional: true, type: :string
  field :field7314, 4, optional: true, type: Benchmarks.GoogleMessage4.Message6643
  field :field7315, 5, optional: true, type: Benchmarks.GoogleMessage4.Enum7288, enum: true
  field :field7316, 6, optional: true, type: :bytes
  field :field7317, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7318, 9, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message3061.Message3062 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3335: integer,
          field3336: integer,
          field3337: integer
        }
  defstruct [:field3335, :field3336, :field3337]

  field :field3335, 5, required: true, type: :int32
  field :field3336, 6, optional: true, type: :int32
  field :field3337, 7, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3061.Message3063 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3338: integer,
          field3339: Benchmarks.GoogleMessage4.Enum2851.t(),
          field3340: integer,
          field3341: integer
        }
  defstruct [:field3338, :field3339, :field3340, :field3341]

  field :field3338, 14, required: true, type: :int32
  field :field3339, 18, optional: true, type: Benchmarks.GoogleMessage4.Enum2851, enum: true
  field :field3340, 15, optional: true, type: :int64
  field :field3341, 23, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage4.Message3061.Message3064 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3342: Benchmarks.GoogleMessage4.Enum2602.t(),
          field3343: integer,
          field3344: String.t(),
          field3345: binary,
          field3346: integer,
          field3347: Benchmarks.GoogleMessage4.Message3060.t() | nil,
          field3348: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3349: Benchmarks.GoogleMessage4.Message3050.t() | nil,
          field3350: non_neg_integer,
          field3351: integer,
          field3352: String.t(),
          field3353: String.t(),
          field3354: binary,
          field3355: Benchmarks.GoogleMessage4.Enum2806.t(),
          field3356: integer,
          field3357: integer,
          field3358: binary,
          field3359: integer,
          field3360: Benchmarks.GoogleMessage4.Enum2834.t()
        }
  defstruct [
    :field3342,
    :field3343,
    :field3344,
    :field3345,
    :field3346,
    :field3347,
    :field3348,
    :field3349,
    :field3350,
    :field3351,
    :field3352,
    :field3353,
    :field3354,
    :field3355,
    :field3356,
    :field3357,
    :field3358,
    :field3359,
    :field3360
  ]

  field :field3342, 9, required: true, type: Benchmarks.GoogleMessage4.Enum2602, enum: true
  field :field3343, 92, optional: true, type: :int32
  field :field3344, 10, optional: true, type: :string
  field :field3345, 11, optional: true, type: :bytes
  field :field3346, 12, optional: true, type: :int32
  field :field3347, 98, optional: true, type: Benchmarks.GoogleMessage4.Message3060
  field :field3348, 82, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3349, 80, optional: true, type: Benchmarks.GoogleMessage4.Message3050
  field :field3350, 52, optional: true, type: :fixed64
  field :field3351, 33, optional: true, type: :int32
  field :field3352, 42, optional: true, type: :string
  field :field3353, 69, optional: true, type: :string
  field :field3354, 43, optional: true, type: :bytes
  field :field3355, 73, optional: true, type: Benchmarks.GoogleMessage4.Enum2806, enum: true
  field :field3356, 74, optional: true, type: :int32
  field :field3357, 90, optional: true, type: :int32
  field :field3358, 79, optional: true, type: :bytes
  field :field3359, 19, optional: true, type: :int32
  field :field3360, 95, optional: true, type: Benchmarks.GoogleMessage4.Enum2834, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message3061.Message3065 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message3061.Message3066 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3366: integer,
          field3367: integer,
          field3368: integer,
          field3369: integer,
          field3370: integer,
          field3371: integer,
          field3372: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3373: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field3366,
    :field3367,
    :field3368,
    :field3369,
    :field3370,
    :field3371,
    :field3372,
    :field3373
  ]

  field :field3366, 22, optional: true, type: :int32
  field :field3367, 55, optional: true, type: :int32
  field :field3368, 88, optional: true, type: :int32
  field :field3369, 56, optional: true, type: :int32
  field :field3370, 75, optional: true, type: :int32
  field :field3371, 57, optional: true, type: :int32
  field :field3372, 85, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3373, 96, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message3061 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3286: String.t(),
          field3287: integer,
          field3288: String.t(),
          field3289: Benchmarks.GoogleMessage4.Message3046.t() | nil,
          field3290: Benchmarks.GoogleMessage4.Message3046.t() | nil,
          message3062: any,
          field3292: Benchmarks.GoogleMessage4.Message3060.t() | nil,
          field3293: integer,
          field3294: integer,
          message3063: any,
          field3296: Benchmarks.GoogleMessage4.Enum2834.t(),
          field3297: boolean,
          field3298: boolean,
          field3299: String.t(),
          field3300: String.t(),
          field3301: String.t(),
          field3302: Benchmarks.GoogleMessage4.Message3050.t() | nil,
          field3303: non_neg_integer,
          field3304: non_neg_integer,
          field3305: integer,
          field3306: String.t(),
          field3307: binary,
          field3308: String.t(),
          field3309: binary,
          field3310: Benchmarks.GoogleMessage4.Enum2806.t(),
          field3311: integer,
          field3312: binary,
          field3313: integer,
          message3064: [any],
          field3315: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3316: integer,
          message3065: any,
          field3318: Benchmarks.GoogleMessage4.Enum2806.t(),
          field3319: integer,
          field3320: [String.t()],
          field3321: non_neg_integer,
          field3322: binary,
          field3323: non_neg_integer,
          field3324: non_neg_integer,
          field3325: [Benchmarks.GoogleMessage4.Message3040.t()],
          field3326: [Benchmarks.GoogleMessage4.Message3041.t()],
          message3066: any,
          field3328: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3329: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3330: non_neg_integer,
          field3331: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3332: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field3333: integer
        }
  defstruct [
    :field3286,
    :field3287,
    :field3288,
    :field3289,
    :field3290,
    :message3062,
    :field3292,
    :field3293,
    :field3294,
    :message3063,
    :field3296,
    :field3297,
    :field3298,
    :field3299,
    :field3300,
    :field3301,
    :field3302,
    :field3303,
    :field3304,
    :field3305,
    :field3306,
    :field3307,
    :field3308,
    :field3309,
    :field3310,
    :field3311,
    :field3312,
    :field3313,
    :message3064,
    :field3315,
    :field3316,
    :message3065,
    :field3318,
    :field3319,
    :field3320,
    :field3321,
    :field3322,
    :field3323,
    :field3324,
    :field3325,
    :field3326,
    :message3066,
    :field3328,
    :field3329,
    :field3330,
    :field3331,
    :field3332,
    :field3333
  ]

  field :field3286, 2, optional: true, type: :string
  field :field3287, 77, optional: true, type: :int32
  field :field3288, 49, optional: true, type: :string
  field :field3289, 3, required: true, type: Benchmarks.GoogleMessage4.Message3046
  field :field3290, 58, optional: true, type: Benchmarks.GoogleMessage4.Message3046
  field :message3062, 4, optional: true, type: :group
  field :field3292, 104, optional: true, type: Benchmarks.GoogleMessage4.Message3060
  field :field3293, 32, optional: true, type: :int64
  field :field3294, 41, optional: true, type: :int32
  field :message3063, 13, optional: true, type: :group
  field :field3296, 94, optional: true, type: Benchmarks.GoogleMessage4.Enum2834, enum: true
  field :field3297, 25, optional: true, type: :bool
  field :field3298, 50, optional: true, type: :bool
  field :field3299, 89, optional: true, type: :string
  field :field3300, 91, optional: true, type: :string
  field :field3301, 105, optional: true, type: :string
  field :field3302, 53, optional: true, type: Benchmarks.GoogleMessage4.Message3050
  field :field3303, 51, optional: true, type: :fixed64
  field :field3304, 106, optional: true, type: :fixed64
  field :field3305, 60, optional: true, type: :int32
  field :field3306, 44, optional: true, type: :string
  field :field3307, 81, optional: true, type: :bytes
  field :field3308, 70, optional: true, type: :string
  field :field3309, 45, optional: true, type: :bytes
  field :field3310, 71, optional: true, type: Benchmarks.GoogleMessage4.Enum2806, enum: true
  field :field3311, 72, optional: true, type: :int32
  field :field3312, 78, optional: true, type: :bytes
  field :field3313, 20, optional: true, type: :int32
  field :message3064, 8, repeated: true, type: :group
  field :field3315, 39, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3316, 76, optional: true, type: :int32
  field :message3065, 63, optional: true, type: :group
  field :field3318, 54, optional: true, type: Benchmarks.GoogleMessage4.Enum2806, enum: true
  field :field3319, 46, optional: true, type: :int32
  field :field3320, 24, repeated: true, type: :string
  field :field3321, 38, optional: true, type: :fixed32
  field :field3322, 99, optional: true, type: :bytes
  field :field3323, 1, optional: true, type: :fixed64
  field :field3324, 97, optional: true, type: :fixed64
  field :field3325, 16, repeated: true, type: Benchmarks.GoogleMessage4.Message3040
  field :field3326, 61, repeated: true, type: Benchmarks.GoogleMessage4.Message3041
  field :message3066, 21, optional: true, type: :group
  field :field3328, 47, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3329, 48, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3330, 40, optional: true, type: :fixed64
  field :field3331, 86, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3332, 59, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field3333, 17, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message12949 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message8572 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8647: binary,
          field8648: binary,
          field8649: Benchmarks.GoogleMessage4.Message3886.t() | nil,
          field8650: Benchmarks.GoogleMessage4.Message3919.t() | nil,
          field8651: boolean,
          field8652: integer,
          field8653: integer,
          field8654: Benchmarks.GoogleMessage4.Message7905.t() | nil,
          field8655: integer,
          field8656: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8657: boolean,
          field8658: binary,
          field8659: String.t(),
          field8660: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8661: binary,
          field8662: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8663: integer,
          field8664: integer,
          field8665: boolean,
          field8666: Benchmarks.GoogleMessage4.Enum3476.t(),
          field8667: boolean,
          field8668: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8669: binary,
          field8670: integer,
          field8671: Benchmarks.GoogleMessage4.Message3052.t() | nil,
          field8672: binary,
          field8673: binary,
          field8674: integer,
          field8675: binary,
          field8676: binary,
          field8677: String.t(),
          field8678: integer,
          field8679: integer,
          field8680: float | :infinity | :negative_infinity | :nan,
          field8681: float | :infinity | :negative_infinity | :nan,
          field8682: Benchmarks.GoogleMessage4.Message3922.t() | nil,
          field8683: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8684: integer,
          field8685: Benchmarks.GoogleMessage4.Message7929.t() | nil,
          field8686: non_neg_integer,
          field8687: non_neg_integer,
          field8688: Benchmarks.GoogleMessage4.Message7843.t() | nil,
          field8689: Benchmarks.GoogleMessage4.Message7864.t() | nil,
          field8690: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8691: boolean,
          field8692: boolean,
          field8693: String.t(),
          field8694: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8695: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8696: Benchmarks.GoogleMessage4.Message8575.t() | nil
        }
  defstruct [
    :field8647,
    :field8648,
    :field8649,
    :field8650,
    :field8651,
    :field8652,
    :field8653,
    :field8654,
    :field8655,
    :field8656,
    :field8657,
    :field8658,
    :field8659,
    :field8660,
    :field8661,
    :field8662,
    :field8663,
    :field8664,
    :field8665,
    :field8666,
    :field8667,
    :field8668,
    :field8669,
    :field8670,
    :field8671,
    :field8672,
    :field8673,
    :field8674,
    :field8675,
    :field8676,
    :field8677,
    :field8678,
    :field8679,
    :field8680,
    :field8681,
    :field8682,
    :field8683,
    :field8684,
    :field8685,
    :field8686,
    :field8687,
    :field8688,
    :field8689,
    :field8690,
    :field8691,
    :field8692,
    :field8693,
    :field8694,
    :field8695,
    :field8696
  ]

  field :field8647, 1, optional: true, type: :bytes
  field :field8648, 3, optional: true, type: :bytes
  field :field8649, 4, optional: true, type: Benchmarks.GoogleMessage4.Message3886
  field :field8650, 57, optional: true, type: Benchmarks.GoogleMessage4.Message3919
  field :field8651, 5, optional: true, type: :bool
  field :field8652, 6, optional: true, type: :int32
  field :field8653, 49, optional: true, type: :int32
  field :field8654, 7, optional: true, type: Benchmarks.GoogleMessage4.Message7905
  field :field8655, 10, optional: true, type: :int32
  field :field8656, 11, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8657, 35, optional: true, type: :bool
  field :field8658, 12, optional: true, type: :bytes
  field :field8659, 14, optional: true, type: :string
  field :field8660, 13, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8661, 15, optional: true, type: :bytes
  field :field8662, 17, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8663, 18, optional: true, type: :int32
  field :field8664, 19, optional: true, type: :int32
  field :field8665, 20, optional: true, type: :bool
  field :field8666, 31, optional: true, type: Benchmarks.GoogleMessage4.Enum3476, enum: true
  field :field8667, 36, optional: true, type: :bool
  field :field8668, 39, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8669, 22, optional: true, type: :bytes
  field :field8670, 24, optional: true, type: :int32
  field :field8671, 25, optional: true, type: Benchmarks.GoogleMessage4.Message3052
  field :field8672, 26, optional: true, type: :bytes
  field :field8673, 28, optional: true, type: :bytes
  field :field8674, 29, optional: true, type: :int32
  field :field8675, 30, optional: true, type: :bytes
  field :field8676, 32, optional: true, type: :bytes
  field :field8677, 33, optional: true, type: :string
  field :field8678, 34, optional: true, type: :int32
  field :field8679, 37, optional: true, type: :int32
  field :field8680, 38, optional: true, type: :double
  field :field8681, 42, optional: true, type: :double
  field :field8682, 40, optional: true, type: Benchmarks.GoogleMessage4.Message3922
  field :field8683, 43, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8684, 44, optional: true, type: :int64
  field :field8685, 45, optional: true, type: Benchmarks.GoogleMessage4.Message7929
  field :field8686, 46, optional: true, type: :uint64
  field :field8687, 48, optional: true, type: :uint32
  field :field8688, 47, optional: true, type: Benchmarks.GoogleMessage4.Message7843
  field :field8689, 50, optional: true, type: Benchmarks.GoogleMessage4.Message7864
  field :field8690, 52, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8691, 58, optional: true, type: :bool
  field :field8692, 54, optional: true, type: :bool
  field :field8693, 55, optional: true, type: :string
  field :field8694, 41, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8695, 53, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8696, 61, optional: true, type: Benchmarks.GoogleMessage4.Message8575
end

defmodule Benchmarks.GoogleMessage4.Message8774 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8810: String.t(),
          field8811: String.t(),
          field8812: String.t(),
          field8813: String.t(),
          field8814: String.t()
        }
  defstruct [:field8810, :field8811, :field8812, :field8813, :field8814]

  field :field8810, 1, optional: true, type: :string
  field :field8811, 2, optional: true, type: :string
  field :field8812, 3, optional: true, type: :string
  field :field8813, 4, optional: true, type: :string
  field :field8814, 5, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message12776 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12786: String.t(),
          field12787: non_neg_integer,
          field12788: integer,
          field12789: integer,
          field12790: integer,
          field12791: integer,
          field12792: integer,
          field12793: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12794: Benchmarks.GoogleMessage4.Message12774.t() | nil,
          field12795: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          __pb_extensions__: map
        }
  defstruct [
    :field12786,
    :field12787,
    :field12788,
    :field12789,
    :field12790,
    :field12791,
    :field12792,
    :field12793,
    :field12794,
    :field12795,
    :__pb_extensions__
  ]

  field :field12786, 1, optional: true, type: :string
  field :field12787, 11, optional: true, type: :fixed64
  field :field12788, 6, optional: true, type: :int32
  field :field12789, 13, optional: true, type: :int32
  field :field12790, 14, optional: true, type: :int32
  field :field12791, 15, optional: true, type: :int32
  field :field12792, 16, optional: true, type: :int32
  field :field12793, 8, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12794, 10, optional: true, type: Benchmarks.GoogleMessage4.Message12774
  field :field12795, 12, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  extensions [{2, 3}, {3, 4}, {4, 5}, {5, 6}, {7, 8}, {9, 10}]
end

defmodule Benchmarks.GoogleMessage4.Message12798 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12805: integer,
          field12806: integer,
          field12807: Benchmarks.GoogleMessage4.Message12774.t() | nil,
          field12808: boolean
        }
  defstruct [:field12805, :field12806, :field12807, :field12808]

  field :field12805, 1, optional: true, type: :int32
  field :field12806, 2, optional: true, type: :int32
  field :field12807, 6, optional: true, type: Benchmarks.GoogleMessage4.Message12774
  field :field12808, 7, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message12797 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12802: Benchmarks.GoogleMessage4.Message12796.t() | nil,
          field12803: [Benchmarks.GoogleMessage4.Message12796.t()],
          field12804: String.t()
        }
  defstruct [:field12802, :field12803, :field12804]

  field :field12802, 1, optional: true, type: Benchmarks.GoogleMessage4.Message12796
  field :field12803, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message12796
  field :field12804, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message12825 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12862: [Benchmarks.GoogleMessage4.Message12818.t()],
          field12863: integer,
          field12864: Benchmarks.GoogleMessage4.Message12819.t() | nil,
          field12865: Benchmarks.GoogleMessage4.Message12820.t() | nil,
          field12866: integer,
          field12867: [Benchmarks.GoogleMessage4.Message12821.t()],
          field12868: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()]
        }
  defstruct [
    :field12862,
    :field12863,
    :field12864,
    :field12865,
    :field12866,
    :field12867,
    :field12868
  ]

  field :field12862, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message12818
  field :field12863, 2, optional: true, type: :int32
  field :field12864, 3, optional: true, type: Benchmarks.GoogleMessage4.Message12819
  field :field12865, 4, optional: true, type: Benchmarks.GoogleMessage4.Message12820
  field :field12866, 5, optional: true, type: :int32
  field :field12867, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message12821
  field :field12868, 7, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message8590 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message8587 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message1374 do
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

defmodule Benchmarks.GoogleMessage4.Message2462 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2496: binary,
          field2497: float | :infinity | :negative_infinity | :nan
        }
  defstruct [:field2496, :field2497]

  field :field2496, 1, required: true, type: :bytes
  field :field2497, 2, required: true, type: :double
end

defmodule Benchmarks.GoogleMessage4.Message12685 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12692: [String.t()],
          field12693: [String.t()],
          field12694: integer,
          field12695: non_neg_integer,
          field12696: [String.t()],
          field12697: String.t(),
          field12698: String.t()
        }
  defstruct [
    :field12692,
    :field12693,
    :field12694,
    :field12695,
    :field12696,
    :field12697,
    :field12698
  ]

  field :field12692, 1, repeated: true, type: :string
  field :field12693, 2, repeated: true, type: :string
  field :field12694, 3, optional: true, type: :int64
  field :field12695, 4, optional: true, type: :uint32
  field :field12696, 5, repeated: true, type: :string
  field :field12697, 6, optional: true, type: :string
  field :field12698, 7, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message10320 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10347: Benchmarks.GoogleMessage4.Enum10335.t(),
          field10348: [Benchmarks.GoogleMessage4.Message10319.t()],
          field10349: integer,
          field10350: integer,
          field10351: integer,
          field10352: integer,
          field10353: Benchmarks.GoogleMessage4.Enum10337.t()
        }
  defstruct [
    :field10347,
    :field10348,
    :field10349,
    :field10350,
    :field10351,
    :field10352,
    :field10353
  ]

  field :field10347, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum10335, enum: true
  field :field10348, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message10319
  field :field10349, 3, optional: true, type: :int32
  field :field10350, 4, optional: true, type: :int32
  field :field10351, 5, optional: true, type: :int32
  field :field10352, 6, optional: true, type: :int32
  field :field10353, 7, optional: true, type: Benchmarks.GoogleMessage4.Enum10337, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message11947 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11951: non_neg_integer,
          field11952: boolean,
          field11953: integer
        }
  defstruct [:field11951, :field11952, :field11953]

  field :field11951, 1, optional: true, type: :uint32
  field :field11952, 2, optional: true, type: :bool
  field :field11953, 3, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message11920 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11945: Benchmarks.GoogleMessage4.Enum11901.t(),
          field11946: Benchmarks.GoogleMessage4.UnusedEnum.t()
        }
  defstruct [:field11945, :field11946]

  field :field11945, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum11901, enum: true
  field :field11946, 2, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message6643 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6683: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field6684: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field6685: float | :infinity | :negative_infinity | :nan,
          field6686: float | :infinity | :negative_infinity | :nan,
          field6687: integer,
          field6688: integer,
          field6689: float | :infinity | :negative_infinity | :nan,
          field6690: binary,
          field6691: integer,
          field6692: boolean,
          field6693: boolean,
          field6694: Benchmarks.GoogleMessage4.Message6578.t() | nil,
          field6695: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field6696: integer,
          field6697: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()],
          field6698: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field6699: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
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

  field :field6683, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6684, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6685, 5, optional: true, type: :double
  field :field6686, 6, optional: true, type: :double
  field :field6687, 1, optional: true, type: :int32
  field :field6688, 2, optional: true, type: :int32
  field :field6689, 9, optional: true, type: :double
  field :field6690, 10, optional: true, type: :bytes
  field :field6691, 11, optional: true, type: :int32
  field :field6692, 12, optional: true, type: :bool
  field :field6693, 13, optional: true, type: :bool
  field :field6694, 15, optional: true, type: Benchmarks.GoogleMessage4.Message6578
  field :field6695, 16, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field6696, 17, optional: true, type: :int64
  field :field6697, 22, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6698, 19, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6699, 20, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6700, 21, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message6133 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6173: Benchmarks.GoogleMessage4.Message4016.t() | nil,
          field6174: float | :infinity | :negative_infinity | :nan,
          field6175: String.t(),
          field6176: String.t(),
          field6177: String.t(),
          field6178: String.t(),
          field6179: String.t(),
          field6180: [Benchmarks.GoogleMessage4.Message6109.t()],
          field6181: [Benchmarks.GoogleMessage4.Message5908.t()],
          field6182: [Benchmarks.GoogleMessage4.Message6107.t()],
          field6183: [Benchmarks.GoogleMessage4.Message6126.t()],
          field6184: [Benchmarks.GoogleMessage4.Message6129.t()],
          field6185: integer,
          field6186: integer,
          field6187: Benchmarks.GoogleMessage4.Message4016.t() | nil,
          field6188: float | :infinity | :negative_infinity | :nan,
          field6189: float | :infinity | :negative_infinity | :nan,
          field6190: String.t(),
          field6191: String.t(),
          field6192: [Benchmarks.GoogleMessage4.Message5881.t()]
        }
  defstruct [
    :field6173,
    :field6174,
    :field6175,
    :field6176,
    :field6177,
    :field6178,
    :field6179,
    :field6180,
    :field6181,
    :field6182,
    :field6183,
    :field6184,
    :field6185,
    :field6186,
    :field6187,
    :field6188,
    :field6189,
    :field6190,
    :field6191,
    :field6192
  ]

  field :field6173, 12, optional: true, type: Benchmarks.GoogleMessage4.Message4016
  field :field6174, 16, optional: true, type: :double
  field :field6175, 1, required: true, type: :string
  field :field6176, 2, required: true, type: :string
  field :field6177, 3, required: true, type: :string
  field :field6178, 4, optional: true, type: :string
  field :field6179, 8, optional: true, type: :string
  field :field6180, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message6109
  field :field6181, 13, repeated: true, type: Benchmarks.GoogleMessage4.Message5908
  field :field6182, 7, repeated: true, type: Benchmarks.GoogleMessage4.Message6107
  field :field6183, 9, repeated: true, type: Benchmarks.GoogleMessage4.Message6126
  field :field6184, 15, repeated: true, type: Benchmarks.GoogleMessage4.Message6129
  field :field6185, 10, optional: true, type: :int32
  field :field6186, 11, optional: true, type: :int32
  field :field6187, 17, optional: true, type: Benchmarks.GoogleMessage4.Message4016
  field :field6188, 14, optional: true, type: :double
  field :field6189, 18, optional: true, type: :double
  field :field6190, 19, optional: true, type: :string
  field :field6191, 20, optional: true, type: :string
  field :field6192, 21, repeated: true, type: Benchmarks.GoogleMessage4.Message5881
end

defmodule Benchmarks.GoogleMessage4.Message6109 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6140: String.t(),
          field6141: Benchmarks.GoogleMessage4.Enum6111.t(),
          field6142: integer,
          field6143: String.t(),
          field6144: [Benchmarks.GoogleMessage4.Message6110.t()],
          field6145: [integer],
          field6146: [integer],
          field6147: Benchmarks.GoogleMessage4.Message6133.t() | nil,
          field6148: [integer],
          field6149: String.t(),
          field6150: String.t(),
          field6151: boolean,
          __pb_extensions__: map
        }
  defstruct [
    :field6140,
    :field6141,
    :field6142,
    :field6143,
    :field6144,
    :field6145,
    :field6146,
    :field6147,
    :field6148,
    :field6149,
    :field6150,
    :field6151,
    :__pb_extensions__
  ]

  field :field6140, 1, optional: true, type: :string
  field :field6141, 2, required: true, type: Benchmarks.GoogleMessage4.Enum6111, enum: true
  field :field6142, 9, optional: true, type: :int32
  field :field6143, 3, optional: true, type: :string
  field :field6144, 4, repeated: true, type: Benchmarks.GoogleMessage4.Message6110
  field :field6145, 7, repeated: true, type: :int32
  field :field6146, 8, repeated: true, type: :int32
  field :field6147, 10, optional: true, type: Benchmarks.GoogleMessage4.Message6133
  field :field6148, 11, repeated: true, type: :int32
  field :field6149, 12, optional: true, type: :string
  field :field6150, 13, optional: true, type: :string
  field :field6151, 14, optional: true, type: :bool

  extensions [{1000, 536_870_912}]
end

defmodule Benchmarks.GoogleMessage4.Message3046 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3222: Benchmarks.GoogleMessage4.Enum2593.t(),
          field3223: integer
        }
  defstruct [:field3222, :field3223]

  field :field3222, 1, required: true, type: Benchmarks.GoogleMessage4.Enum2593, enum: true
  field :field3223, 4, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3060 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3283: integer,
          field3284: integer,
          field3285: integer
        }
  defstruct [:field3283, :field3284, :field3285]

  field :field3283, 1, optional: true, type: :int64
  field :field3284, 2, optional: true, type: :int64
  field :field3285, 3, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage4.Message3041 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3214: String.t(),
          field3215: integer
        }
  defstruct [:field3214, :field3215]

  field :field3214, 1, optional: true, type: :string
  field :field3215, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3040 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3209: non_neg_integer,
          field3210: [non_neg_integer],
          field3211: integer,
          field3212: non_neg_integer,
          field3213: String.t()
        }
  defstruct [:field3209, :field3210, :field3211, :field3212, :field3213]

  field :field3209, 1, required: true, type: :fixed64
  field :field3210, 4, repeated: true, type: :fixed64
  field :field3211, 5, optional: true, type: :int32
  field :field3212, 2, optional: true, type: :fixed64
  field :field3213, 3, required: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message3050 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3245: binary,
          field3246: integer,
          field3247: binary,
          field3248: integer,
          field3249: non_neg_integer,
          field3250: non_neg_integer
        }
  defstruct [:field3245, :field3246, :field3247, :field3248, :field3249, :field3250]

  field :field3245, 5, optional: true, type: :bytes
  field :field3246, 2, optional: true, type: :int32
  field :field3247, 6, optional: true, type: :bytes
  field :field3248, 4, optional: true, type: :int32
  field :field3249, 1, optional: true, type: :fixed32
  field :field3250, 3, optional: true, type: :fixed32
end

defmodule Benchmarks.GoogleMessage4.Message7905 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7911: integer,
          field7912: boolean,
          field7913: binary,
          field7914: integer,
          field7915: integer,
          field7916: binary,
          field7917: integer
        }
  defstruct [:field7911, :field7912, :field7913, :field7914, :field7915, :field7916, :field7917]

  field :field7911, 1, optional: true, type: :int32
  field :field7912, 2, optional: true, type: :bool
  field :field7913, 3, optional: true, type: :bytes
  field :field7914, 4, optional: true, type: :int32
  field :field7915, 5, optional: true, type: :int32
  field :field7916, 6, optional: true, type: :bytes
  field :field7917, 7, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3886.Message3887 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3932: String.t(),
          field3933: String.t(),
          field3934: Benchmarks.GoogleMessage4.Message3850.t() | nil,
          field3935: binary
        }
  defstruct [:field3932, :field3933, :field3934, :field3935]

  field :field3932, 2, required: true, type: :string
  field :field3933, 9, optional: true, type: :string
  field :field3934, 3, optional: true, type: Benchmarks.GoogleMessage4.Message3850
  field :field3935, 8, optional: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage4.Message3886 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message3887: [any]
        }
  defstruct [:message3887]

  field :message3887, 1, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage4.Message7864 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7866: String.t(),
          field7867: String.t(),
          field7868: [Benchmarks.GoogleMessage4.Message7865.t()],
          field7869: [Benchmarks.GoogleMessage4.Message7865.t()],
          field7870: [Benchmarks.GoogleMessage4.Message7865.t()],
          field7871: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()]
        }
  defstruct [:field7866, :field7867, :field7868, :field7869, :field7870, :field7871]

  field :field7866, 1, optional: true, type: :string
  field :field7867, 2, optional: true, type: :string
  field :field7868, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message7865
  field :field7869, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message7865
  field :field7870, 7, repeated: true, type: Benchmarks.GoogleMessage4.Message7865
  field :field7871, 8, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message3922 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4012: non_neg_integer
        }
  defstruct [:field4012]

  field :field4012, 1, optional: true, type: :uint64
end

defmodule Benchmarks.GoogleMessage4.Message3052 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3254: [String.t()],
          field3255: [String.t()],
          field3256: [binary],
          field3257: [String.t()],
          field3258: boolean,
          field3259: integer,
          field3260: integer,
          field3261: String.t(),
          field3262: String.t()
        }
  defstruct [
    :field3254,
    :field3255,
    :field3256,
    :field3257,
    :field3258,
    :field3259,
    :field3260,
    :field3261,
    :field3262
  ]

  field :field3254, 1, repeated: true, type: :string
  field :field3255, 2, repeated: true, type: :string
  field :field3256, 3, repeated: true, type: :bytes
  field :field3257, 4, repeated: true, type: :string
  field :field3258, 5, optional: true, type: :bool
  field :field3259, 6, optional: true, type: :int32
  field :field3260, 7, optional: true, type: :int32
  field :field3261, 8, optional: true, type: :string
  field :field3262, 9, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message8575 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message7843 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7844: boolean,
          field7845: integer,
          field7846: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7847: [integer],
          field7848: [String.t()],
          field7849: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field7850: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7851: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7852: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7853: Benchmarks.GoogleMessage4.Message7511.t() | nil,
          field7854: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7855: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7856: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7857: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7858: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field7859: integer
        }
  defstruct [
    :field7844,
    :field7845,
    :field7846,
    :field7847,
    :field7848,
    :field7849,
    :field7850,
    :field7851,
    :field7852,
    :field7853,
    :field7854,
    :field7855,
    :field7856,
    :field7857,
    :field7858,
    :field7859
  ]

  field :field7844, 5, optional: true, type: :bool
  field :field7845, 1, optional: true, type: :int32
  field :field7846, 22, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7847, 3, repeated: true, type: :int32
  field :field7848, 11, repeated: true, type: :string
  field :field7849, 15, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field7850, 6, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7851, 14, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7852, 10, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7853, 13, optional: true, type: Benchmarks.GoogleMessage4.Message7511
  field :field7854, 16, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7855, 17, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7856, 19, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7857, 18, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7858, 20, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field7859, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3919 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4009: [Benchmarks.GoogleMessage4.Message3920.t()]
        }
  defstruct [:field4009]

  field :field4009, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message3920
end

defmodule Benchmarks.GoogleMessage4.Message7929 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7942: integer,
          field7943: integer,
          field7944: integer,
          field7945: integer,
          field7946: integer,
          field7947: integer,
          field7948: integer,
          field7949: integer,
          field7950: [Benchmarks.GoogleMessage4.Message7919.t()],
          field7951: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()],
          field7952: [Benchmarks.GoogleMessage4.Message7920.t()],
          field7953: [Benchmarks.GoogleMessage4.Message7921.t()],
          field7954: [Benchmarks.GoogleMessage4.Message7928.t()],
          field7955: integer,
          field7956: boolean,
          field7957: integer,
          field7958: integer,
          field7959: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()],
          field7960: [binary],
          field7961: integer
        }
  defstruct [
    :field7942,
    :field7943,
    :field7944,
    :field7945,
    :field7946,
    :field7947,
    :field7948,
    :field7949,
    :field7950,
    :field7951,
    :field7952,
    :field7953,
    :field7954,
    :field7955,
    :field7956,
    :field7957,
    :field7958,
    :field7959,
    :field7960,
    :field7961
  ]

  field :field7942, 1, optional: true, type: :int64
  field :field7943, 4, optional: true, type: :int64
  field :field7944, 5, optional: true, type: :int64
  field :field7945, 12, optional: true, type: :int64
  field :field7946, 13, optional: true, type: :int64
  field :field7947, 18, optional: true, type: :int64
  field :field7948, 6, optional: true, type: :int64
  field :field7949, 7, optional: true, type: :int64
  field :field7950, 8, repeated: true, type: Benchmarks.GoogleMessage4.Message7919
  field :field7951, 20, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7952, 14, repeated: true, type: Benchmarks.GoogleMessage4.Message7920
  field :field7953, 15, repeated: true, type: Benchmarks.GoogleMessage4.Message7921
  field :field7954, 17, repeated: true, type: Benchmarks.GoogleMessage4.Message7928
  field :field7955, 19, optional: true, type: :int64
  field :field7956, 2, optional: true, type: :bool
  field :field7957, 3, optional: true, type: :int64
  field :field7958, 9, optional: true, type: :int64
  field :field7959, 10, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7960, 11, repeated: true, type: :bytes
  field :field7961, 16, optional: true, type: :int64
end
