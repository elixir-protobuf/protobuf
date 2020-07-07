defmodule Benchmarks.GoogleMessage4.GoogleMessage4 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37503: integer,
          field37504: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37505: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37506: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37507: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37508: Benchmarks.GoogleMessage4.Message37489.t() | nil,
          field37509: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37510: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37511: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37512: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37513: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37514: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37515: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37516: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37517: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37518: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field37503,
    :field37504,
    :field37505,
    :field37506,
    :field37507,
    :field37508,
    :field37509,
    :field37510,
    :field37511,
    :field37512,
    :field37513,
    :field37514,
    :field37515,
    :field37516,
    :field37517,
    :field37518
  ]

  field :field37503, 1, optional: true, type: :int32
  field :field37504, 2, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37505, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37506, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37507, 5, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37508, 6, optional: true, type: Benchmarks.GoogleMessage4.Message37489
  field :field37509, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37510, 8, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37511, 9, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37512, 10, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37513, 11, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37514, 12, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37515, 13, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37516, 14, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37517, 15, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37518, 16, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message37489 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37534: Benchmarks.GoogleMessage4.Message2517.t() | nil,
          field37535: Benchmarks.GoogleMessage4.Message7330.t() | nil,
          field37536: Benchmarks.GoogleMessage4.Message8815.t() | nil,
          field37537: Benchmarks.GoogleMessage4.Message8817.t() | nil,
          field37538: Benchmarks.GoogleMessage4.Message8835.t() | nil,
          field37539: Benchmarks.GoogleMessage4.Message8848.t() | nil,
          field37540: Benchmarks.GoogleMessage4.Message8856.t() | nil,
          field37541: Benchmarks.GoogleMessage4.Message12717.t() | nil,
          field37542: Benchmarks.GoogleMessage4.Message12748.t() | nil,
          field37543: Benchmarks.GoogleMessage4.Message7319.t() | nil,
          field37544: Benchmarks.GoogleMessage4.Message12908.t() | nil,
          field37545: Benchmarks.GoogleMessage4.Message12910.t() | nil,
          field37546: Benchmarks.GoogleMessage4.Message12960.t() | nil,
          field37547: Benchmarks.GoogleMessage4.Message176.t() | nil,
          field37548: Benchmarks.GoogleMessage4.Message13000.t() | nil,
          field37549: Benchmarks.GoogleMessage4.Message13035.t() | nil,
          field37550: Benchmarks.GoogleMessage4.Message37331.t() | nil,
          field37551: Benchmarks.GoogleMessage4.Message37329.t() | nil,
          field37552: Benchmarks.GoogleMessage4.Message37327.t() | nil,
          field37553: Benchmarks.GoogleMessage4.Message37333.t() | nil,
          field37554: Benchmarks.GoogleMessage4.Message37335.t() | nil
        }
  defstruct [
    :field37534,
    :field37535,
    :field37536,
    :field37537,
    :field37538,
    :field37539,
    :field37540,
    :field37541,
    :field37542,
    :field37543,
    :field37544,
    :field37545,
    :field37546,
    :field37547,
    :field37548,
    :field37549,
    :field37550,
    :field37551,
    :field37552,
    :field37553,
    :field37554
  ]

  field :field37534, 3, optional: true, type: Benchmarks.GoogleMessage4.Message2517
  field :field37535, 4, optional: true, type: Benchmarks.GoogleMessage4.Message7330
  field :field37536, 6, optional: true, type: Benchmarks.GoogleMessage4.Message8815
  field :field37537, 7, optional: true, type: Benchmarks.GoogleMessage4.Message8817
  field :field37538, 8, optional: true, type: Benchmarks.GoogleMessage4.Message8835
  field :field37539, 9, optional: true, type: Benchmarks.GoogleMessage4.Message8848
  field :field37540, 11, optional: true, type: Benchmarks.GoogleMessage4.Message8856
  field :field37541, 15, optional: true, type: Benchmarks.GoogleMessage4.Message12717
  field :field37542, 20, optional: true, type: Benchmarks.GoogleMessage4.Message12748
  field :field37543, 22, optional: true, type: Benchmarks.GoogleMessage4.Message7319
  field :field37544, 24, optional: true, type: Benchmarks.GoogleMessage4.Message12908
  field :field37545, 25, optional: true, type: Benchmarks.GoogleMessage4.Message12910
  field :field37546, 30, optional: true, type: Benchmarks.GoogleMessage4.Message12960
  field :field37547, 33, optional: true, type: Benchmarks.GoogleMessage4.Message176
  field :field37548, 34, optional: true, type: Benchmarks.GoogleMessage4.Message13000
  field :field37549, 35, optional: true, type: Benchmarks.GoogleMessage4.Message13035
  field :field37550, 36, optional: true, type: Benchmarks.GoogleMessage4.Message37331
  field :field37551, 37, optional: true, type: Benchmarks.GoogleMessage4.Message37329
  field :field37552, 38, optional: true, type: Benchmarks.GoogleMessage4.Message37327
  field :field37553, 39, optional: true, type: Benchmarks.GoogleMessage4.Message37333
  field :field37554, 40, optional: true, type: Benchmarks.GoogleMessage4.Message37335
end

defmodule Benchmarks.GoogleMessage4.Message7319 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7321: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7322: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [:field7321, :field7322]

  field :field7321, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7322, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message12717 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12719: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12720: String.t(),
          field12721: non_neg_integer,
          field12722: Benchmarks.GoogleMessage4.Message11976.t() | nil,
          field12723: [Benchmarks.GoogleMessage4.Message11948.t()],
          field12724: Benchmarks.GoogleMessage4.Message11947.t() | nil,
          field12725: Benchmarks.GoogleMessage4.Message12687.t() | nil,
          field12726: [Benchmarks.GoogleMessage4.Message11948.t()],
          field12727: integer
        }
  defstruct [
    :field12719,
    :field12720,
    :field12721,
    :field12722,
    :field12723,
    :field12724,
    :field12725,
    :field12726,
    :field12727
  ]

  field :field12719, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12720, 2, optional: true, type: :string
  field :field12721, 3, optional: true, type: :uint32
  field :field12722, 4, optional: true, type: Benchmarks.GoogleMessage4.Message11976
  field :field12723, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message11948
  field :field12724, 6, optional: true, type: Benchmarks.GoogleMessage4.Message11947
  field :field12725, 7, optional: true, type: Benchmarks.GoogleMessage4.Message12687
  field :field12726, 8, repeated: true, type: Benchmarks.GoogleMessage4.Message11948
  field :field12727, 9, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage4.Message37331 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37367: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37368: Benchmarks.GoogleMessage4.Message37326.t() | nil,
          field37369: integer,
          field37370: binary
        }
  defstruct [:field37367, :field37368, :field37369, :field37370]

  field :field37367, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37368, 1, required: true, type: Benchmarks.GoogleMessage4.Message37326
  field :field37369, 2, required: true, type: :int64
  field :field37370, 3, required: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage4.Message8815 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8819: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8820: [Benchmarks.GoogleMessage4.Message8768.t()],
          field8821: boolean
        }
  defstruct [:field8819, :field8820, :field8821]

  field :field8819, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8820, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message8768
  field :field8821, 3, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message7330 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7332: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7333: Benchmarks.GoogleMessage4.Message3069.t() | nil,
          field7334: Benchmarks.GoogleMessage4.Message7320.t() | nil,
          field7335: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7336: boolean,
          field7337: integer
        }
  defstruct [:field7332, :field7333, :field7334, :field7335, :field7336, :field7337]

  field :field7332, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7333, 2, optional: true, type: Benchmarks.GoogleMessage4.Message3069
  field :field7334, 3, optional: true, type: Benchmarks.GoogleMessage4.Message7320
  field :field7335, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7336, 5, optional: true, type: :bool
  field :field7337, 6, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage4.Message12960 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12962: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12963: Benchmarks.GoogleMessage4.Message12948.t() | nil
        }
  defstruct [:field12962, :field12963]

  field :field12962, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12963, 2, optional: true, type: Benchmarks.GoogleMessage4.Message12948
end

defmodule Benchmarks.GoogleMessage4.Message176.Message178 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message176 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field408: String.t(),
          field409: integer,
          field410: String.t(),
          field411: integer,
          field412: non_neg_integer,
          field413: String.t(),
          field414: integer,
          field415: String.t(),
          field416: binary,
          field417: String.t(),
          field418: integer,
          field419: float | :infinity | :negative_infinity | :nan,
          field420: boolean,
          field421: boolean,
          field422: integer,
          field423: [integer],
          field424: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field425: boolean,
          field426: non_neg_integer,
          field427: integer,
          field428: binary,
          field429: binary,
          field430: binary,
          field431: binary,
          field432: boolean,
          field433: binary,
          field434: binary,
          field435: integer,
          field436: non_neg_integer,
          field437: integer,
          field438: non_neg_integer,
          field439: String.t(),
          field440: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field441: integer,
          field442: non_neg_integer,
          field443: binary,
          field444: binary,
          field445: binary,
          field446: String.t(),
          field447: String.t(),
          field448: integer,
          field449: boolean,
          field450: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field451: [Benchmarks.GoogleMessage4.UnusedEmptyMessage.t()],
          field452: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field453: integer,
          field454: integer,
          field455: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field456: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field457: integer,
          message178: [any],
          field459: boolean,
          field460: non_neg_integer,
          field461: non_neg_integer,
          field462: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field463: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field464: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field465: [String.t()],
          field466: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field408,
    :field409,
    :field410,
    :field411,
    :field412,
    :field413,
    :field414,
    :field415,
    :field416,
    :field417,
    :field418,
    :field419,
    :field420,
    :field421,
    :field422,
    :field423,
    :field424,
    :field425,
    :field426,
    :field427,
    :field428,
    :field429,
    :field430,
    :field431,
    :field432,
    :field433,
    :field434,
    :field435,
    :field436,
    :field437,
    :field438,
    :field439,
    :field440,
    :field441,
    :field442,
    :field443,
    :field444,
    :field445,
    :field446,
    :field447,
    :field448,
    :field449,
    :field450,
    :field451,
    :field452,
    :field453,
    :field454,
    :field455,
    :field456,
    :field457,
    :message178,
    :field459,
    :field460,
    :field461,
    :field462,
    :field463,
    :field464,
    :field465,
    :field466
  ]

  field :field408, 1, required: true, type: :string
  field :field409, 4, optional: true, type: :int32
  field :field410, 50, optional: true, type: :string
  field :field411, 2, optional: true, type: :int32
  field :field412, 47, optional: true, type: :uint64
  field :field413, 56, optional: true, type: :string
  field :field414, 24, optional: true, type: :int32
  field :field415, 21, optional: true, type: :string
  field :field416, 3, optional: true, type: :bytes
  field :field417, 57, optional: true, type: :string
  field :field418, 51, optional: true, type: :int32
  field :field419, 7, optional: true, type: :float
  field :field420, 5, optional: true, type: :bool
  field :field421, 28, optional: true, type: :bool
  field :field422, 6, optional: true, type: :int32
  field :field423, 40, repeated: true, type: :int32
  field :field424, 41, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field425, 25, optional: true, type: :bool
  field :field426, 26, optional: true, type: :uint64
  field :field427, 38, optional: true, type: :int32
  field :field428, 15, optional: true, type: :bytes
  field :field429, 55, optional: true, type: :bytes
  field :field430, 16, optional: true, type: :bytes
  field :field431, 23, optional: true, type: :bytes
  field :field432, 33, optional: true, type: :bool
  field :field433, 31, optional: true, type: :bytes
  field :field434, 32, optional: true, type: :bytes
  field :field435, 36, optional: true, type: :int32
  field :field436, 17, optional: true, type: :uint64
  field :field437, 45, optional: true, type: :int32
  field :field438, 18, optional: true, type: :uint64
  field :field439, 46, optional: true, type: :string
  field :field440, 64, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field441, 39, optional: true, type: :int32
  field :field442, 48, optional: true, type: :uint64
  field :field443, 19, optional: true, type: :bytes
  field :field444, 42, optional: true, type: :bytes
  field :field445, 43, optional: true, type: :bytes
  field :field446, 44, optional: true, type: :string
  field :field447, 49, optional: true, type: :string
  field :field448, 20, optional: true, type: :int64
  field :field449, 53, optional: true, type: :bool
  field :field450, 54, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field451, 22, repeated: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field452, 27, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field453, 29, optional: true, type: :int32
  field :field454, 30, optional: true, type: :int32
  field :field455, 37, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field456, 34, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field457, 35, optional: true, type: :int32
  field :message178, 101, repeated: true, type: :group
  field :field459, 52, optional: true, type: :bool
  field :field460, 58, optional: true, type: :uint64
  field :field461, 59, optional: true, type: :uint64
  field :field462, 60, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field463, 61, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field464, 62, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field465, 63, repeated: true, type: :string
  field :field466, 65, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message8817 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8825: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8826: [Benchmarks.GoogleMessage4.Message8768.t()],
          field8827: String.t()
        }
  defstruct [:field8825, :field8826, :field8827]

  field :field8825, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8826, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message8768
  field :field8827, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message8835 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8837: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8838: [String.t()],
          field8839: Benchmarks.GoogleMessage4.UnusedEnum.t()
        }
  defstruct [:field8837, :field8838, :field8839]

  field :field8837, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8838, 2, repeated: true, type: :string
  field :field8839, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message37333 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37372: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37373: Benchmarks.GoogleMessage4.Message37326.t() | nil,
          field37374: non_neg_integer
        }
  defstruct [:field37372, :field37373, :field37374]

  field :field37372, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37373, 1, required: true, type: Benchmarks.GoogleMessage4.Message37326
  field :field37374, 2, optional: true, type: :uint64
end

defmodule Benchmarks.GoogleMessage4.Message13000 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13015: integer,
          field13016: [Benchmarks.GoogleMessage4.Message12979.t()]
        }
  defstruct [:field13015, :field13016]

  field :field13015, 1, optional: true, type: :int64
  field :field13016, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message12979
end

defmodule Benchmarks.GoogleMessage4.Message37335 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37376: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37377: Benchmarks.GoogleMessage4.Message37326.t() | nil,
          field37378: Benchmarks.GoogleMessage4.Message37173.t() | nil,
          field37379: non_neg_integer
        }
  defstruct [:field37376, :field37377, :field37378, :field37379]

  field :field37376, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37377, 1, required: true, type: Benchmarks.GoogleMessage4.Message37326
  field :field37378, 2, required: true, type: Benchmarks.GoogleMessage4.Message37173
  field :field37379, 3, optional: true, type: :uint64
end

defmodule Benchmarks.GoogleMessage4.Message8848 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8850: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8851: String.t(),
          field8852: binary
        }
  defstruct [:field8850, :field8851, :field8852]

  field :field8850, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8851, 2, optional: true, type: :string
  field :field8852, 3, optional: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage4.Message13035 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13058: integer,
          field13059: [integer]
        }
  defstruct [:field13058, :field13059]

  field :field13058, 1, optional: true, type: :int64
  field :field13059, 2, repeated: true, type: :int64
end

defmodule Benchmarks.GoogleMessage4.Message8856 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8858: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8859: String.t()
        }
  defstruct [:field8858, :field8859]

  field :field8858, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8859, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message12908 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12912: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12913: String.t(),
          field12914: Benchmarks.GoogleMessage4.Message12799.t() | nil,
          field12915: integer,
          field12916: Benchmarks.GoogleMessage4.Message3804.t() | nil,
          field12917: Benchmarks.GoogleMessage4.Message12870.t() | nil
        }
  defstruct [:field12912, :field12913, :field12914, :field12915, :field12916, :field12917]

  field :field12912, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12913, 2, optional: true, type: :string
  field :field12914, 3, optional: true, type: Benchmarks.GoogleMessage4.Message12799
  field :field12915, 4, optional: true, type: :int64
  field :field12916, 5, optional: true, type: Benchmarks.GoogleMessage4.Message3804
  field :field12917, 6, optional: true, type: Benchmarks.GoogleMessage4.Message12870
end

defmodule Benchmarks.GoogleMessage4.Message12910 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12920: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12921: Benchmarks.GoogleMessage4.Message12818.t() | nil,
          field12922: [Benchmarks.GoogleMessage4.Message12903.t()]
        }
  defstruct [:field12920, :field12921, :field12922]

  field :field12920, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12921, 2, optional: true, type: Benchmarks.GoogleMessage4.Message12818
  field :field12922, 3, repeated: true, type: Benchmarks.GoogleMessage4.Message12903
end

defmodule Benchmarks.GoogleMessage4.Message37327 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37347: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37348: Benchmarks.GoogleMessage4.Message37326.t() | nil,
          field37349: boolean,
          field37350: boolean,
          field37351: boolean,
          field37352: boolean,
          field37353: boolean,
          field37354: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37355: non_neg_integer,
          field37356: boolean,
          field37357: boolean
        }
  defstruct [
    :field37347,
    :field37348,
    :field37349,
    :field37350,
    :field37351,
    :field37352,
    :field37353,
    :field37354,
    :field37355,
    :field37356,
    :field37357
  ]

  field :field37347, 11, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37348, 1, required: true, type: Benchmarks.GoogleMessage4.Message37326
  field :field37349, 2, optional: true, type: :bool
  field :field37350, 3, optional: true, type: :bool
  field :field37351, 4, optional: true, type: :bool
  field :field37352, 5, optional: true, type: :bool
  field :field37353, 6, optional: true, type: :bool
  field :field37354, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37355, 8, optional: true, type: :uint64
  field :field37356, 9, optional: true, type: :bool
  field :field37357, 10, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message37329 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37359: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37360: Benchmarks.GoogleMessage4.Message37326.t() | nil,
          field37361: integer,
          field37362: integer,
          field37363: boolean
        }
  defstruct [:field37359, :field37360, :field37361, :field37362, :field37363]

  field :field37359, 6, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37360, 1, required: true, type: Benchmarks.GoogleMessage4.Message37326
  field :field37361, 2, required: true, type: :int64
  field :field37362, 3, required: true, type: :int64
  field :field37363, 4, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message2517 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2519: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field2520: Benchmarks.GoogleMessage4.Message2356.t() | nil,
          field2521: Benchmarks.GoogleMessage4.Message0.t() | nil,
          field2522: Benchmarks.GoogleMessage4.Message2463.t() | nil,
          field2523: [Benchmarks.GoogleMessage4.Message971.t()]
        }
  defstruct [:field2519, :field2520, :field2521, :field2522, :field2523]

  field :field2519, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field2520, 2, optional: true, type: Benchmarks.GoogleMessage4.Message2356
  field :field2521, 3, optional: true, type: Benchmarks.GoogleMessage4.Message0
  field :field2522, 4, optional: true, type: Benchmarks.GoogleMessage4.Message2463
  field :field2523, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message971
end

defmodule Benchmarks.GoogleMessage4.Message12748 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12754: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12755: String.t(),
          field12756: String.t(),
          field12757: Benchmarks.GoogleMessage4.Enum12735.t()
        }
  defstruct [:field12754, :field12755, :field12756, :field12757]

  field :field12754, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12755, 2, optional: true, type: :string
  field :field12756, 3, optional: true, type: :string
  field :field12757, 4, optional: true, type: Benchmarks.GoogleMessage4.Enum12735, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message12687 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12701: [Benchmarks.GoogleMessage4.Message12686.t()]
        }
  defstruct [:field12701]

  field :field12701, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message12686
end

defmodule Benchmarks.GoogleMessage4.Message11948 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11954: String.t(),
          field11955: [Benchmarks.GoogleMessage4.Message11949.t()],
          field11956: boolean
        }
  defstruct [:field11954, :field11955, :field11956]

  field :field11954, 1, optional: true, type: :string
  field :field11955, 2, repeated: true, type: Benchmarks.GoogleMessage4.Message11949
  field :field11956, 3, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message11976 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12002: [Benchmarks.GoogleMessage4.Message11975.t()]
        }
  defstruct [:field12002]

  field :field12002, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message11975
end

defmodule Benchmarks.GoogleMessage4.Message7320 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7323: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field7324: Benchmarks.GoogleMessage4.Message7287.t() | nil
        }
  defstruct [:field7323, :field7324]

  field :field7323, 1, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field7324, 8, optional: true, type: Benchmarks.GoogleMessage4.Message7287
end

defmodule Benchmarks.GoogleMessage4.Message3069.Message3070 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3378: Benchmarks.GoogleMessage4.Enum3071.t(),
          field3379: binary
        }
  defstruct [:field3378, :field3379]

  field :field3378, 4, required: true, type: Benchmarks.GoogleMessage4.Enum3071, enum: true
  field :field3379, 5, required: true, type: :bytes
end

defmodule Benchmarks.GoogleMessage4.Message3069 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3374: Benchmarks.GoogleMessage4.Message3061.t() | nil,
          field3375: binary,
          message3070: [any],
          __pb_extensions__: map
        }
  defstruct [:field3374, :field3375, :message3070, :__pb_extensions__]

  field :field3374, 1, optional: true, type: Benchmarks.GoogleMessage4.Message3061
  field :field3375, 2, optional: true, type: :bytes
  field :message3070, 3, repeated: true, type: :group

  extensions [{10000, 536_870_912}]
end

defmodule Benchmarks.GoogleMessage4.Message12948 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12958: [Benchmarks.GoogleMessage4.Message12949.t()]
        }
  defstruct [:field12958]

  field :field12958, 1, repeated: true, type: Benchmarks.GoogleMessage4.Message12949
end

defmodule Benchmarks.GoogleMessage4.Message8768 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8782: String.t(),
          field8783: Benchmarks.GoogleMessage4.Message8572.t() | nil,
          field8784: boolean,
          field8785: [Benchmarks.GoogleMessage4.Message8774.t()],
          field8786: integer,
          field8787: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field8788: String.t()
        }
  defstruct [:field8782, :field8783, :field8784, :field8785, :field8786, :field8787, :field8788]

  field :field8782, 1, optional: true, type: :string
  field :field8783, 2, optional: true, type: Benchmarks.GoogleMessage4.Message8572
  field :field8784, 3, optional: true, type: :bool
  field :field8785, 4, repeated: true, type: Benchmarks.GoogleMessage4.Message8774
  field :field8786, 5, optional: true, type: :int64
  field :field8787, 6, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field8788, 7, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message12979 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12981: binary,
          field12982: [String.t()],
          field12983: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field12984: integer,
          field12985: String.t(),
          field12986: integer,
          field12987: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil
        }
  defstruct [
    :field12981,
    :field12982,
    :field12983,
    :field12984,
    :field12985,
    :field12986,
    :field12987
  ]

  field :field12981, 1, required: true, type: :bytes
  field :field12982, 2, repeated: true, type: :string
  field :field12983, 3, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field12984, 4, optional: true, type: :int64
  field :field12985, 5, optional: true, type: :string
  field :field12986, 6, optional: true, type: :int32
  field :field12987, 7, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage4.Message37173 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37252: String.t(),
          field37253: integer,
          field37254: Benchmarks.GoogleMessage4.UnusedEnum.t(),
          field37255: boolean,
          field37256: boolean,
          field37257: boolean,
          field37258: String.t(),
          field37259: String.t(),
          field37260: non_neg_integer,
          field37261: non_neg_integer,
          field37262: String.t(),
          field37263: String.t(),
          field37264: String.t(),
          field37265: integer,
          field37266: integer,
          field37267: integer,
          field37268: integer,
          field37269: integer,
          field37270: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37271: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37272: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37273: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37274: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field37275: String.t(),
          field37276: boolean
        }
  defstruct [
    :field37252,
    :field37253,
    :field37254,
    :field37255,
    :field37256,
    :field37257,
    :field37258,
    :field37259,
    :field37260,
    :field37261,
    :field37262,
    :field37263,
    :field37264,
    :field37265,
    :field37266,
    :field37267,
    :field37268,
    :field37269,
    :field37270,
    :field37271,
    :field37272,
    :field37273,
    :field37274,
    :field37275,
    :field37276
  ]

  field :field37252, 1, optional: true, type: :string
  field :field37253, 2, optional: true, type: :int64
  field :field37254, 4, optional: true, type: Benchmarks.GoogleMessage4.UnusedEnum, enum: true
  field :field37255, 5, optional: true, type: :bool
  field :field37256, 6, optional: true, type: :bool
  field :field37257, 7, optional: true, type: :bool
  field :field37258, 8, optional: true, type: :string
  field :field37259, 9, optional: true, type: :string
  field :field37260, 10, optional: true, type: :uint32
  field :field37261, 11, optional: true, type: :fixed32
  field :field37262, 12, optional: true, type: :string
  field :field37263, 13, optional: true, type: :string
  field :field37264, 14, optional: true, type: :string
  field :field37265, 15, optional: true, type: :int32
  field :field37266, 16, optional: true, type: :int64
  field :field37267, 17, optional: true, type: :int64
  field :field37268, 18, optional: true, type: :int32
  field :field37269, 19, optional: true, type: :int32
  field :field37270, 20, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37271, 21, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37272, 22, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37273, 23, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37274, 24, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field37275, 25, optional: true, type: :string
  field :field37276, 26, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage4.Message12799 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12809: String.t(),
          field12810: [non_neg_integer],
          field12811: [Benchmarks.GoogleMessage4.Message12776.t()],
          field12812: [integer],
          field12813: [Benchmarks.GoogleMessage4.Message12798.t()],
          field12814: integer,
          field12815: integer,
          field12816: Benchmarks.GoogleMessage4.Message12797.t() | nil
        }
  defstruct [
    :field12809,
    :field12810,
    :field12811,
    :field12812,
    :field12813,
    :field12814,
    :field12815,
    :field12816
  ]

  field :field12809, 1, required: true, type: :string
  field :field12810, 2, repeated: true, type: :fixed64
  field :field12811, 8, repeated: true, type: Benchmarks.GoogleMessage4.Message12776
  field :field12812, 4, repeated: true, type: :int32
  field :field12813, 5, repeated: true, type: Benchmarks.GoogleMessage4.Message12798
  field :field12814, 3, required: true, type: :int32
  field :field12815, 6, optional: true, type: :int32
  field :field12816, 7, optional: true, type: Benchmarks.GoogleMessage4.Message12797
end

defmodule Benchmarks.GoogleMessage4.Message12870 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12879: integer,
          field12880: integer,
          field12881: integer,
          field12882: non_neg_integer,
          field12883: String.t(),
          field12884: non_neg_integer,
          field12885: [non_neg_integer],
          field12886: integer,
          field12887: integer,
          field12888: [Benchmarks.GoogleMessage4.Message12870.t()],
          field12889: integer,
          field12890: non_neg_integer,
          field12891: integer,
          field12892: integer,
          field12893: float | :infinity | :negative_infinity | :nan,
          field12894: Benchmarks.GoogleMessage4.Message12825.t() | nil,
          field12895: float | :infinity | :negative_infinity | :nan,
          field12896: String.t(),
          field12897: Benchmarks.GoogleMessage4.Enum12871.t(),
          field12898: integer
        }
  defstruct [
    :field12879,
    :field12880,
    :field12881,
    :field12882,
    :field12883,
    :field12884,
    :field12885,
    :field12886,
    :field12887,
    :field12888,
    :field12889,
    :field12890,
    :field12891,
    :field12892,
    :field12893,
    :field12894,
    :field12895,
    :field12896,
    :field12897,
    :field12898
  ]

  field :field12879, 1, required: true, type: :int32
  field :field12880, 7, optional: true, type: :int32
  field :field12881, 2, required: true, type: :int32
  field :field12882, 3, optional: true, type: :uint64
  field :field12883, 2001, optional: true, type: :string
  field :field12884, 4, optional: true, type: :fixed64
  field :field12885, 14, repeated: true, type: :fixed64
  field :field12886, 9, optional: true, type: :int32
  field :field12887, 18, optional: true, type: :int64
  field :field12888, 8, repeated: true, type: Benchmarks.GoogleMessage4.Message12870
  field :field12889, 5, optional: true, type: :int32
  field :field12890, 6, optional: true, type: :uint64
  field :field12891, 10, optional: true, type: :int32
  field :field12892, 11, optional: true, type: :int32
  field :field12893, 12, optional: true, type: :double
  field :field12894, 13, optional: true, type: Benchmarks.GoogleMessage4.Message12825
  field :field12895, 15, optional: true, type: :double
  field :field12896, 16, optional: true, type: :string
  field :field12897, 17, optional: true, type: Benchmarks.GoogleMessage4.Enum12871, enum: true
  field :field12898, 19, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage4.Message3804 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3818: integer,
          field3819: boolean,
          field3820: [[Benchmarks.GoogleMessage4.Enum3805.t()]],
          field3821: integer,
          field3822: boolean,
          field3823: integer,
          field3824: Benchmarks.GoogleMessage4.Enum3783.t()
        }
  defstruct [:field3818, :field3819, :field3820, :field3821, :field3822, :field3823, :field3824]

  field :field3818, 1, required: true, type: :int64
  field :field3819, 2, required: true, type: :bool
  field :field3820, 4, repeated: true, type: Benchmarks.GoogleMessage4.Enum3805, enum: true
  field :field3821, 5, optional: true, type: :int32
  field :field3822, 6, optional: true, type: :bool
  field :field3823, 7, optional: true, type: :int64
  field :field3824, 8, optional: true, type: Benchmarks.GoogleMessage4.Enum3783, enum: true
end

defmodule Benchmarks.GoogleMessage4.Message12903 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12905: String.t(),
          field12906: Benchmarks.GoogleMessage4.Message8587.t() | nil,
          field12907: [Benchmarks.GoogleMessage4.Message8590.t()]
        }
  defstruct [:field12905, :field12906, :field12907]

  field :field12905, 1, optional: true, type: :string
  field :field12906, 2, optional: true, type: Benchmarks.GoogleMessage4.Message8587
  field :field12907, 3, repeated: true, type: Benchmarks.GoogleMessage4.Message8590
end

defmodule Benchmarks.GoogleMessage4.Message37326 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37345: String.t(),
          field37346: String.t()
        }
  defstruct [:field37345, :field37346]

  field :field37345, 1, required: true, type: :string
  field :field37346, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message2356.Message2357 do
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
end

defmodule Benchmarks.GoogleMessage4.Message2356.Message2358 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message2356.Message2359 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Benchmarks.GoogleMessage4.Message2356 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field2368: Benchmarks.GoogleMessage4.Message1374.t() | nil,
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
          field2393: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field2394: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field2395: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
          field2396: Benchmarks.GoogleMessage4.UnusedEmptyMessage.t() | nil,
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

  field :field2368, 121, optional: true, type: Benchmarks.GoogleMessage4.Message1374
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
  field :field2393, 60, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field2394, 70, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field2395, 80, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field2396, 90, optional: true, type: Benchmarks.GoogleMessage4.UnusedEmptyMessage
  field :field2397, 100, optional: true, type: :string
  field :field2398, 123, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage4.Message0 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{__pb_extensions__: map}
  defstruct [:__pb_extensions__]

  extensions [{4, 2_147_483_647}]
end

defmodule Benchmarks.GoogleMessage4.Message971 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field972: String.t(),
          field973: integer,
          field974: boolean
        }
  defstruct [:field972, :field973, :field974]

  field :field972, 1, optional: true, type: :string
  field :field973, 2, optional: true, type: :int32
  field :field974, 3, optional: true, type: :bool
end
