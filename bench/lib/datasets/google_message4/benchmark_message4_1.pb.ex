defmodule Benchmarks.GoogleMessage4.Message2463 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2498: [Benchmarks.GoogleMessage4.Message2462.t()]
        }

  defstruct field2498: []

  field :field2498, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message2462

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message12686 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12699: String.t(),
          field12700: Benchmarks.GoogleMessage4.Message12685.t() | nil
        }

  defstruct field12699: nil,
            field12700: nil

  field :field12699, 1, optional: true, type: :string

  field :field12700, 2, optional: true, type: Benchmarks.GoogleMessage4.Message12685

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message11949 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
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
          field12000: [Benchmarks.GoogleMessage4.UnusedEnum.t()],
          field12001: integer
        }

  defstruct field11992: nil,
            field11993: nil,
            field11994: [],
            field11995: nil,
            field11996: nil,
            field11997: nil,
            field11998: [],
            field11999: nil,
            field12000: [],
            field12001: nil

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

  def transform_module(), do: nil
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

  defstruct field7311: nil,
            field7312: nil,
            field7313: nil,
            field7314: nil,
            field7315: nil,
            field7316: nil,
            field7317: nil,
            field7318: nil

  field :field7311, 1, optional: true, type: Benchmarks.GoogleMessage4.Message6133

  field :field7312, 8, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  field :field7313, 3, optional: true, type: :string

  field :field7314, 4, optional: true, type: Benchmarks.GoogleMessage4.Message6643

  field :field7315, 5, optional: true, type: Benchmarks.GoogleMessage4.Enum7288, enum: true

  field :field7316, 6, optional: true, type: :bytes

  field :field7317, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  field :field7318, 9, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3061.Message3062 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3335: integer,
          field3336: integer,
          field3337: integer
        }

  defstruct field3335: 0,
            field3336: nil,
            field3337: nil

  field :field3335, 5, required: true, type: :int32

  field :field3336, 6, optional: true, type: :int32

  field :field3337, 7, optional: true, type: :int32

  def transform_module(), do: nil
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

  defstruct field3338: 0,
            field3339: nil,
            field3340: nil,
            field3341: nil

  field :field3338, 14, required: true, type: :int32

  field :field3339, 18, optional: true, type: Benchmarks.GoogleMessage4.Enum2851, enum: true

  field :field3340, 15, optional: true, type: :int64

  field :field3341, 23, optional: true, type: :int64

  def transform_module(), do: nil
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

  defstruct field3342: 0,
            field3343: nil,
            field3344: nil,
            field3345: nil,
            field3346: nil,
            field3347: nil,
            field3348: nil,
            field3349: nil,
            field3350: nil,
            field3351: nil,
            field3352: nil,
            field3353: nil,
            field3354: nil,
            field3355: nil,
            field3356: nil,
            field3357: nil,
            field3358: nil,
            field3359: nil,
            field3360: nil

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

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3061.Message3065 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
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

  defstruct field3366: nil,
            field3367: nil,
            field3368: nil,
            field3369: nil,
            field3370: nil,
            field3371: nil,
            field3372: nil,
            field3373: nil

  field :field3366, 22, optional: true, type: :int32

  field :field3367, 55, optional: true, type: :int32

  field :field3368, 88, optional: true, type: :int32

  field :field3369, 56, optional: true, type: :int32

  field :field3370, 75, optional: true, type: :int32

  field :field3371, 57, optional: true, type: :int32

  field :field3372, 85, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  field :field3373, 96, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  def transform_module(), do: nil
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

  defstruct field3286: nil,
            field3287: nil,
            field3288: nil,
            field3289: nil,
            field3290: nil,
            message3062: nil,
            field3292: nil,
            field3293: nil,
            field3294: nil,
            message3063: nil,
            field3296: nil,
            field3297: nil,
            field3298: nil,
            field3299: nil,
            field3300: nil,
            field3301: nil,
            field3302: nil,
            field3303: nil,
            field3304: nil,
            field3305: nil,
            field3306: nil,
            field3307: nil,
            field3308: nil,
            field3309: nil,
            field3310: nil,
            field3311: nil,
            field3312: nil,
            field3313: nil,
            message3064: [],
            field3315: nil,
            field3316: nil,
            message3065: nil,
            field3318: nil,
            field3319: nil,
            field3320: [],
            field3321: nil,
            field3322: nil,
            field3323: nil,
            field3324: nil,
            field3325: [],
            field3326: [],
            message3066: nil,
            field3328: nil,
            field3329: nil,
            field3330: nil,
            field3331: nil,
            field3332: nil,
            field3333: nil

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

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message12949 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
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

  defstruct field8647: nil,
            field8648: nil,
            field8649: nil,
            field8650: nil,
            field8651: nil,
            field8652: nil,
            field8653: nil,
            field8654: nil,
            field8655: nil,
            field8656: nil,
            field8657: nil,
            field8658: nil,
            field8659: nil,
            field8660: nil,
            field8661: nil,
            field8662: nil,
            field8663: nil,
            field8664: nil,
            field8665: nil,
            field8666: nil,
            field8667: nil,
            field8668: nil,
            field8669: nil,
            field8670: nil,
            field8671: nil,
            field8672: nil,
            field8673: nil,
            field8674: nil,
            field8675: nil,
            field8676: nil,
            field8677: nil,
            field8678: nil,
            field8679: nil,
            field8680: nil,
            field8681: nil,
            field8682: nil,
            field8683: nil,
            field8684: nil,
            field8685: nil,
            field8686: nil,
            field8687: nil,
            field8688: nil,
            field8689: nil,
            field8690: nil,
            field8691: nil,
            field8692: nil,
            field8693: nil,
            field8694: nil,
            field8695: nil,
            field8696: nil

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

  def transform_module(), do: nil
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

  defstruct field8810: nil,
            field8811: nil,
            field8812: nil,
            field8813: nil,
            field8814: nil

  field :field8810, 1, optional: true, type: :string

  field :field8811, 2, optional: true, type: :string

  field :field8812, 3, optional: true, type: :string

  field :field8813, 4, optional: true, type: :string

  field :field8814, 5, optional: true, type: :string

  def transform_module(), do: nil
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

  defstruct field12786: nil,
            field12787: nil,
            field12788: nil,
            field12789: nil,
            field12790: nil,
            field12791: nil,
            field12792: nil,
            field12793: nil,
            field12794: nil,
            field12795: nil,
            __pb_extensions__: nil

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

  def transform_module(), do: nil

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

  defstruct field12805: nil,
            field12806: nil,
            field12807: nil,
            field12808: nil

  field :field12805, 1, optional: true, type: :int32

  field :field12806, 2, optional: true, type: :int32

  field :field12807, 6, optional: true, type: Benchmarks.GoogleMessage4.Message12774

  field :field12808, 7, optional: true, type: :bool

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message12797 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12802: Benchmarks.GoogleMessage4.Message12796.t() | nil,
          field12803: [Benchmarks.GoogleMessage4.Message12796.t()],
          field12804: String.t()
        }

  defstruct field12802: nil,
            field12803: [],
            field12804: nil

  field :field12802, 1, optional: true, type: Benchmarks.GoogleMessage4.Message12796

  field :field12803, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message12796

  field :field12804, 3, optional: true, type: :string

  def transform_module(), do: nil
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

  defstruct field12862: [],
            field12863: nil,
            field12864: nil,
            field12865: nil,
            field12866: nil,
            field12867: [],
            field12868: []

  field :field12862, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message12818

  field :field12863, 2, optional: true, type: :int32

  field :field12864, 3, optional: true, type: Benchmarks.GoogleMessage4.Message12819

  field :field12865, 4, optional: true, type: Benchmarks.GoogleMessage4.Message12820

  field :field12866, 5, optional: true, type: :int32

  field :field12867, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message12821

  field :field12868, 7, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message8590 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message8587 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message1374 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field1375: String.t(),
          field1376: String.t()
        }

  defstruct field1375: "",
            field1376: nil

  field :field1375, 1, required: true, type: :string

  field :field1376, 2, optional: true, type: :string

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message2462 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2496: binary,
          field2497: float | :infinity | :negative_infinity | :nan
        }

  defstruct field2496: "",
            field2497: 0.0

  field :field2496, 1, required: true, type: :bytes

  field :field2497, 2, required: true, type: :double

  def transform_module(), do: nil
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

  defstruct field12692: [],
            field12693: [],
            field12694: nil,
            field12695: nil,
            field12696: [],
            field12697: nil,
            field12698: nil

  field :field12692, 1, repeated: true, type: :string

  field :field12693, 2, repeated: true, type: :string

  field :field12694, 3, optional: true, type: :int64

  field :field12695, 4, optional: true, type: :uint32

  field :field12696, 5, repeated: true, type: :string

  field :field12697, 6, optional: true, type: :string

  field :field12698, 7, optional: true, type: :string

  def transform_module(), do: nil
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

  defstruct field10347: nil,
            field10348: [],
            field10349: nil,
            field10350: nil,
            field10351: nil,
            field10352: nil,
            field10353: nil

  field :field10347, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum10335, enum: true

  field :field10348, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message10319

  field :field10349, 3, optional: true, type: :int32

  field :field10350, 4, optional: true, type: :int32

  field :field10351, 5, optional: true, type: :int32

  field :field10352, 6, optional: true, type: :int32

  field :field10353, 7, optional: true, type: Benchmarks.GoogleMessage4.Enum10337, enum: true

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message11947 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11951: non_neg_integer,
          field11952: boolean,
          field11953: integer
        }

  defstruct field11951: nil,
            field11952: nil,
            field11953: nil

  field :field11951, 1, optional: true, type: :uint32

  field :field11952, 2, optional: true, type: :bool

  field :field11953, 3, optional: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message11920 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11945: Benchmarks.GoogleMessage4.Enum11901.t(),
          field11946: Benchmarks.GoogleMessage4.UnusedEnum.t()
        }

  defstruct field11945: nil,
            field11946: nil

  field :field11945, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum11901, enum: true

  field :field11946, 2, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true

  def transform_module(), do: nil
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

  defstruct field6683: nil,
            field6684: nil,
            field6685: nil,
            field6686: nil,
            field6687: nil,
            field6688: nil,
            field6689: nil,
            field6690: nil,
            field6691: nil,
            field6692: nil,
            field6693: nil,
            field6694: nil,
            field6695: nil,
            field6696: nil,
            field6697: [],
            field6698: nil,
            field6699: nil,
            field6700: nil

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

  def transform_module(), do: nil
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

  defstruct field6173: nil,
            field6174: nil,
            field6175: "",
            field6176: "",
            field6177: "",
            field6178: nil,
            field6179: nil,
            field6180: [],
            field6181: [],
            field6182: [],
            field6183: [],
            field6184: [],
            field6185: nil,
            field6186: nil,
            field6187: nil,
            field6188: nil,
            field6189: nil,
            field6190: nil,
            field6191: nil,
            field6192: []

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

  def transform_module(), do: nil
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

  defstruct field6140: nil,
            field6141: 0,
            field6142: nil,
            field6143: nil,
            field6144: [],
            field6145: [],
            field6146: [],
            field6147: nil,
            field6148: [],
            field6149: nil,
            field6150: nil,
            field6151: nil,
            __pb_extensions__: nil

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

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end
defmodule Benchmarks.GoogleMessage4.Message3046 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3222: Benchmarks.GoogleMessage4.Enum2593.t(),
          field3223: integer
        }

  defstruct field3222: 0,
            field3223: nil

  field :field3222, 1, required: true, type: Benchmarks.GoogleMessage4.Enum2593, enum: true

  field :field3223, 4, optional: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3060 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3283: integer,
          field3284: integer,
          field3285: integer
        }

  defstruct field3283: nil,
            field3284: nil,
            field3285: nil

  field :field3283, 1, optional: true, type: :int64

  field :field3284, 2, optional: true, type: :int64

  field :field3285, 3, optional: true, type: :int64

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3041 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3214: String.t(),
          field3215: integer
        }

  defstruct field3214: nil,
            field3215: nil

  field :field3214, 1, optional: true, type: :string

  field :field3215, 2, optional: true, type: :int32

  def transform_module(), do: nil
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

  defstruct field3209: 0,
            field3210: [],
            field3211: nil,
            field3212: nil,
            field3213: ""

  field :field3209, 1, required: true, type: :fixed64

  field :field3210, 4, repeated: true, type: :fixed64

  field :field3211, 5, optional: true, type: :int32

  field :field3212, 2, optional: true, type: :fixed64

  field :field3213, 3, required: true, type: :string

  def transform_module(), do: nil
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

  defstruct field3245: nil,
            field3246: nil,
            field3247: nil,
            field3248: nil,
            field3249: nil,
            field3250: nil

  field :field3245, 5, optional: true, type: :bytes

  field :field3246, 2, optional: true, type: :int32

  field :field3247, 6, optional: true, type: :bytes

  field :field3248, 4, optional: true, type: :int32

  field :field3249, 1, optional: true, type: :fixed32

  field :field3250, 3, optional: true, type: :fixed32

  def transform_module(), do: nil
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

  defstruct field7911: nil,
            field7912: nil,
            field7913: nil,
            field7914: nil,
            field7915: nil,
            field7916: nil,
            field7917: nil

  field :field7911, 1, optional: true, type: :int32

  field :field7912, 2, optional: true, type: :bool

  field :field7913, 3, optional: true, type: :bytes

  field :field7914, 4, optional: true, type: :int32

  field :field7915, 5, optional: true, type: :int32

  field :field7916, 6, optional: true, type: :bytes

  field :field7917, 7, optional: true, type: :int32

  def transform_module(), do: nil
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

  defstruct field3932: "",
            field3933: nil,
            field3934: nil,
            field3935: nil

  field :field3932, 2, required: true, type: :string

  field :field3933, 9, optional: true, type: :string

  field :field3934, 3, optional: true, type: Benchmarks.GoogleMessage4.Message3850

  field :field3935, 8, optional: true, type: :bytes

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3886 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message3887: [any]
        }

  defstruct message3887: []

  field :message3887, 1, repeated: true, type: :group

  def transform_module(), do: nil
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

  defstruct field7866: nil,
            field7867: nil,
            field7868: [],
            field7869: [],
            field7870: [],
            field7871: []

  field :field7866, 1, optional: true, type: :string

  field :field7867, 2, optional: true, type: :string

  field :field7868, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message7865

  field :field7869, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message7865

  field :field7870, 7, repeated: true, type: Benchmarks.GoogleMessage4.Message7865

  field :field7871, 8, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3922 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4012: non_neg_integer
        }

  defstruct field4012: nil

  field :field4012, 1, optional: true, type: :uint64

  def transform_module(), do: nil
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

  defstruct field3254: [],
            field3255: [],
            field3256: [],
            field3257: [],
            field3258: nil,
            field3259: nil,
            field3260: nil,
            field3261: nil,
            field3262: nil

  field :field3254, 1, repeated: true, type: :string

  field :field3255, 2, repeated: true, type: :string

  field :field3256, 3, repeated: true, type: :bytes

  field :field3257, 4, repeated: true, type: :string

  field :field3258, 5, optional: true, type: :bool

  field :field3259, 6, optional: true, type: :int32

  field :field3260, 7, optional: true, type: :int32

  field :field3261, 8, optional: true, type: :string

  field :field3262, 9, optional: true, type: :string

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message8575 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []

  def transform_module(), do: nil
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

  defstruct field7844: nil,
            field7845: nil,
            field7846: nil,
            field7847: [],
            field7848: [],
            field7849: nil,
            field7850: nil,
            field7851: nil,
            field7852: nil,
            field7853: nil,
            field7854: nil,
            field7855: nil,
            field7856: nil,
            field7857: nil,
            field7858: nil,
            field7859: nil

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

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage4.Message3919 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4009: [Benchmarks.GoogleMessage4.Message3920.t()]
        }

  defstruct field4009: []

  field :field4009, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message3920

  def transform_module(), do: nil
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

  defstruct field7942: nil,
            field7943: nil,
            field7944: nil,
            field7945: nil,
            field7946: nil,
            field7947: nil,
            field7948: nil,
            field7949: nil,
            field7950: [],
            field7951: [],
            field7952: [],
            field7953: [],
            field7954: [],
            field7955: nil,
            field7956: nil,
            field7957: nil,
            field7958: nil,
            field7959: [],
            field7960: [],
            field7961: nil

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

  def transform_module(), do: nil
end
