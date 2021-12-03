defmodule Benchmarks.GoogleMessage3.Message22853 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field22869: Benchmarks.GoogleMessage3.Enum22854.t(),
          field22870: [non_neg_integer],
          field22871: [float | :infinity | :negative_infinity | :nan],
          field22872: [float | :infinity | :negative_infinity | :nan],
          field22873: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field22869: nil,
            field22870: [],
            field22871: [],
            field22872: [],
            field22873: nil

  field :field22869, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum22854, enum: true
  field :field22870, 2, repeated: true, type: :uint32, packed: true, deprecated: false
  field :field22871, 3, repeated: true, type: :float, packed: true, deprecated: false
  field :field22872, 5, repeated: true, type: :float, packed: true, deprecated: false
  field :field22873, 4, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message24345 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24533: String.t(),
          field24534: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24535: Benchmarks.GoogleMessage3.Message24346.t() | nil,
          field24536: String.t(),
          field24537: String.t(),
          field24538: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24539: String.t(),
          field24540: String.t(),
          field24541: String.t(),
          field24542: String.t(),
          field24543: Benchmarks.GoogleMessage3.Message24316.t() | nil,
          field24544: Benchmarks.GoogleMessage3.Message24376.t() | nil,
          field24545: String.t(),
          field24546: String.t(),
          field24547: String.t(),
          field24548: String.t(),
          field24549: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24550: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24551: [String.t()],
          field24552: String.t(),
          field24553: integer,
          field24554: Benchmarks.GoogleMessage3.Message24379.t() | nil,
          field24555: String.t(),
          field24556: [Benchmarks.GoogleMessage3.Message24356.t()],
          field24557: [Benchmarks.GoogleMessage3.Message24366.t()]
        }

  defstruct field24533: nil,
            field24534: nil,
            field24535: nil,
            field24536: nil,
            field24537: nil,
            field24538: nil,
            field24539: nil,
            field24540: "",
            field24541: nil,
            field24542: nil,
            field24543: nil,
            field24544: nil,
            field24545: nil,
            field24546: nil,
            field24547: nil,
            field24548: nil,
            field24549: nil,
            field24550: nil,
            field24551: [],
            field24552: nil,
            field24553: nil,
            field24554: nil,
            field24555: nil,
            field24556: [],
            field24557: []

  field :field24533, 1, optional: true, type: :string
  field :field24534, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field24535, 2, optional: true, type: Benchmarks.GoogleMessage3.Message24346
  field :field24536, 3, optional: true, type: :string
  field :field24537, 4, optional: true, type: :string
  field :field24538, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field24539, 5, optional: true, type: :string
  field :field24540, 6, required: true, type: :string
  field :field24541, 7, optional: true, type: :string
  field :field24542, 8, optional: true, type: :string
  field :field24543, 9, optional: true, type: Benchmarks.GoogleMessage3.Message24316
  field :field24544, 10, optional: true, type: Benchmarks.GoogleMessage3.Message24376
  field :field24545, 11, optional: true, type: :string
  field :field24546, 19, optional: true, type: :string
  field :field24547, 20, optional: true, type: :string
  field :field24548, 21, optional: true, type: :string
  field :field24549, 12, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24550, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24551, 14, repeated: true, type: :string
  field :field24552, 15, optional: true, type: :string
  field :field24553, 18, optional: true, type: :int32
  field :field24554, 16, optional: true, type: Benchmarks.GoogleMessage3.Message24379
  field :field24555, 17, optional: true, type: :string
  field :field24556, 24, repeated: true, type: Benchmarks.GoogleMessage3.Message24356
  field :field24557, 25, repeated: true, type: Benchmarks.GoogleMessage3.Message24366
end

defmodule Benchmarks.GoogleMessage3.Message24403 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24681: Benchmarks.GoogleMessage3.Message24401.t() | nil,
          field24682: Benchmarks.GoogleMessage3.Message24402.t() | nil
        }

  defstruct field24681: nil,
            field24682: nil

  field :field24681, 1, optional: true, type: Benchmarks.GoogleMessage3.Message24401
  field :field24682, 2, optional: true, type: Benchmarks.GoogleMessage3.Message24402
end

defmodule Benchmarks.GoogleMessage3.Message24391 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24631: String.t(),
          field24632: String.t(),
          field24633: [String.t()],
          field24634: String.t(),
          field24635: [String.t()],
          field24636: [String.t()],
          field24637: String.t(),
          field24638: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24639: String.t(),
          field24640: String.t(),
          field24641: String.t(),
          field24642: String.t(),
          field24643: integer,
          field24644: Benchmarks.GoogleMessage3.Message24379.t() | nil,
          field24645: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24646: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24647: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24648: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24649: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field24650: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24651: String.t(),
          field24652: integer,
          field24653: integer,
          field24654: [String.t()],
          field24655: [String.t()]
        }

  defstruct field24631: nil,
            field24632: nil,
            field24633: [],
            field24634: nil,
            field24635: [],
            field24636: [],
            field24637: nil,
            field24638: nil,
            field24639: nil,
            field24640: nil,
            field24641: nil,
            field24642: nil,
            field24643: nil,
            field24644: nil,
            field24645: [],
            field24646: nil,
            field24647: nil,
            field24648: nil,
            field24649: [],
            field24650: nil,
            field24651: nil,
            field24652: nil,
            field24653: nil,
            field24654: [],
            field24655: []

  field :field24631, 1, optional: true, type: :string
  field :field24632, 2, optional: true, type: :string
  field :field24633, 3, repeated: true, type: :string
  field :field24634, 4, optional: true, type: :string
  field :field24635, 5, repeated: true, type: :string
  field :field24636, 16, repeated: true, type: :string
  field :field24637, 17, optional: true, type: :string
  field :field24638, 25, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24639, 7, optional: true, type: :string
  field :field24640, 18, optional: true, type: :string
  field :field24641, 19, optional: true, type: :string
  field :field24642, 20, optional: true, type: :string
  field :field24643, 24, optional: true, type: :int32
  field :field24644, 8, optional: true, type: Benchmarks.GoogleMessage3.Message24379
  field :field24645, 9, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24646, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24647, 11, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24648, 12, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24649, 13, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24650, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field24651, 21, optional: true, type: :string
  field :field24652, 22, optional: true, type: :int32
  field :field24653, 23, optional: true, type: :int32
  field :field24654, 15, repeated: true, type: :string
  field :field24655, 6, repeated: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message27454 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message27357 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field27410: String.t(),
          field27411: float | :infinity | :negative_infinity | :nan,
          field27412: String.t(),
          field27413: boolean,
          field27414: boolean
        }

  defstruct field27410: nil,
            field27411: nil,
            field27412: nil,
            field27413: nil,
            field27414: nil

  field :field27410, 1, optional: true, type: :string
  field :field27411, 2, optional: true, type: :float
  field :field27412, 3, optional: true, type: :string
  field :field27413, 4, optional: true, type: :bool
  field :field27414, 5, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message27360 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field27426: Benchmarks.GoogleMessage3.Message27358.t() | nil,
          field27427: Benchmarks.GoogleMessage3.Enum27361.t(),
          field27428: Benchmarks.GoogleMessage3.Message27358.t() | nil,
          field27429: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct field27426: nil,
            field27427: nil,
            field27428: nil,
            field27429: []

  field :field27426, 1, optional: true, type: Benchmarks.GoogleMessage3.Message27358
  field :field27427, 2, optional: true, type: Benchmarks.GoogleMessage3.Enum27361, enum: true
  field :field27428, 3, optional: true, type: Benchmarks.GoogleMessage3.Message27358
  field :field27429, 4, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message34387 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34446: String.t(),
          field34447: [Benchmarks.GoogleMessage3.Message34381.t()],
          field34448: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field34449: Benchmarks.GoogleMessage3.Enum34388.t(),
          field34450: integer
        }

  defstruct field34446: nil,
            field34447: [],
            field34448: nil,
            field34449: nil,
            field34450: nil

  field :field34446, 1, optional: true, type: :string
  field :field34447, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message34381
  field :field34448, 3, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field34449, 4, optional: true, type: Benchmarks.GoogleMessage3.Enum34388, enum: true
  field :field34450, 5, optional: true, type: :int64
end

defmodule Benchmarks.GoogleMessage3.Message34621 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34651: float | :infinity | :negative_infinity | :nan,
          field34652: float | :infinity | :negative_infinity | :nan,
          field34653: float | :infinity | :negative_infinity | :nan,
          field34654: float | :infinity | :negative_infinity | :nan,
          field34655: float | :infinity | :negative_infinity | :nan,
          field34656: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34657: Benchmarks.GoogleMessage3.Message34619.t() | nil,
          field34658: String.t(),
          field34659: String.t(),
          field34660: float | :infinity | :negative_infinity | :nan,
          field34661: binary,
          field34662: String.t(),
          field34663: String.t(),
          field34664: String.t(),
          field34665: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field34666: Benchmarks.GoogleMessage3.Message34621.t() | nil,
          field34667: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field34668: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field34651: nil,
            field34652: nil,
            field34653: nil,
            field34654: nil,
            field34655: nil,
            field34656: nil,
            field34657: nil,
            field34658: nil,
            field34659: nil,
            field34660: nil,
            field34661: nil,
            field34662: nil,
            field34663: nil,
            field34664: nil,
            field34665: nil,
            field34666: nil,
            field34667: [],
            field34668: nil

  field :field34651, 1, optional: true, type: :double
  field :field34652, 2, optional: true, type: :double
  field :field34653, 3, optional: true, type: :double
  field :field34654, 4, optional: true, type: :double
  field :field34655, 11, optional: true, type: :double
  field :field34656, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34657, 14, optional: true, type: Benchmarks.GoogleMessage3.Message34619
  field :field34658, 5, optional: true, type: :string
  field :field34659, 9, optional: true, type: :string
  field :field34660, 12, optional: true, type: :double
  field :field34661, 19, optional: true, type: :bytes
  field :field34662, 15, optional: true, type: :string
  field :field34663, 16, optional: true, type: :string
  field :field34664, 17, optional: true, type: :string
  field :field34665, 18, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34666, 20, optional: true, type: Benchmarks.GoogleMessage3.Message34621
  field :field34667, 100, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field34668, 101, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message35476 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35484: String.t(),
          field35485: String.t(),
          field35486: String.t(),
          field35487: Benchmarks.GoogleMessage3.Enum35477.t(),
          field35488: float | :infinity | :negative_infinity | :nan,
          field35489: float | :infinity | :negative_infinity | :nan,
          field35490: float | :infinity | :negative_infinity | :nan,
          field35491: float | :infinity | :negative_infinity | :nan,
          field35492: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field35493: integer,
          field35494: integer,
          field35495: integer,
          field35496: String.t(),
          field35497: String.t()
        }

  defstruct field35484: nil,
            field35485: nil,
            field35486: nil,
            field35487: nil,
            field35488: nil,
            field35489: nil,
            field35490: nil,
            field35491: nil,
            field35492: nil,
            field35493: nil,
            field35494: nil,
            field35495: nil,
            field35496: nil,
            field35497: nil

  field :field35484, 1, optional: true, type: :string
  field :field35485, 2, optional: true, type: :string
  field :field35486, 3, optional: true, type: :string
  field :field35487, 4, optional: true, type: Benchmarks.GoogleMessage3.Enum35477, enum: true
  field :field35488, 5, optional: true, type: :float
  field :field35489, 6, optional: true, type: :float
  field :field35490, 7, optional: true, type: :float
  field :field35491, 8, optional: true, type: :float
  field :field35492, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field35493, 10, optional: true, type: :int32
  field :field35494, 11, optional: true, type: :int32
  field :field35495, 12, optional: true, type: :int32
  field :field35496, 13, optional: true, type: :string
  field :field35497, 14, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message949 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field955: String.t(),
          field956: integer,
          field957: integer,
          field958: Benchmarks.GoogleMessage3.Message730.t() | nil,
          field959: [String.t()],
          field960: String.t(),
          field961: boolean
        }

  defstruct field955: nil,
            field956: nil,
            field957: nil,
            field958: nil,
            field959: [],
            field960: nil,
            field961: nil

  field :field955, 1, optional: true, type: :string
  field :field956, 2, optional: true, type: :int64
  field :field957, 3, optional: true, type: :int64
  field :field958, 4, optional: true, type: Benchmarks.GoogleMessage3.Message730
  field :field959, 5, repeated: true, type: :string
  field :field960, 6, optional: true, type: :string
  field :field961, 7, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message36869 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field36970: integer,
          field36971: integer
        }

  defstruct field36970: nil,
            field36971: nil

  field :field36970, 1, optional: true, type: :int32
  field :field36971, 2, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message33968.Message33969 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message33968 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message33969: [any],
          field33989: [Benchmarks.GoogleMessage3.Message33958.t()],
          field33990: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field33991: boolean,
          field33992: Benchmarks.GoogleMessage3.UnusedEnum.t()
        }

  defstruct message33969: [],
            field33989: [],
            field33990: nil,
            field33991: nil,
            field33992: nil

  field :message33969, 1, repeated: true, type: :group
  field :field33989, 3, repeated: true, type: Benchmarks.GoogleMessage3.Message33958
  field :field33990, 106, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field33991, 108, optional: true, type: :bool
  field :field33992, 107, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message6644 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6701: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6702: String.t(),
          field6703: float | :infinity | :negative_infinity | :nan,
          field6704: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6705: binary,
          field6706: binary,
          field6707: Benchmarks.GoogleMessage3.Message6637.t() | nil,
          field6708: [Benchmarks.GoogleMessage3.Message6126.t()],
          field6709: boolean,
          field6710: Benchmarks.GoogleMessage3.Message6643.t() | nil,
          field6711: String.t(),
          field6712: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6713: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6714: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6715: integer,
          field6716: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field6701: nil,
            field6702: nil,
            field6703: nil,
            field6704: nil,
            field6705: nil,
            field6706: nil,
            field6707: nil,
            field6708: [],
            field6709: nil,
            field6710: nil,
            field6711: nil,
            field6712: nil,
            field6713: nil,
            field6714: nil,
            field6715: nil,
            field6716: nil

  field :field6701, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6702, 1, optional: true, type: :string
  field :field6703, 2, optional: true, type: :double
  field :field6704, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6705, 3, optional: true, type: :bytes
  field :field6706, 19, optional: true, type: :bytes
  field :field6707, 4, optional: true, type: Benchmarks.GoogleMessage3.Message6637
  field :field6708, 18, repeated: true, type: Benchmarks.GoogleMessage3.Message6126
  field :field6709, 6, optional: true, type: :bool
  field :field6710, 10, optional: true, type: Benchmarks.GoogleMessage3.Message6643
  field :field6711, 12, optional: true, type: :string
  field :field6712, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6713, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6714, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6715, 17, optional: true, type: :int32
  field :field6716, 20, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message18831.Message18832.Message18833 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18843: non_neg_integer,
          field18844: String.t(),
          field18845: float | :infinity | :negative_infinity | :nan,
          field18846: integer,
          field18847: boolean
        }

  defstruct field18843: 0,
            field18844: nil,
            field18845: nil,
            field18846: nil,
            field18847: nil

  field :field18843, 7, required: true, type: :uint64
  field :field18844, 8, optional: true, type: :string
  field :field18845, 10, optional: true, type: :float
  field :field18846, 12, optional: true, type: :int32
  field :field18847, 13, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message18831.Message18832 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18836: integer,
          field18837: String.t(),
          field18838: float | :infinity | :negative_infinity | :nan,
          field18839: float | :infinity | :negative_infinity | :nan,
          field18840: integer,
          field18841: [non_neg_integer],
          message18833: [any]
        }

  defstruct field18836: nil,
            field18837: nil,
            field18838: nil,
            field18839: nil,
            field18840: nil,
            field18841: [],
            message18833: []

  field :field18836, 2, optional: true, type: :int32
  field :field18837, 5, optional: true, type: :string
  field :field18838, 3, optional: true, type: :float
  field :field18839, 9, optional: true, type: :float
  field :field18840, 11, optional: true, type: :int32
  field :field18841, 4, repeated: true, type: :uint64
  field :message18833, 6, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message18831 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message18832: [any]
        }

  defstruct message18832: []

  field :message18832, 1, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message13090 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13141: Benchmarks.GoogleMessage3.Message13083.t() | nil,
          field13142: Benchmarks.GoogleMessage3.Message13088.t() | nil
        }

  defstruct field13141: nil,
            field13142: nil

  field :field13141, 1, optional: true, type: Benchmarks.GoogleMessage3.Message13083
  field :field13142, 2, optional: true, type: Benchmarks.GoogleMessage3.Message13088
end

defmodule Benchmarks.GoogleMessage3.Message11874 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field11888: Benchmarks.GoogleMessage3.Message10391.t() | nil,
          field11889: String.t(),
          field11890: Benchmarks.GoogleMessage3.Message11873.t() | nil,
          field11891: boolean,
          __pb_extensions__: map
        }

  defstruct field11888: nil,
            field11889: nil,
            field11890: nil,
            field11891: nil,
            __pb_extensions__: nil

  field :field11888, 3, optional: true, type: Benchmarks.GoogleMessage3.Message10391
  field :field11889, 4, optional: true, type: :string
  field :field11890, 6, optional: true, type: Benchmarks.GoogleMessage3.Message11873
  field :field11891, 7, optional: true, type: :bool

  extensions [{1, 2}, {2, 3}, {5, 6}]
end

defmodule Benchmarks.GoogleMessage3.Message4144.Message4145 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field4165: Benchmarks.GoogleMessage3.Enum4146.t(),
          field4166: integer,
          field4167: Benchmarks.GoogleMessage3.Enum4160.t(),
          field4168: binary,
          field4169: Benchmarks.GoogleMessage3.Enum4152.t(),
          field4170: String.t()
        }

  defstruct field4165: :ENUM_VALUE4147,
            field4166: 0,
            field4167: nil,
            field4168: nil,
            field4169: nil,
            field4170: nil

  field :field4165, 2, required: true, type: Benchmarks.GoogleMessage3.Enum4146, enum: true
  field :field4166, 3, required: true, type: :int32
  field :field4167, 9, optional: true, type: Benchmarks.GoogleMessage3.Enum4160, enum: true
  field :field4168, 4, optional: true, type: :bytes
  field :field4169, 5, optional: true, type: Benchmarks.GoogleMessage3.Enum4152, enum: true
  field :field4170, 6, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message4144 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message4145: [any]
        }

  defstruct message4145: []

  field :message4145, 1, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message35573.Message35574 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Benchmarks.GoogleMessage3.Message35573.Message35575.Message35576 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35747: non_neg_integer,
          field35748: integer,
          field35749: integer,
          field35750: integer,
          field35751: non_neg_integer,
          field35752: integer,
          field35753: integer,
          field35754: integer,
          field35755: binary,
          field35756: integer,
          field35757: String.t(),
          field35758: non_neg_integer,
          field35759: integer,
          field35760: integer,
          field35761: integer,
          field35762: integer,
          field35763: integer,
          field35764: integer,
          field35765: binary,
          field35766: String.t(),
          field35767: integer,
          field35768: [integer],
          field35769: [integer],
          field35770: integer,
          field35771: Benchmarks.GoogleMessage3.Message0.t() | nil
        }

  defstruct field35747: nil,
            field35748: nil,
            field35749: nil,
            field35750: nil,
            field35751: nil,
            field35752: nil,
            field35753: nil,
            field35754: nil,
            field35755: nil,
            field35756: nil,
            field35757: nil,
            field35758: nil,
            field35759: nil,
            field35760: nil,
            field35761: nil,
            field35762: nil,
            field35763: nil,
            field35764: nil,
            field35765: nil,
            field35766: nil,
            field35767: nil,
            field35768: [],
            field35769: [],
            field35770: nil,
            field35771: nil

  field :field35747, 5, optional: true, type: :fixed64
  field :field35748, 6, optional: true, type: :int32
  field :field35749, 49, optional: true, type: :int32
  field :field35750, 7, optional: true, type: :int32
  field :field35751, 59, optional: true, type: :uint32
  field :field35752, 14, optional: true, type: :int32
  field :field35753, 15, optional: true, type: :int32
  field :field35754, 35, optional: true, type: :int32
  field :field35755, 53, optional: true, type: :bytes
  field :field35756, 8, optional: true, type: :int32
  field :field35757, 9, optional: true, type: :string
  field :field35758, 10, optional: true, type: :fixed64
  field :field35759, 11, optional: true, type: :int32
  field :field35760, 12, optional: true, type: :int32
  field :field35761, 41, optional: true, type: :int32
  field :field35762, 30, optional: true, type: :int32
  field :field35763, 31, optional: true, type: :int32
  field :field35764, 13, optional: true, type: :int32
  field :field35765, 39, optional: true, type: :bytes
  field :field35766, 29, optional: true, type: :string
  field :field35767, 42, optional: true, type: :int32
  field :field35768, 32, repeated: true, type: :int32
  field :field35769, 51, repeated: true, type: :int32
  field :field35770, 54, optional: true, type: :int64
  field :field35771, 55, optional: true, type: Benchmarks.GoogleMessage3.Message0
end

defmodule Benchmarks.GoogleMessage3.Message35573.Message35575 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35709: integer,
          field35710: String.t(),
          field35711: String.t(),
          field35712: integer,
          field35713: integer,
          field35714: integer,
          field35715: boolean,
          field35716: integer,
          field35717: integer,
          field35718: boolean,
          field35719: non_neg_integer,
          field35720: binary,
          field35721: integer,
          field35722: non_neg_integer,
          field35723: boolean,
          field35724: integer,
          field35725: integer,
          field35726: boolean,
          field35727: [integer],
          field35728: [integer],
          field35729: float | :infinity | :negative_infinity | :nan,
          field35730: float | :infinity | :negative_infinity | :nan,
          field35731: integer,
          field35732: [non_neg_integer],
          field35733: [non_neg_integer],
          field35734: integer,
          field35735: integer,
          field35736: integer,
          field35737: integer,
          field35738: boolean,
          field35739: boolean,
          field35740: integer,
          field35741: integer,
          field35742: String.t(),
          field35743: non_neg_integer,
          field35744: [binary],
          field35745: Benchmarks.GoogleMessage3.Message0.t() | nil,
          message35576: any
        }

  defstruct field35709: nil,
            field35710: nil,
            field35711: nil,
            field35712: nil,
            field35713: nil,
            field35714: nil,
            field35715: nil,
            field35716: nil,
            field35717: nil,
            field35718: nil,
            field35719: nil,
            field35720: nil,
            field35721: nil,
            field35722: nil,
            field35723: nil,
            field35724: nil,
            field35725: nil,
            field35726: nil,
            field35727: [],
            field35728: [],
            field35729: nil,
            field35730: nil,
            field35731: nil,
            field35732: [],
            field35733: [],
            field35734: nil,
            field35735: nil,
            field35736: nil,
            field35737: nil,
            field35738: nil,
            field35739: nil,
            field35740: nil,
            field35741: nil,
            field35742: nil,
            field35743: nil,
            field35744: [],
            field35745: nil,
            message35576: nil

  field :field35709, 2, optional: true, type: :int64
  field :field35710, 3, optional: true, type: :string
  field :field35711, 19, optional: true, type: :string
  field :field35712, 20, optional: true, type: :int32
  field :field35713, 21, optional: true, type: :int32
  field :field35714, 22, optional: true, type: :int32
  field :field35715, 23, optional: true, type: :bool
  field :field35716, 47, optional: true, type: :int32
  field :field35717, 48, optional: true, type: :int32
  field :field35718, 24, optional: true, type: :bool
  field :field35719, 25, optional: true, type: :fixed64
  field :field35720, 52, optional: true, type: :bytes
  field :field35721, 18, optional: true, type: :int32
  field :field35722, 43, optional: true, type: :fixed32
  field :field35723, 26, optional: true, type: :bool
  field :field35724, 27, optional: true, type: :int32
  field :field35725, 17, optional: true, type: :int32
  field :field35726, 45, optional: true, type: :bool
  field :field35727, 33, repeated: true, type: :int32
  field :field35728, 58, repeated: true, type: :int32
  field :field35729, 34, optional: true, type: :float
  field :field35730, 1009, optional: true, type: :float
  field :field35731, 28, optional: true, type: :int32
  field :field35732, 1001, repeated: true, type: :fixed64
  field :field35733, 1002, repeated: true, type: :fixed64
  field :field35734, 44, optional: true, type: :int32
  field :field35735, 50, optional: true, type: :int32
  field :field35736, 36, optional: true, type: :int32
  field :field35737, 40, optional: true, type: :int32
  field :field35738, 1016, optional: true, type: :bool
  field :field35739, 1010, optional: true, type: :bool
  field :field35740, 37, optional: true, type: :int32
  field :field35741, 38, optional: true, type: :int32
  field :field35742, 46, optional: true, type: :string
  field :field35743, 60, optional: true, type: :uint32
  field :field35744, 56, repeated: true, type: :bytes
  field :field35745, 57, optional: true, type: Benchmarks.GoogleMessage3.Message0
  field :message35576, 4, required: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message35573 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35695: non_neg_integer,
          field35696: String.t(),
          field35697: String.t(),
          field35698: integer,
          message35574: [any],
          field35700: integer,
          field35701: integer,
          field35702: integer,
          field35703: integer,
          field35704: integer,
          message35575: [any]
        }

  defstruct field35695: nil,
            field35696: nil,
            field35697: nil,
            field35698: nil,
            message35574: [],
            field35700: nil,
            field35701: nil,
            field35702: nil,
            field35703: nil,
            field35704: nil,
            message35575: []

  field :field35695, 16, optional: true, type: :fixed64
  field :field35696, 1000, optional: true, type: :string
  field :field35697, 1004, optional: true, type: :string
  field :field35698, 1003, optional: true, type: :int32
  field :message35574, 1012, repeated: true, type: :group
  field :field35700, 1011, optional: true, type: :int64
  field :field35701, 1005, optional: true, type: :int64
  field :field35702, 1006, optional: true, type: :int64
  field :field35703, 1007, optional: true, type: :int64
  field :field35704, 1008, optional: true, type: :int64
  field :message35575, 1, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message36858.Message36859 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field36968: Benchmarks.GoogleMessage3.Enum36860.t(),
          field36969: float | :infinity | :negative_infinity | :nan
        }

  defstruct field36968: :ENUM_VALUE36861,
            field36969: nil

  field :field36968, 9, required: true, type: Benchmarks.GoogleMessage3.Enum36860, enum: true
  field :field36969, 10, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message36858 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field36956: [integer],
          field36957: [String.t()],
          field36958: [String.t()],
          field36959: integer,
          field36960: integer,
          field36961: integer,
          field36962: String.t(),
          field36963: boolean,
          field36964: boolean,
          field36965: integer,
          field36966: Benchmarks.GoogleMessage3.Message35506.t() | nil,
          message36859: [any]
        }

  defstruct field36956: [],
            field36957: [],
            field36958: [],
            field36959: nil,
            field36960: nil,
            field36961: nil,
            field36962: nil,
            field36963: nil,
            field36964: nil,
            field36965: nil,
            field36966: nil,
            message36859: []

  field :field36956, 1, repeated: true, type: :int32
  field :field36957, 2, repeated: true, type: :string
  field :field36958, 12, repeated: true, type: :string
  field :field36959, 3, optional: true, type: :int32
  field :field36960, 4, optional: true, type: :int32
  field :field36961, 14, optional: true, type: :int32
  field :field36962, 11, optional: true, type: :string
  field :field36963, 5, optional: true, type: :bool
  field :field36964, 13, optional: true, type: :bool
  field :field36965, 6, optional: true, type: :int64
  field :field36966, 7, optional: true, type: Benchmarks.GoogleMessage3.Message35506
  field :message36859, 8, repeated: true, type: :group
end

defmodule Benchmarks.GoogleMessage3.Message13174 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13237: integer,
          field13238: integer,
          field13239: integer,
          field13240: integer,
          field13241: float | :infinity | :negative_infinity | :nan,
          field13242: float | :infinity | :negative_infinity | :nan,
          field13243: integer,
          field13244: integer,
          field13245: float | :infinity | :negative_infinity | :nan,
          field13246: integer,
          field13247: float | :infinity | :negative_infinity | :nan,
          field13248: integer,
          field13249: Benchmarks.GoogleMessage3.Message13151.t() | nil,
          field13250: integer,
          field13251: float | :infinity | :negative_infinity | :nan,
          field13252: float | :infinity | :negative_infinity | :nan,
          field13253: float | :infinity | :negative_infinity | :nan,
          field13254: float | :infinity | :negative_infinity | :nan,
          field13255: float | :infinity | :negative_infinity | :nan,
          field13256: float | :infinity | :negative_infinity | :nan,
          field13257: integer
        }

  defstruct field13237: 0,
            field13238: nil,
            field13239: 0,
            field13240: nil,
            field13241: nil,
            field13242: nil,
            field13243: nil,
            field13244: nil,
            field13245: nil,
            field13246: nil,
            field13247: nil,
            field13248: nil,
            field13249: nil,
            field13250: nil,
            field13251: nil,
            field13252: nil,
            field13253: nil,
            field13254: nil,
            field13255: nil,
            field13256: nil,
            field13257: nil

  field :field13237, 6, required: true, type: :int32
  field :field13238, 3, optional: true, type: :int32
  field :field13239, 4, required: true, type: :int32
  field :field13240, 8, optional: true, type: :int32
  field :field13241, 5, optional: true, type: :double
  field :field13242, 7, optional: true, type: :double
  field :field13243, 17, optional: true, type: :int32
  field :field13244, 19, optional: true, type: :int32
  field :field13245, 20, optional: true, type: :double
  field :field13246, 9, optional: true, type: :int32
  field :field13247, 10, optional: true, type: :double
  field :field13248, 11, optional: true, type: :int32
  field :field13249, 21, optional: true, type: Benchmarks.GoogleMessage3.Message13151
  field :field13250, 1, optional: true, type: :int32
  field :field13251, 2, optional: true, type: :double
  field :field13252, 15, optional: true, type: :double
  field :field13253, 16, optional: true, type: :double
  field :field13254, 12, optional: true, type: :double
  field :field13255, 13, optional: true, type: :double
  field :field13256, 14, optional: true, type: :double
  field :field13257, 18, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message18283 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18478: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18479: integer,
          field18480: integer,
          field18481: integer,
          field18482: integer,
          field18483: integer,
          field18484: integer,
          field18485: integer,
          field18486: integer,
          field18487: integer,
          field18488: integer,
          field18489: integer,
          field18490: integer,
          field18491: boolean,
          field18492: boolean,
          field18493: integer,
          field18494: integer,
          field18495: integer,
          field18496: integer,
          field18497: float | :infinity | :negative_infinity | :nan,
          field18498: integer,
          field18499: String.t(),
          field18500: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18501: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18502: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18503: Benchmarks.GoogleMessage3.Message18253.t() | nil,
          field18504: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18505: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18506: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18507: [integer],
          field18508: [integer],
          field18509: [String.t()],
          field18510: binary,
          field18511: integer,
          field18512: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18513: String.t(),
          field18514: float | :infinity | :negative_infinity | :nan,
          field18515: float | :infinity | :negative_infinity | :nan,
          field18516: float | :infinity | :negative_infinity | :nan,
          field18517: float | :infinity | :negative_infinity | :nan,
          field18518: integer,
          field18519: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field18520: integer,
          field18521: integer,
          field18522: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18523: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18524: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18525: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18526: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18527: integer,
          field18528: integer,
          field18529: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18530: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18531: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18532: non_neg_integer,
          field18533: integer,
          field18534: integer,
          field18535: integer,
          field18536: non_neg_integer,
          field18537: non_neg_integer,
          field18538: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18539: integer,
          field18540: integer,
          field18541: Benchmarks.GoogleMessage3.Message16816.t() | nil,
          field18542: Benchmarks.GoogleMessage3.Message16685.t() | nil,
          field18543: integer,
          field18544: integer,
          field18545: integer,
          field18546: integer,
          field18547: integer,
          field18548: integer,
          field18549: float | :infinity | :negative_infinity | :nan,
          field18550: Benchmarks.GoogleMessage3.Message0.t() | nil,
          field18551: [integer],
          field18552: integer,
          field18553: [non_neg_integer],
          field18554: integer,
          field18555: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18556: boolean,
          field18557: non_neg_integer,
          field18558: integer,
          field18559: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18560: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18561: integer,
          field18562: [non_neg_integer],
          field18563: [String.t()],
          field18564: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18565: integer,
          field18566: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18567: integer,
          field18568: non_neg_integer,
          field18569: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18570: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18571: non_neg_integer,
          field18572: non_neg_integer,
          field18573: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18574: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18575: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18576: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18577: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18578: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18579: integer,
          field18580: float | :infinity | :negative_infinity | :nan,
          field18581: boolean,
          __pb_extensions__: map
        }

  defstruct field18478: nil,
            field18479: nil,
            field18480: nil,
            field18481: nil,
            field18482: nil,
            field18483: nil,
            field18484: nil,
            field18485: nil,
            field18486: nil,
            field18487: nil,
            field18488: nil,
            field18489: nil,
            field18490: nil,
            field18491: nil,
            field18492: nil,
            field18493: nil,
            field18494: nil,
            field18495: nil,
            field18496: nil,
            field18497: nil,
            field18498: nil,
            field18499: nil,
            field18500: nil,
            field18501: nil,
            field18502: nil,
            field18503: nil,
            field18504: nil,
            field18505: nil,
            field18506: nil,
            field18507: [],
            field18508: [],
            field18509: [],
            field18510: nil,
            field18511: nil,
            field18512: nil,
            field18513: nil,
            field18514: nil,
            field18515: nil,
            field18516: nil,
            field18517: nil,
            field18518: nil,
            field18519: [],
            field18520: nil,
            field18521: nil,
            field18522: nil,
            field18523: nil,
            field18524: nil,
            field18525: nil,
            field18526: nil,
            field18527: nil,
            field18528: nil,
            field18529: nil,
            field18530: nil,
            field18531: nil,
            field18532: nil,
            field18533: nil,
            field18534: nil,
            field18535: nil,
            field18536: nil,
            field18537: nil,
            field18538: nil,
            field18539: nil,
            field18540: nil,
            field18541: nil,
            field18542: nil,
            field18543: nil,
            field18544: nil,
            field18545: nil,
            field18546: nil,
            field18547: nil,
            field18548: nil,
            field18549: nil,
            field18550: nil,
            field18551: [],
            field18552: nil,
            field18553: [],
            field18554: nil,
            field18555: nil,
            field18556: nil,
            field18557: nil,
            field18558: nil,
            field18559: nil,
            field18560: nil,
            field18561: nil,
            field18562: [],
            field18563: [],
            field18564: nil,
            field18565: nil,
            field18566: nil,
            field18567: nil,
            field18568: nil,
            field18569: nil,
            field18570: nil,
            field18571: nil,
            field18572: nil,
            field18573: nil,
            field18574: nil,
            field18575: nil,
            field18576: nil,
            field18577: nil,
            field18578: nil,
            field18579: nil,
            field18580: nil,
            field18581: nil,
            __pb_extensions__: nil

  field :field18478, 1, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18479, 4, optional: true, type: :int32
  field :field18480, 106, optional: true, type: :int32
  field :field18481, 107, optional: true, type: :int32
  field :field18482, 108, optional: true, type: :int32
  field :field18483, 109, optional: true, type: :int32
  field :field18484, 105, optional: true, type: :int32
  field :field18485, 113, optional: true, type: :int32
  field :field18486, 114, optional: true, type: :int32
  field :field18487, 124, optional: true, type: :int32
  field :field18488, 125, optional: true, type: :int32
  field :field18489, 128, optional: true, type: :int32
  field :field18490, 135, optional: true, type: :int32
  field :field18491, 166, optional: true, type: :bool
  field :field18492, 136, optional: true, type: :bool
  field :field18493, 140, optional: true, type: :int32
  field :field18494, 171, optional: true, type: :int32
  field :field18495, 148, optional: true, type: :int32
  field :field18496, 145, optional: true, type: :int32
  field :field18497, 117, optional: true, type: :float
  field :field18498, 146, optional: true, type: :int32
  field :field18499, 3, optional: true, type: :string
  field :field18500, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18501, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18502, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18503, 155, optional: true, type: Benchmarks.GoogleMessage3.Message18253
  field :field18504, 184, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18505, 163, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18506, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18507, 20, repeated: true, type: :int32
  field :field18508, 7, repeated: true, type: :int32
  field :field18509, 194, repeated: true, type: :string
  field :field18510, 30, optional: true, type: :bytes
  field :field18511, 31, optional: true, type: :int32
  field :field18512, 178, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18513, 8, optional: true, type: :string
  field :field18514, 2, optional: true, type: :float
  field :field18515, 100, optional: true, type: :float
  field :field18516, 101, optional: true, type: :float
  field :field18517, 102, optional: true, type: :float
  field :field18518, 103, optional: true, type: :int32
  field :field18519, 104, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18520, 110, optional: true, type: :int32
  field :field18521, 112, optional: true, type: :int32
  field :field18522, 111, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18523, 115, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18524, 119, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18525, 127, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18526, 185, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18527, 120, optional: true, type: :int32
  field :field18528, 132, optional: true, type: :int32
  field :field18529, 126, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18530, 129, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18531, 131, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18532, 150, optional: true, type: :fixed64
  field :field18533, 133, optional: true, type: :int32
  field :field18534, 134, optional: true, type: :int32
  field :field18535, 139, optional: true, type: :int32
  field :field18536, 137, optional: true, type: :fixed64
  field :field18537, 138, optional: true, type: :fixed64
  field :field18538, 141, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18539, 142, optional: true, type: :int32
  field :field18540, 181, optional: true, type: :int32
  field :field18541, 143, optional: true, type: Benchmarks.GoogleMessage3.Message16816
  field :field18542, 154, optional: true, type: Benchmarks.GoogleMessage3.Message16685
  field :field18543, 144, optional: true, type: :int32
  field :field18544, 147, optional: true, type: :int64
  field :field18545, 149, optional: true, type: :int64
  field :field18546, 151, optional: true, type: :int32
  field :field18547, 152, optional: true, type: :int32
  field :field18548, 153, optional: true, type: :int32
  field :field18549, 161, optional: true, type: :float
  field :field18550, 123, optional: true, type: Benchmarks.GoogleMessage3.Message0
  field :field18551, 156, repeated: true, type: :int64
  field :field18552, 157, optional: true, type: :int32
  field :field18553, 188, repeated: true, type: :fixed64
  field :field18554, 158, optional: true, type: :int32
  field :field18555, 159, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18556, 160, optional: true, type: :bool
  field :field18557, 162, optional: true, type: :uint64
  field :field18558, 164, optional: true, type: :int32
  field :field18559, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18560, 167, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18561, 168, optional: true, type: :int32
  field :field18562, 169, repeated: true, type: :fixed64
  field :field18563, 170, repeated: true, type: :string
  field :field18564, 172, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18565, 173, optional: true, type: :int64
  field :field18566, 174, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18567, 175, optional: true, type: :int64
  field :field18568, 189, optional: true, type: :uint32
  field :field18569, 176, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18570, 177, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18571, 179, optional: true, type: :uint32
  field :field18572, 180, optional: true, type: :uint32
  field :field18573, 182, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18574, 183, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18575, 121, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18576, 186, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18577, 187, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18578, 190, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field18579, 191, optional: true, type: :int32
  field :field18580, 192, optional: true, type: :float
  field :field18581, 193, optional: true, type: :bool

  extensions [{116, 117}, {118, 119}, {130, 131}, {165, 166}]
end

defmodule Benchmarks.GoogleMessage3.Message13169 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13223: [Benchmarks.GoogleMessage3.Message13168.t()],
          field13224: Benchmarks.GoogleMessage3.Message13167.t() | nil,
          field13225: String.t()
        }

  defstruct field13223: [],
            field13224: nil,
            field13225: nil

  field :field13223, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message13168
  field :field13224, 2, required: true, type: Benchmarks.GoogleMessage3.Message13167
  field :field13225, 3, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message19255 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field19257: String.t()
        }

  defstruct field19257: nil

  field :field19257, 1, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message35542 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35543: boolean,
          field35544: boolean,
          field35545: boolean
        }

  defstruct field35543: nil,
            field35544: nil,
            field35545: nil

  field :field35543, 1, optional: true, type: :bool
  field :field35544, 2, optional: true, type: :bool
  field :field35545, 3, optional: true, type: :bool
end

defmodule Benchmarks.GoogleMessage3.Message3901 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3990: integer,
          field3991: integer,
          field3992: integer,
          field3993: integer,
          field3994: integer,
          field3995: integer,
          field3996: integer,
          field3997: integer,
          field3998: integer,
          field3999: integer,
          field4000: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field4001: integer
        }

  defstruct field3990: nil,
            field3991: nil,
            field3992: nil,
            field3993: nil,
            field3994: nil,
            field3995: nil,
            field3996: nil,
            field3997: nil,
            field3998: nil,
            field3999: nil,
            field4000: nil,
            field4001: nil

  field :field3990, 1, optional: true, type: :int32
  field :field3991, 2, optional: true, type: :int32
  field :field3992, 3, optional: true, type: :int32
  field :field3993, 4, optional: true, type: :int32
  field :field3994, 7, optional: true, type: :int32
  field :field3995, 8, optional: true, type: :int32
  field :field3996, 9, optional: true, type: :int32
  field :field3997, 10, optional: true, type: :int32
  field :field3998, 11, optional: true, type: :int32
  field :field3999, 12, optional: true, type: :int32
  field :field4000, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field4001, 5, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Benchmarks.GoogleMessage3.Message0, :"Message34621.field34669", 17_562_023,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message34621
end
