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

  defstruct field12777: nil,
            field12778: nil,
            field12779: nil,
            field12780: nil,
            field12781: nil,
            field12782: nil

  field :field12777, 1, optional: true, type: :uint32

  field :field12778, 2, optional: true, type: :uint32

  field :field12779, 3, optional: true, type: :uint32

  field :field12780, 4, optional: true, type: :uint32

  field :field12781, 5, optional: true, type: :uint32

  field :field12782, 6, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage4.Message12796 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12800: [non_neg_integer],
          field12801: non_neg_integer
        }

  defstruct field12800: [],
            field12801: nil

  field :field12800, 1, repeated: true, type: :fixed64

  field :field12801, 2, optional: true, type: :uint64
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

  defstruct field12848: nil,
            field12849: nil,
            field12850: nil,
            field12851: nil,
            field12852: nil

  field :field12848, 1, optional: true, type: :int32

  field :field12849, 2, optional: true, type: :int32

  field :field12850, 3, optional: true, type: :int32

  field :field12851, 4, optional: true, type: :int32

  field :field12852, 5, optional: true, type: :int32
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

  defstruct field12840: nil,
            field12841: nil,
            field12842: nil,
            field12843: nil,
            field12844: nil,
            field12845: nil,
            field12846: nil,
            field12847: nil

  field :field12840, 1, optional: true, type: :int32

  field :field12841, 2, optional: true, type: :int32

  field :field12842, 3, optional: true, type: :int32

  field :field12843, 8, optional: true, type: :int32

  field :field12844, 4, optional: true, type: :int32

  field :field12845, 5, optional: true, type: :int32

  field :field12846, 6, optional: true, type: :int32

  field :field12847, 7, optional: true, type: :int32
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

  defstruct field12834: nil,
            field12835: nil,
            field12836: nil,
            field12837: nil,
            field12838: nil,
            field12839: nil

  field :field12834, 1, optional: true, type: :double

  field :field12835, 2, optional: true, type: :double

  field :field12836, 3, optional: true, type: :double

  field :field12837, 4, optional: true, type: :double

  field :field12838, 5, optional: true, type: :double

  field :field12839, 6, optional: true, type: :double
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

  defstruct field12829: nil,
            field12830: nil,
            field12831: nil,
            field12832: nil,
            field12833: []

  field :field12829, 1, optional: true, type: :uint64

  field :field12830, 2, optional: true, type: :int32

  field :field12831, 3, optional: true, type: :int32

  field :field12832, 5, optional: true, type: :int32

  field :field12833, 4, repeated: true, type: Benchmarks.GoogleMessage4.Message12817
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

  defstruct field10340: nil,
            field10341: nil,
            field10342: nil,
            field10343: nil,
            field10344: nil,
            field10345: nil,
            field10346: nil

  field :field10340, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum10325, enum: true

  field :field10341, 4, optional: true, type: :int32

  field :field10342, 5, optional: true, type: :int32

  field :field10343, 3, optional: true, type: :bytes

  field :field10344, 2, optional: true, type: :string

  field :field10345, 6, optional: true, type: :string

  field :field10346, 7, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage4.Message6578 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6632: Benchmarks.GoogleMessage4.Enum6579.t(),
          field6633: Benchmarks.GoogleMessage4.Enum6588.t()
        }

  defstruct field6632: nil,
            field6633: nil

  field :field6632, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum6579, enum: true

  field :field6633, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum6588, enum: true
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

  defstruct field6152: "",
            field6153: [],
            field6154: nil,
            field6155: nil,
            field6156: nil,
            field6157: nil,
            field6158: nil,
            field6159: nil,
            field6160: [],
            field6161: [],
            field6162: [],
            field6163: [],
            field6164: nil,
            field6165: [],
            field6166: nil,
            field6167: nil,
            field6168: nil,
            field6169: [],
            field6170: nil

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

  defstruct field5897: 0.0,
            field5898: nil,
            field5899: nil,
            field5900: nil,
            field5901: nil,
            field5902: nil

  field :field5897, 1, required: true, type: :double

  field :field5898, 5, optional: true, type: :string

  field :field5899, 2, optional: true, type: Benchmarks.GoogleMessage4.Message5861

  field :field5900, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage

  field :field5901, 4, optional: true, type: Benchmarks.GoogleMessage4.Message5867

  field :field5902, 6, optional: true, type: Benchmarks.GoogleMessage4.Message5880
end
defmodule Benchmarks.GoogleMessage4.Message6110 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
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

  defstruct field6134: nil,
            field6135: nil,
            field6136: nil,
            field6137: [],
            field6138: nil,
            field6139: []

  field :field6134, 1, optional: true, type: Benchmarks.GoogleMessage4.Message4016

  field :field6135, 2, optional: true, type: :int32

  field :field6136, 3, optional: true, type: :string

  field :field6137, 4, repeated: true, type: :int32

  field :field6138, 5, optional: true, type: :int32

  field :field6139, 6, repeated: true, type: Benchmarks.GoogleMessage4.Message6108
end
defmodule Benchmarks.GoogleMessage4.Message6129 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6171: Benchmarks.GoogleMessage4.Enum6130.t(),
          field6172: String.t()
        }

  defstruct field6171: 0,
            field6172: ""

  field :field6171, 1, required: true, type: Benchmarks.GoogleMessage4.Enum6130, enum: true

  field :field6172, 2, required: true, type: :string
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

  defstruct field5971: nil,
            field5972: nil,
            field5973: nil,
            field5974: nil,
            field5975: nil,
            field5976: nil,
            field5977: nil,
            field5978: nil,
            field5979: nil,
            field5980: nil,
            field5981: nil,
            field5982: nil,
            field5983: nil,
            field5984: nil,
            field5985: nil,
            field5986: nil,
            field5987: nil,
            field5988: nil,
            field5989: [],
            field5990: nil,
            field5991: nil,
            field5992: nil,
            field5993: nil,
            field5994: nil,
            field5995: nil,
            field5996: nil,
            field5997: nil,
            field5998: nil,
            field5999: nil,
            field6000: nil,
            field6001: nil,
            field6002: nil,
            field6003: [],
            field6004: nil,
            field6005: nil,
            field6006: nil,
            field6007: nil,
            field6008: nil,
            field6009: nil,
            field6010: nil,
            field6011: nil,
            field6012: nil,
            field6013: nil,
            field6014: nil,
            field6015: nil,
            field6016: nil,
            field6017: nil,
            field6018: nil,
            field6019: nil,
            field6020: nil

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

  defstruct field3924: nil,
            field3925: nil,
            field3926: nil,
            field3927: nil,
            field3928: nil,
            field3929: nil

  field :field3924, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum3851, enum: true

  field :field3925, 12, optional: true, type: :bool

  field :field3926, 4, optional: true, type: :int32

  field :field3927, 10, optional: true, type: :bool

  field :field3928, 13, optional: true, type: :bool

  field :field3929, 14, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage4.Message7865 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
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

  defstruct field7523: nil,
            field7524: nil,
            field7525: nil,
            field7526: nil,
            field7527: nil,
            field7528: nil,
            field7529: nil

  field :field7523, 1, optional: true, type: :bool

  field :field7524, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum7512, enum: true

  field :field7525, 3, optional: true, type: :int32

  field :field7526, 4, optional: true, type: :int32

  field :field7527, 5, optional: true, type: :bool

  field :field7528, 6, optional: true, type: :int32

  field :field7529, 7, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage4.Message3920 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage4.Message7928 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7940: String.t(),
          field7941: integer
        }

  defstruct field7940: nil,
            field7941: nil

  field :field7940, 1, optional: true, type: :string

  field :field7941, 2, optional: true, type: :int64
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

  defstruct field7936: nil,
            field7937: nil,
            field7938: nil,
            field7939: nil

  field :field7936, 1, optional: true, type: :int32

  field :field7937, 2, optional: true, type: :int64

  field :field7938, 3, optional: true, type: :float

  field :field7939, 4, optional: true, type: Benchmarks.GoogleMessage4.Enum7922, enum: true
end
defmodule Benchmarks.GoogleMessage4.Message7920 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7934: integer,
          field7935: integer
        }

  defstruct field7934: nil,
            field7935: nil

  field :field7934, 1, optional: true, type: :int64

  field :field7935, 2, optional: true, type: :int64
end
defmodule Benchmarks.GoogleMessage4.Message7919 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7931: non_neg_integer,
          field7932: integer,
          field7933: binary
        }

  defstruct field7931: nil,
            field7932: nil,
            field7933: nil

  field :field7931, 1, optional: true, type: :fixed64

  field :field7932, 2, optional: true, type: :int64

  field :field7933, 3, optional: true, type: :bytes
end
defmodule Benchmarks.GoogleMessage4.Message12817 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12826: integer,
          field12827: integer,
          field12828: integer
        }

  defstruct field12826: nil,
            field12827: nil,
            field12828: nil

  field :field12826, 1, optional: true, type: :int32

  field :field12827, 2, optional: true, type: :int32

  field :field12828, 3, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage4.Message6054 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6089: String.t(),
          field6090: String.t()
        }

  defstruct field6089: "",
            field6090: nil

  field :field6089, 1, required: true, type: :string

  field :field6090, 2, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage4.Message6127 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage4.Message6052 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6084: String.t(),
          field6085: binary
        }

  defstruct field6084: "",
            field6085: ""

  field :field6084, 1, required: true, type: :string

  field :field6085, 2, required: true, type: :bytes
end
defmodule Benchmarks.GoogleMessage4.Message6024 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6048: Benchmarks.GoogleMessage4.Enum6025.t(),
          field6049: String.t(),
          field6050: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }

  defstruct field6048: nil,
            field6049: nil,
            field6050: nil

  field :field6048, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum6025, enum: true

  field :field6049, 2, optional: true, type: :string

  field :field6050, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
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

  defstruct field5882: 0,
            field5883: "",
            field5884: nil,
            field5885: nil

  field :field5882, 1, required: true, type: Benchmarks.GoogleMessage4.Enum5862, enum: true

  field :field5883, 2, required: true, type: :string

  field :field5884, 3, optional: true, type: :bool

  field :field5885, 4, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage4.Message5880 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5896: String.t()
        }

  defstruct field5896: nil

  field :field5896, 1, optional: true, type: :string
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

  defstruct field5890: nil,
            field5891: nil,
            field5892: nil,
            field5893: nil,
            field5894: nil,
            field5895: nil

  field :field5890, 1, optional: true, type: Benchmarks.GoogleMessage4.Enum5868, enum: true

  field :field5891, 2, optional: true, type: :string

  field :field5892, 3, optional: true, type: Benchmarks.GoogleMessage4.Enum5873, enum: true

  field :field5893, 4, optional: true, type: :int32

  field :field5894, 5, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true

  field :field5895, 6, optional: true, type: :bool
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

  defstruct field4017: 0,
            field4018: 0,
            field4019: 0,
            field4020: 0

  field :field4017, 1, required: true, type: :int32

  field :field4018, 2, required: true, type: :int32

  field :field4019, 3, required: true, type: :int32

  field :field4020, 4, required: true, type: :int32
end
defmodule Benchmarks.GoogleMessage4.Message6108 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
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

  defstruct field5967: nil,
            field5968: nil,
            field5969: nil,
            field5970: nil

  field :field5967, 1, optional: true, type: Benchmarks.GoogleMessage4.Message5903

  field :field5968, 2, optional: true, type: Benchmarks.GoogleMessage4.Message5903

  field :field5969, 3, optional: true, type: Benchmarks.GoogleMessage4.Message5903

  field :field5970, 4, optional: true, type: Benchmarks.GoogleMessage4.Message5903
end
defmodule Benchmarks.GoogleMessage4.UnusedEmptyMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage4.Message5903 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field5965: integer,
          field5966: Benchmarks.GoogleMessage4.Enum5904.t()
        }

  defstruct field5965: 0,
            field5966: nil

  field :field5965, 1, required: true, type: :int32

  field :field5966, 2, optional: true, type: Benchmarks.GoogleMessage4.Enum5904, enum: true
end
