defmodule Benchmarks.GoogleMessage4.Message12774 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12777: non_neg_integer,
          field12778: non_neg_integer,
          field12779: non_neg_integer,
          field12780: non_neg_integer,
          field12781: non_neg_integer,
          field12782: boolean
        }

  defstruct [:field12777, :field12778, :field12779, :field12780, :field12781, :field12782]

  field :field12777, 1, optional: true, type: :uint32
  field :field12778, 2, optional: true, type: :uint32
  field :field12779, 3, optional: true, type: :uint32
  field :field12780, 4, optional: true, type: :uint32
  field :field12781, 5, optional: true, type: :uint32
  field :field12782, 6, optional: true, type: :bool
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message12796 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12800: [non_neg_integer],
          field12801: non_neg_integer
        }

  defstruct [:field12800, :field12801]

  field :field12800, 1, repeated: true, type: :fixed64
  field :field12801, 2, optional: true, type: :uint64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message12821 do
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

defmodule Benchmarks.GoogleMessage4.Message12820 do
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

defmodule Benchmarks.GoogleMessage4.Message12819 do
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

defmodule Benchmarks.GoogleMessage4.Message12818 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12829: non_neg_integer,
          field12830: integer,
          field12831: integer,
          field12832: integer,
          field12833: [Benchmarks.GoogleMessage4.Message12817.t()]
        }

  defstruct [:field12829, :field12830, :field12831, :field12832, :field12833]

  field :field12829, 1, optional: true, type: :uint64
  field :field12830, 2, optional: true, type: :int32
  field :field12831, 3, optional: true, type: :int32
  field :field12832, 5, optional: true, type: :int32
  field :field12833, 4, repeated: true, type: Benchmarks.GoogleMessage4.Message12817
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message10319 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10340: Benchmarks.GoogleMessage4.Enum10325.t(),
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

  field :field10340, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum10325, enum: true
  field :field10341, 4, optional: true, type: :int32
  field :field10342, 5, optional: true, type: :int32
  field :field10343, 3, optional: true, type: :bytes
  field :field10344, 2, optional: true, type: :string
  field :field10345, 6, optional: true, type: :string
  field :field10346, 7, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6578 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6632: Benchmarks.GoogleMessage4.Enum6579.t(),
          field6633: Benchmarks.GoogleMessage4.Enum6588.t()
        }

  defstruct [:field6632, :field6633]

  field :field6632, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum6579, enum: true
  field :field6633, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum6588, enum: true
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6126 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6152: String.t(),
          field6153: [Benchmarks.GoogleMessage4.Message6127.t()],
          field6154: integer,
          field6155: binary,
          field6156: Benchmarks.GoogleMessage4.Message6024.t() | nil,
          field6157: integer,
          field6158: String.t(),
          field6159: integer,
          field6160: [integer],
          field6161: [integer],
          field6162: [Benchmarks.GoogleMessage4.Message6052.t()],
          field6163: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()],
          field6164: Benchmarks.GoogleMessage4.Enum6065.t(),
          field6165: [Benchmarks.GoogleMessage4.Message6127.t()],
          field6166: boolean,
          field6167: boolean,
          field6168: boolean,
          field6169: [Benchmarks.GoogleMessage4.Message6054.t()],
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
  field :field6153, 9, repeated: true, type: Benchmarks.GoogleMessage4.Message6127
  field :field6154, 14, optional: true, type: :int32
  field :field6155, 10, optional: true, type: :bytes
  field :field6156, 12, optional: true, type: Benchmarks.GoogleMessage4.Message6024
  field :field6157, 4, optional: true, type: :int32
  field :field6158, 5, optional: true, type: :string
  field :field6159, 6, optional: true, type: :int32
  field :field6160, 2, repeated: true, type: :int32
  field :field6161, 3, repeated: true, type: :int32
  field :field6162, 7, repeated: true, type: Benchmarks.GoogleMessage4.Message6052
  field :field6163, 11, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field6164, 15, optional: true, type: Benchmarks.GoogleMessage4.Enum6065, enum: true
  field :field6165, 8, repeated: true, type: Benchmarks.GoogleMessage4.Message6127
  field :field6166, 13, optional: true, type: :bool
  field :field6167, 16, optional: true, type: :bool
  field :field6168, 18, optional: true, type: :bool
  field :field6169, 17, repeated: true, type: Benchmarks.GoogleMessage4.Message6054
  field :field6170, 19, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5881 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5897: float | :infinity | :negative_infinity | :nan,
          field5898: String.t(),
          field5899: Benchmarks.GoogleMessage4.Message5861.t() | nil,
          field5900: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field5901: Benchmarks.GoogleMessage4.Message5867.t() | nil,
          field5902: Benchmarks.GoogleMessage4.Message5880.t() | nil
        }

  defstruct [:field5897, :field5898, :field5899, :field5900, :field5901, :field5902]

  field :field5897, 1, required: true, type: :double
  field :field5898, 5, optional: true, type: :string
  field :field5899, 2, optional: true, type: Benchmarks.GoogleMessage4.Message5861
  field :field5900, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field5901, 4, optional: true, type: Benchmarks.GoogleMessage4.Message5867
  field :field5902, 6, optional: true, type: Benchmarks.GoogleMessage4.Message5880
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6110 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6107 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6134: Benchmarks.GoogleMessage4.Message4016.t() | nil,
          field6135: integer,
          field6136: String.t(),
          field6137: [integer],
          field6138: integer,
          field6139: [Benchmarks.GoogleMessage4.Message6108.t()]
        }

  defstruct [:field6134, :field6135, :field6136, :field6137, :field6138, :field6139]

  field :field6134, 1, optional: true, type: Benchmarks.GoogleMessage4.Message4016
  field :field6135, 2, optional: true, type: :int32
  field :field6136, 3, optional: true, type: :string
  field :field6137, 4, repeated: true, type: :int32
  field :field6138, 5, optional: true, type: :int32
  field :field6139, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message6108
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6129 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6171: Benchmarks.GoogleMessage4.Enum6130.t(),
          field6172: String.t()
        }

  defstruct [:field6171, :field6172]

  field :field6171, 1, required: true, type: Benchmarks.GoogleMessage4.Enum6130, enum: true
  field :field6172, 2, required: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5908 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5971: String.t(),
          field5972: integer,
          field5973: integer,
          field5974: Benchmarks.GoogleMessage4.Enum5909.t(),
          field5975: Benchmarks.GoogleMessage4.Enum5912.t(),
          field5976: non_neg_integer,
          field5977: non_neg_integer,
          field5978: non_neg_integer,
          field5979: String.t(),
          field5980: Benchmarks.GoogleMessage4.Enum5915.t(),
          field5981: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5982: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5983: Benchmarks.GoogleMessage4.Enum5920.t(),
          field5984: Benchmarks.GoogleMessage4.Enum5923.t(),
          field5985: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5986: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5987: Benchmarks.GoogleMessage4.Enum5928.t(),
          field5988: boolean,
          field5989: [non_neg_integer],
          field5990: String.t(),
          field5991: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5992: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5993: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5994: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5995: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5996: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5997: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5998: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5999: Benchmarks.GoogleMessage4.Enum5931.t(),
          field6000: Benchmarks.GoogleMessage4.Enum5935.t(),
          field6001: Benchmarks.GoogleMessage4.Enum5939.t(),
          field6002: Benchmarks.GoogleMessage4.Enum5939.t(),
          field6003: [integer],
          field6004: non_neg_integer,
          field6005: non_neg_integer,
          field6006: non_neg_integer,
          field6007: non_neg_integer,
          field6008: Benchmarks.GoogleMessage4.Enum5946.t(),
          field6009: Benchmarks.GoogleMessage4.Enum5946.t(),
          field6010: Benchmarks.GoogleMessage4.Enum5946.t(),
          field6011: Benchmarks.GoogleMessage4.Enum5946.t(),
          field6012: non_neg_integer,
          field6013: non_neg_integer,
          field6014: non_neg_integer,
          field6015: non_neg_integer,
          field6016: integer,
          field6017: float | :infinity | :negative_infinity | :nan,
          field6018: Benchmarks.GoogleMessage4.Enum5957.t(),
          field6019: Benchmarks.GoogleMessage4.Message5907.t() | nil,
          field6020: Benchmarks.GoogleMessage4.Enum5962.t()
        }

  defstruct [
    :field5971,
    :field5972,
    :field5973,
    :field5974,
    :field5975,
    :field5976,
    :field5977,
    :field5978,
    :field5979,
    :field5980,
    :field5981,
    :field5982,
    :field5983,
    :field5984,
    :field5985,
    :field5986,
    :field5987,
    :field5988,
    :field5989,
    :field5990,
    :field5991,
    :field5992,
    :field5993,
    :field5994,
    :field5995,
    :field5996,
    :field5997,
    :field5998,
    :field5999,
    :field6000,
    :field6001,
    :field6002,
    :field6003,
    :field6004,
    :field6005,
    :field6006,
    :field6007,
    :field6008,
    :field6009,
    :field6010,
    :field6011,
    :field6012,
    :field6013,
    :field6014,
    :field6015,
    :field6016,
    :field6017,
    :field6018,
    :field6019,
    :field6020
  ]

  field :field5971, 1, optional: true, type: :string
  field :field5972, 2, optional: true, type: :int32
  field :field5973, 3, optional: true, type: :int32
  field :field5974, 45, optional: true, type: Benchmarks.GoogleMessage4.Enum5909, enum: true
  field :field5975, 4, optional: true, type: Benchmarks.GoogleMessage4.Enum5912, enum: true
  field :field5976, 50, optional: true, type: :fixed32
  field :field5977, 5, optional: true, type: :fixed32
  field :field5978, 6, optional: true, type: :fixed32
  field :field5979, 7, optional: true, type: :string
  field :field5980, 8, optional: true, type: Benchmarks.GoogleMessage4.Enum5915, enum: true
  field :field5981, 9, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5982, 10, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5983, 11, optional: true, type: Benchmarks.GoogleMessage4.Enum5920, enum: true
  field :field5984, 40, optional: true, type: Benchmarks.GoogleMessage4.Enum5923, enum: true
  field :field5985, 41, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5986, 42, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5987, 47, optional: true, type: Benchmarks.GoogleMessage4.Enum5928, enum: true
  field :field5988, 48, optional: true, type: :bool
  field :field5989, 49, repeated: true, type: :fixed32
  field :field5990, 12, optional: true, type: :string
  field :field5991, 13, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5992, 14, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5993, 15, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5994, 16, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5995, 32, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5996, 33, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5997, 34, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5998, 35, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5999, 17, optional: true, type: Benchmarks.GoogleMessage4.Enum5931, enum: true
  field :field6000, 18, optional: true, type: Benchmarks.GoogleMessage4.Enum5935, enum: true
  field :field6001, 36, optional: true, type: Benchmarks.GoogleMessage4.Enum5939, enum: true
  field :field6002, 37, optional: true, type: Benchmarks.GoogleMessage4.Enum5939, enum: true
  field :field6003, 19, repeated: true, type: :int32
  field :field6004, 20, optional: true, type: :uint32
  field :field6005, 21, optional: true, type: :uint32
  field :field6006, 22, optional: true, type: :uint32
  field :field6007, 23, optional: true, type: :uint32
  field :field6008, 24, optional: true, type: Benchmarks.GoogleMessage4.Enum5946, enum: true
  field :field6009, 25, optional: true, type: Benchmarks.GoogleMessage4.Enum5946, enum: true
  field :field6010, 26, optional: true, type: Benchmarks.GoogleMessage4.Enum5946, enum: true
  field :field6011, 27, optional: true, type: Benchmarks.GoogleMessage4.Enum5946, enum: true
  field :field6012, 28, optional: true, type: :fixed32
  field :field6013, 29, optional: true, type: :fixed32
  field :field6014, 30, optional: true, type: :fixed32
  field :field6015, 31, optional: true, type: :fixed32
  field :field6016, 38, optional: true, type: :int32
  field :field6017, 39, optional: true, type: :float
  field :field6018, 43, optional: true, type: Benchmarks.GoogleMessage4.Enum5957, enum: true
  field :field6019, 44, optional: true, type: Benchmarks.GoogleMessage4.Message5907
  field :field6020, 46, optional: true, type: Benchmarks.GoogleMessage4.Enum5962, enum: true
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message3850 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3924: Benchmarks.GoogleMessage4.Enum3851.t(),
          field3925: boolean,
          field3926: integer,
          field3927: boolean,
          field3928: boolean,
          field3929: boolean
        }

  defstruct [:field3924, :field3925, :field3926, :field3927, :field3928, :field3929]

  field :field3924, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum3851, enum: true
  field :field3925, 12, optional: true, type: :bool
  field :field3926, 4, optional: true, type: :int32
  field :field3927, 10, optional: true, type: :bool
  field :field3928, 13, optional: true, type: :bool
  field :field3929, 14, optional: true, type: :bool
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7865 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7511 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7523: boolean,
          field7524: Benchmarks.GoogleMessage4.Enum7512.t(),
          field7525: integer,
          field7526: integer,
          field7527: boolean,
          field7528: integer,
          field7529: integer
        }

  defstruct [:field7523, :field7524, :field7525, :field7526, :field7527, :field7528, :field7529]

  field :field7523, 1, optional: true, type: :bool
  field :field7524, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum7512, enum: true
  field :field7525, 3, optional: true, type: :int32
  field :field7526, 4, optional: true, type: :int32
  field :field7527, 5, optional: true, type: :bool
  field :field7528, 6, optional: true, type: :int32
  field :field7529, 7, optional: true, type: :int32
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message3920 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7928 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7940: String.t(),
          field7941: integer
        }

  defstruct [:field7940, :field7941]

  field :field7940, 1, optional: true, type: :string
  field :field7941, 2, optional: true, type: :int64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7921 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7936: integer,
          field7937: integer,
          field7938: float | :infinity | :negative_infinity | :nan,
          field7939: Benchmarks.GoogleMessage4.Enum7922.t()
        }

  defstruct [:field7936, :field7937, :field7938, :field7939]

  field :field7936, 1, optional: true, type: :int32
  field :field7937, 2, optional: true, type: :int64
  field :field7938, 3, optional: true, type: :float
  field :field7939, 4, optional: true, type: Benchmarks.GoogleMessage4.Enum7922, enum: true
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7920 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7934: integer,
          field7935: integer
        }

  defstruct [:field7934, :field7935]

  field :field7934, 1, optional: true, type: :int64
  field :field7935, 2, optional: true, type: :int64
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message7919 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7931: non_neg_integer,
          field7932: integer,
          field7933: binary
        }

  defstruct [:field7931, :field7932, :field7933]

  field :field7931, 1, optional: true, type: :fixed64
  field :field7932, 2, optional: true, type: :int64
  field :field7933, 3, optional: true, type: :bytes
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message12817 do
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
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6054 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6089: String.t(),
          field6090: String.t()
        }

  defstruct [:field6089, :field6090]

  field :field6089, 1, required: true, type: :string
  field :field6090, 2, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6127 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6052 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6084: String.t(),
          field6085: binary
        }

  defstruct [:field6084, :field6085]

  field :field6084, 1, required: true, type: :string
  field :field6085, 2, required: true, type: :bytes
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message6024 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6048: Benchmarks.GoogleMessage4.Enum6025.t(),
          field6049: String.t(),
          field6050: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }

  defstruct [:field6048, :field6049, :field6050]

  field :field6048, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum6025, enum: true
  field :field6049, 2, optional: true, type: :string
  field :field6050, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5861 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5882: Benchmarks.GoogleMessage4.Enum5862.t(),
          field5883: String.t(),
          field5884: boolean,
          field5885: String.t()
        }

  defstruct [:field5882, :field5883, :field5884, :field5885]

  field :field5882, 1, required: true, type: Benchmarks.GoogleMessage4.Enum5862, enum: true
  field :field5883, 2, required: true, type: :string
  field :field5884, 3, optional: true, type: :bool
  field :field5885, 4, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5880 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5896: String.t()
        }

  defstruct [:field5896]

  field :field5896, 1, optional: true, type: :string
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5867 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5890: Benchmarks.GoogleMessage4.Enum5868.t(),
          field5891: String.t(),
          field5892: Benchmarks.GoogleMessage4.Enum5873.t(),
          field5893: integer,
          field5894: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field5895: boolean
        }

  defstruct [:field5890, :field5891, :field5892, :field5893, :field5894, :field5895]

  field :field5890, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum5868, enum: true
  field :field5891, 2, optional: true, type: :string
  field :field5892, 3, optional: true, type: Benchmarks.GoogleMessage4.Enum5873, enum: true
  field :field5893, 4, optional: true, type: :int32
  field :field5894, 5, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field5895, 6, optional: true, type: :bool
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message4016 do
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

defmodule Benchmarks.GoogleMessage4.Message6108 do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5907 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5967: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5968: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5969: Benchmarks.GoogleMessage4.Message5903.t() | nil,
          field5970: Benchmarks.GoogleMessage4.Message5903.t() | nil
        }

  defstruct [:field5967, :field5968, :field5969, :field5970]

  field :field5967, 1, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5968, 2, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5969, 3, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  field :field5970, 4, optional: true, type: Benchmarks.GoogleMessage4.Message5903
  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.UnusedEmptyMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}
  defstruct []

  def transform_module(), do: nil
end

defmodule Benchmarks.GoogleMessage4.Message5903 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5965: integer,
          field5966: Benchmarks.GoogleMessage4.Enum5904.t()
        }

  defstruct [:field5965, :field5966]

  field :field5965, 1, required: true, type: :int32
  field :field5966, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum5904, enum: true
  def transform_module(), do: nil
end
