defmodule Benchmarks.GoogleMessage3.Message34390 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34452: [Benchmarks.GoogleMessage3.Message34387.t()]
        }

  defstruct field34452: []

  field :field34452, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message34387
end
defmodule Benchmarks.GoogleMessage3.Message34624 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34683: Benchmarks.GoogleMessage3.Message34621.t() | nil,
          field34684: Benchmarks.GoogleMessage3.Message34621.t() | nil
        }

  defstruct field34683: nil,
            field34684: nil

  field :field34683, 1, optional: true, type: Benchmarks.GoogleMessage3.Message34621
  field :field34684, 2, optional: true, type: Benchmarks.GoogleMessage3.Message34621
end
defmodule Benchmarks.GoogleMessage3.Message34791.Message34792 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34808: String.t(),
          field34809: String.t()
        }

  defstruct field34808: "",
            field34809: nil

  field :field34808, 3, required: true, type: :string
  field :field34809, 4, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message34791 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field34793: non_neg_integer,
          message34792: [any],
          field34795: integer,
          field34796: integer,
          field34797: integer,
          field34798: integer,
          field34799: integer,
          field34800: integer,
          field34801: boolean,
          field34802: float | :infinity | :negative_infinity | :nan,
          field34803: integer,
          field34804: String.t(),
          field34805: integer,
          field34806: [non_neg_integer]
        }

  defstruct field34793: nil,
            message34792: [],
            field34795: nil,
            field34796: nil,
            field34797: nil,
            field34798: nil,
            field34799: nil,
            field34800: nil,
            field34801: nil,
            field34802: nil,
            field34803: nil,
            field34804: nil,
            field34805: nil,
            field34806: []

  field :field34793, 1, optional: true, type: :fixed64
  field :message34792, 2, repeated: true, type: :group
  field :field34795, 5, optional: true, type: :int32
  field :field34796, 6, optional: true, type: :int32
  field :field34797, 7, optional: true, type: :int32
  field :field34798, 8, optional: true, type: :int32
  field :field34799, 9, optional: true, type: :int32
  field :field34800, 10, optional: true, type: :int32
  field :field34801, 11, optional: true, type: :bool
  field :field34802, 12, optional: true, type: :float
  field :field34803, 13, optional: true, type: :int32
  field :field34804, 14, optional: true, type: :string
  field :field34805, 15, optional: true, type: :int64
  field :field34806, 17, repeated: true, type: :fixed64, packed: true
end
defmodule Benchmarks.GoogleMessage3.Message35483 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35499: integer,
          field35500: String.t(),
          field35501: String.t(),
          field35502: String.t(),
          field35503: [Benchmarks.GoogleMessage3.Message35476.t()],
          field35504: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field35499: nil,
            field35500: nil,
            field35501: nil,
            field35502: nil,
            field35503: [],
            field35504: nil

  field :field35499, 1, optional: true, type: :int32
  field :field35500, 2, optional: true, type: :string
  field :field35501, 3, optional: true, type: :string
  field :field35502, 4, optional: true, type: :string
  field :field35503, 5, repeated: true, type: Benchmarks.GoogleMessage3.Message35476
  field :field35504, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end
defmodule Benchmarks.GoogleMessage3.Message35807 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field35810: integer,
          field35811: integer,
          field35812: integer,
          field35813: integer,
          field35814: integer,
          field35815: integer,
          field35816: integer,
          field35817: integer
        }

  defstruct field35810: nil,
            field35811: nil,
            field35812: nil,
            field35813: nil,
            field35814: nil,
            field35815: nil,
            field35816: nil,
            field35817: nil

  field :field35810, 1, optional: true, type: :int32
  field :field35811, 2, optional: true, type: :int32
  field :field35812, 3, optional: true, type: :int32
  field :field35813, 4, optional: true, type: :int32
  field :field35814, 5, optional: true, type: :int32
  field :field35815, 6, optional: true, type: :int32
  field :field35816, 7, optional: true, type: :int32
  field :field35817, 8, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message37487 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37501: binary,
          field37502: boolean
        }

  defstruct field37501: nil,
            field37502: nil

  field :field37501, 2, optional: true, type: :bytes
  field :field37502, 3, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage3.Message13062 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13075: integer,
          field13076: String.t(),
          field13077: integer,
          field13078: String.t(),
          field13079: integer
        }

  defstruct field13075: nil,
            field13076: nil,
            field13077: nil,
            field13078: nil,
            field13079: nil

  field :field13075, 1, optional: true, type: :int64
  field :field13076, 2, optional: true, type: :string
  field :field13077, 3, optional: true, type: :int32
  field :field13078, 4, optional: true, type: :string
  field :field13079, 5, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message952 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field963: [Benchmarks.GoogleMessage3.Message949.t()]
        }

  defstruct field963: []

  field :field963, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message949
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36877 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37044: String.t(),
          field37045: integer,
          field37046: binary,
          field37047: integer,
          field37048: integer
        }

  defstruct field37044: "",
            field37045: nil,
            field37046: nil,
            field37047: nil,
            field37048: nil

  field :field37044, 112, required: true, type: :string
  field :field37045, 113, optional: true, type: :int32
  field :field37046, 114, optional: true, type: :bytes
  field :field37047, 115, optional: true, type: :int32
  field :field37048, 157, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36878 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36879 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37050: String.t(),
          field37051: integer
        }

  defstruct field37050: "",
            field37051: nil

  field :field37050, 56, required: true, type: :string
  field :field37051, 69, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36880 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36881 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36882 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36883 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36884 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36885 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36886 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36887 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36888 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37089: non_neg_integer,
          field37090: boolean,
          field37091: non_neg_integer,
          field37092: float | :infinity | :negative_infinity | :nan,
          field37093: non_neg_integer,
          field37094: binary
        }

  defstruct field37089: nil,
            field37090: nil,
            field37091: nil,
            field37092: nil,
            field37093: nil,
            field37094: nil

  field :field37089, 75, optional: true, type: :uint64
  field :field37090, 76, optional: true, type: :bool
  field :field37091, 165, optional: true, type: :uint64
  field :field37092, 166, optional: true, type: :double
  field :field37093, 109, optional: true, type: :uint64
  field :field37094, 122, optional: true, type: :bytes
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36889 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37095: integer,
          field37096: String.t(),
          field37097: integer,
          field37098: boolean,
          field37099: integer,
          field37100: integer,
          field37101: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37102: Benchmarks.GoogleMessage3.Message13174.t() | nil,
          field37103: Benchmarks.GoogleMessage3.Message13169.t() | nil,
          field37104: non_neg_integer,
          field37105: [Benchmarks.GoogleMessage3.Enum36890.t()],
          field37106: boolean,
          field37107: boolean,
          field37108: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37109: float | :infinity | :negative_infinity | :nan,
          field37110: float | :infinity | :negative_infinity | :nan,
          field37111: boolean,
          field37112: integer,
          field37113: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37114: boolean,
          field37115: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37116: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field37117: [Benchmarks.GoogleMessage3.UnusedEnum.t()],
          field37118: integer,
          field37119: [String.t()]
        }

  defstruct field37095: nil,
            field37096: nil,
            field37097: nil,
            field37098: nil,
            field37099: nil,
            field37100: nil,
            field37101: nil,
            field37102: nil,
            field37103: nil,
            field37104: nil,
            field37105: [],
            field37106: nil,
            field37107: nil,
            field37108: nil,
            field37109: nil,
            field37110: nil,
            field37111: nil,
            field37112: nil,
            field37113: nil,
            field37114: nil,
            field37115: nil,
            field37116: nil,
            field37117: [],
            field37118: nil,
            field37119: []

  field :field37095, 117, optional: true, type: :int64
  field :field37096, 145, optional: true, type: :string
  field :field37097, 123, optional: true, type: :int32
  field :field37098, 163, optional: true, type: :bool
  field :field37099, 164, optional: true, type: :int32
  field :field37100, 149, optional: true, type: :int32
  field :field37101, 129, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37102, 124, optional: true, type: Benchmarks.GoogleMessage3.Message13174
  field :field37103, 128, optional: true, type: Benchmarks.GoogleMessage3.Message13169
  field :field37104, 132, optional: true, type: :uint64
  field :field37105, 131, repeated: true, type: Benchmarks.GoogleMessage3.Enum36890, enum: true
  field :field37106, 134, optional: true, type: :bool
  field :field37107, 140, optional: true, type: :bool
  field :field37108, 135, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37109, 136, optional: true, type: :float
  field :field37110, 156, optional: true, type: :float
  field :field37111, 142, optional: true, type: :bool
  field :field37112, 167, optional: true, type: :int64
  field :field37113, 146, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37114, 148, optional: true, type: :bool
  field :field37115, 154, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37116, 158, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field37117, 159, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field37118, 160, optional: true, type: :int32
  field :field37119, 161, repeated: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36910 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36911 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37121: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37122: Benchmarks.GoogleMessage3.Message35538.t() | nil,
          field37123: Benchmarks.GoogleMessage3.Message35540.t() | nil,
          field37124: Benchmarks.GoogleMessage3.Message35542.t() | nil
        }

  defstruct field37121: nil,
            field37122: nil,
            field37123: nil,
            field37124: nil

  field :field37121, 127, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37122, 130, optional: true, type: Benchmarks.GoogleMessage3.Message35538
  field :field37123, 144, optional: true, type: Benchmarks.GoogleMessage3.Message35540
  field :field37124, 150, optional: true, type: Benchmarks.GoogleMessage3.Message35542
end
defmodule Benchmarks.GoogleMessage3.Message36876.Message36912 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37125: Benchmarks.GoogleMessage3.Message3901.t() | nil,
          field37126: Benchmarks.GoogleMessage3.Message3901.t() | nil
        }

  defstruct field37125: nil,
            field37126: nil

  field :field37125, 153, optional: true, type: Benchmarks.GoogleMessage3.Message3901
  field :field37126, 162, optional: true, type: Benchmarks.GoogleMessage3.Message3901
end
defmodule Benchmarks.GoogleMessage3.Message36876 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field36980: Benchmarks.GoogleMessage3.Message2356.t() | nil,
          message36877: [any],
          message36878: [any],
          message36879: [any],
          field36984: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          message36880: any,
          field36986: non_neg_integer,
          field36987: binary,
          field36988: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field36989: Benchmarks.GoogleMessage3.Message7029.t() | nil,
          field36990: Benchmarks.GoogleMessage3.Message35573.t() | nil,
          field36991: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field36992: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field36993: float | :infinity | :negative_infinity | :nan,
          field36994: integer,
          field36995: boolean,
          field36996: boolean,
          field36997: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field36998: integer,
          field36999: integer,
          field37000: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          message36881: [any],
          field37002: Benchmarks.GoogleMessage3.Message4144.t() | nil,
          message36882: [any],
          field37004: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37005: Benchmarks.GoogleMessage3.Message18921.t() | nil,
          field37006: Benchmarks.GoogleMessage3.Message36858.t() | nil,
          field37007: Benchmarks.GoogleMessage3.Message18831.t() | nil,
          field37008: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37009: Benchmarks.GoogleMessage3.Message18283.t() | nil,
          field37010: String.t(),
          field37011: String.t(),
          field37012: Benchmarks.GoogleMessage3.Message0.t() | nil,
          field37013: Benchmarks.GoogleMessage3.Message0.t() | nil,
          field37014: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37015: Benchmarks.GoogleMessage3.Message36869.t() | nil,
          message36883: any,
          message36884: [any],
          message36885: [any],
          message36886: any,
          field37020: [Benchmarks.GoogleMessage3.UnusedEnum.t()],
          field37021: [integer],
          field37022: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37023: Benchmarks.GoogleMessage3.Message13090.t() | nil,
          message36887: any,
          field37025: [Benchmarks.GoogleMessage3.Message10155.t()],
          field37026: [Benchmarks.GoogleMessage3.Message11874.t()],
          field37027: String.t(),
          field37028: integer,
          field37029: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37030: Benchmarks.GoogleMessage3.Message35546.t() | nil,
          message36888: any,
          field37032: [Benchmarks.GoogleMessage3.Message19255.t()],
          field37033: Benchmarks.GoogleMessage3.Message33968.t() | nil,
          field37034: boolean,
          field37035: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field37036: Benchmarks.GoogleMessage3.Message6644.t() | nil,
          field37037: binary,
          message36889: any,
          message36910: [any],
          message36911: any,
          message36912: any,
          field37042: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field36980: nil,
            message36877: [],
            message36878: [],
            message36879: [],
            field36984: [],
            message36880: nil,
            field36986: nil,
            field36987: nil,
            field36988: nil,
            field36989: nil,
            field36990: nil,
            field36991: nil,
            field36992: nil,
            field36993: nil,
            field36994: nil,
            field36995: nil,
            field36996: nil,
            field36997: [],
            field36998: nil,
            field36999: nil,
            field37000: nil,
            message36881: [],
            field37002: nil,
            message36882: [],
            field37004: nil,
            field37005: nil,
            field37006: nil,
            field37007: nil,
            field37008: nil,
            field37009: nil,
            field37010: nil,
            field37011: nil,
            field37012: nil,
            field37013: nil,
            field37014: nil,
            field37015: nil,
            message36883: nil,
            message36884: [],
            message36885: [],
            message36886: nil,
            field37020: [],
            field37021: [],
            field37022: nil,
            field37023: nil,
            message36887: nil,
            field37025: [],
            field37026: [],
            field37027: nil,
            field37028: nil,
            field37029: nil,
            field37030: nil,
            message36888: nil,
            field37032: [],
            field37033: nil,
            field37034: nil,
            field37035: [],
            field37036: nil,
            field37037: nil,
            message36889: nil,
            message36910: [],
            message36911: nil,
            message36912: nil,
            field37042: nil

  field :field36980, 1, optional: true, type: Benchmarks.GoogleMessage3.Message2356
  field :message36877, 111, repeated: true, type: :group
  field :message36878, 168, repeated: true, type: :group
  field :message36879, 55, repeated: true, type: :group
  field :field36984, 78, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :message36880, 137, optional: true, type: :group
  field :field36986, 59, optional: true, type: :uint64
  field :field36987, 121, optional: true, type: :bytes
  field :field36988, 2, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field36989, 118, optional: true, type: Benchmarks.GoogleMessage3.Message7029
  field :field36990, 11, optional: true, type: Benchmarks.GoogleMessage3.Message35573
  field :field36991, 21, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field36992, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field36993, 13, optional: true, type: :float
  field :field36994, 20, optional: true, type: :int32
  field :field36995, 51, optional: true, type: :bool
  field :field36996, 57, optional: true, type: :bool
  field :field36997, 100, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field36998, 47, optional: true, type: :int32
  field :field36999, 48, optional: true, type: :int32
  field :field37000, 68, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :message36881, 23, repeated: true, type: :group
  field :field37002, 125, optional: true, type: Benchmarks.GoogleMessage3.Message4144
  field :message36882, 35, repeated: true, type: :group
  field :field37004, 49, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37005, 52, optional: true, type: Benchmarks.GoogleMessage3.Message18921
  field :field37006, 46, optional: true, type: Benchmarks.GoogleMessage3.Message36858
  field :field37007, 54, optional: true, type: Benchmarks.GoogleMessage3.Message18831
  field :field37008, 58, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37009, 10, optional: true, type: Benchmarks.GoogleMessage3.Message18283
  field :field37010, 44, optional: true, type: :string
  field :field37011, 103, optional: true, type: :string
  field :field37012, 43, optional: true, type: Benchmarks.GoogleMessage3.Message0
  field :field37013, 143, optional: true, type: Benchmarks.GoogleMessage3.Message0
  field :field37014, 53, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37015, 15, optional: true, type: Benchmarks.GoogleMessage3.Message36869
  field :message36883, 3, optional: true, type: :group
  field :message36884, 16, repeated: true, type: :group
  field :message36885, 27, repeated: true, type: :group
  field :message36886, 32, optional: true, type: :group
  field :field37020, 71, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field37021, 70, repeated: true, type: :int32
  field :field37022, 66, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37023, 67, optional: true, type: Benchmarks.GoogleMessage3.Message13090
  field :message36887, 62, optional: true, type: :group
  field :field37025, 50, repeated: true, type: Benchmarks.GoogleMessage3.Message10155
  field :field37026, 151, repeated: true, type: Benchmarks.GoogleMessage3.Message11874
  field :field37027, 12, optional: true, type: :string
  field :field37028, 72, optional: true, type: :int64
  field :field37029, 73, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37030, 108, optional: true, type: Benchmarks.GoogleMessage3.Message35546
  field :message36888, 74, optional: true, type: :group
  field :field37032, 104, repeated: true, type: Benchmarks.GoogleMessage3.Message19255
  field :field37033, 105, optional: true, type: Benchmarks.GoogleMessage3.Message33968
  field :field37034, 106, optional: true, type: :bool
  field :field37035, 107, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field37036, 110, optional: true, type: Benchmarks.GoogleMessage3.Message6644
  field :field37037, 133, optional: true, type: :bytes
  field :message36889, 116, optional: true, type: :group
  field :message36910, 119, repeated: true, type: :group
  field :message36911, 126, optional: true, type: :group
  field :message36912, 152, optional: true, type: :group
  field :field37042, 155, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end
defmodule Benchmarks.GoogleMessage3.Message1328 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message6850 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message6863 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6931: Benchmarks.GoogleMessage3.Enum6858.t(),
          field6932: Benchmarks.GoogleMessage3.Enum6858.t(),
          field6933: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field6934: boolean,
          field6935: Benchmarks.GoogleMessage3.Message6773.t() | nil,
          field6936: integer,
          field6937: integer,
          field6938: Benchmarks.GoogleMessage3.Enum6815.t(),
          field6939: String.t(),
          field6940: integer,
          field6941: Benchmarks.GoogleMessage3.Enum6822.t(),
          field6942: boolean,
          field6943: boolean,
          field6944: float | :infinity | :negative_infinity | :nan,
          field6945: float | :infinity | :negative_infinity | :nan,
          field6946: integer,
          field6947: integer,
          field6948: boolean,
          field6949: integer,
          field6950: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6951: non_neg_integer,
          field6952: String.t(),
          field6953: binary,
          field6954: integer,
          field6955: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6956: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6957: Benchmarks.GoogleMessage3.Message3886.t() | nil,
          field6958: String.t(),
          field6959: non_neg_integer,
          field6960: Benchmarks.GoogleMessage3.Message6743.t() | nil,
          field6961: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6962: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field6963: boolean
        }

  defstruct field6931: nil,
            field6932: nil,
            field6933: nil,
            field6934: nil,
            field6935: nil,
            field6936: nil,
            field6937: nil,
            field6938: nil,
            field6939: nil,
            field6940: nil,
            field6941: nil,
            field6942: nil,
            field6943: nil,
            field6944: nil,
            field6945: nil,
            field6946: nil,
            field6947: nil,
            field6948: nil,
            field6949: nil,
            field6950: nil,
            field6951: nil,
            field6952: nil,
            field6953: nil,
            field6954: nil,
            field6955: nil,
            field6956: nil,
            field6957: nil,
            field6958: nil,
            field6959: nil,
            field6960: nil,
            field6961: nil,
            field6962: nil,
            field6963: nil

  field :field6931, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum6858, enum: true
  field :field6932, 2, optional: true, type: Benchmarks.GoogleMessage3.Enum6858, enum: true
  field :field6933, 36, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
  field :field6934, 27, optional: true, type: :bool
  field :field6935, 26, optional: true, type: Benchmarks.GoogleMessage3.Message6773
  field :field6936, 30, optional: true, type: :int32
  field :field6937, 37, optional: true, type: :int32
  field :field6938, 31, optional: true, type: Benchmarks.GoogleMessage3.Enum6815, enum: true
  field :field6939, 3, optional: true, type: :string
  field :field6940, 4, optional: true, type: :int32
  field :field6941, 15, optional: true, type: Benchmarks.GoogleMessage3.Enum6822, enum: true
  field :field6942, 10, optional: true, type: :bool
  field :field6943, 17, optional: true, type: :bool
  field :field6944, 18, optional: true, type: :float
  field :field6945, 19, optional: true, type: :float
  field :field6946, 5, optional: true, type: :int32
  field :field6947, 6, optional: true, type: :int32
  field :field6948, 7, optional: true, type: :bool
  field :field6949, 12, optional: true, type: :int32
  field :field6950, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6951, 9, optional: true, type: :uint64
  field :field6952, 11, optional: true, type: :string
  field :field6953, 13, optional: true, type: :bytes
  field :field6954, 14, optional: true, type: :int32
  field :field6955, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6956, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6957, 38, optional: true, type: Benchmarks.GoogleMessage3.Message3886
  field :field6958, 20, optional: true, type: :string
  field :field6959, 21, optional: true, type: :uint32
  field :field6960, 23, optional: true, type: Benchmarks.GoogleMessage3.Message6743
  field :field6961, 29, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6962, 33, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field6963, 34, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage3.Message6871 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message7547 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7549: binary,
          field7550: integer
        }

  defstruct field7549: "",
            field7550: 0

  field :field7549, 1, required: true, type: :bytes
  field :field7550, 2, required: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message7648 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7669: String.t(),
          field7670: integer,
          field7671: integer,
          field7672: integer,
          field7673: integer,
          field7674: integer,
          field7675: float | :infinity | :negative_infinity | :nan,
          field7676: boolean,
          field7677: boolean,
          field7678: boolean,
          field7679: boolean,
          field7680: boolean
        }

  defstruct field7669: nil,
            field7670: nil,
            field7671: nil,
            field7672: nil,
            field7673: nil,
            field7674: nil,
            field7675: nil,
            field7676: nil,
            field7677: nil,
            field7678: nil,
            field7679: nil,
            field7680: nil

  field :field7669, 1, optional: true, type: :string
  field :field7670, 2, optional: true, type: :int32
  field :field7671, 3, optional: true, type: :int32
  field :field7672, 4, optional: true, type: :int32
  field :field7673, 5, optional: true, type: :int32
  field :field7674, 6, optional: true, type: :int32
  field :field7675, 7, optional: true, type: :float
  field :field7676, 8, optional: true, type: :bool
  field :field7677, 9, optional: true, type: :bool
  field :field7678, 10, optional: true, type: :bool
  field :field7679, 11, optional: true, type: :bool
  field :field7680, 12, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage3.Message7865 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{}

  defstruct []
end
defmodule Benchmarks.GoogleMessage3.Message7928 do
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
defmodule Benchmarks.GoogleMessage3.Message7919 do
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
defmodule Benchmarks.GoogleMessage3.Message7920 do
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
defmodule Benchmarks.GoogleMessage3.Message7921 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7936: integer,
          field7937: integer,
          field7938: float | :infinity | :negative_infinity | :nan,
          field7939: Benchmarks.GoogleMessage3.UnusedEnum.t()
        }

  defstruct field7936: nil,
            field7937: nil,
            field7938: nil,
            field7939: nil

  field :field7936, 1, optional: true, type: :int32
  field :field7937, 2, optional: true, type: :int64
  field :field7938, 3, optional: true, type: :float
  field :field7939, 4, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true
end
defmodule Benchmarks.GoogleMessage3.Message8511 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8539: Benchmarks.GoogleMessage3.Message8224.t() | nil,
          field8540: String.t(),
          field8541: boolean,
          field8542: integer,
          field8543: String.t()
        }

  defstruct field8539: nil,
            field8540: nil,
            field8541: nil,
            field8542: nil,
            field8543: nil

  field :field8539, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8224
  field :field8540, 2, optional: true, type: :string
  field :field8541, 3, optional: true, type: :bool
  field :field8542, 4, optional: true, type: :int64
  field :field8543, 5, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message8512 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8544: Benchmarks.GoogleMessage3.Message8301.t() | nil,
          field8545: Benchmarks.GoogleMessage3.Message8302.t() | nil,
          field8546: String.t(),
          field8547: boolean,
          field8548: integer,
          field8549: String.t()
        }

  defstruct field8544: nil,
            field8545: nil,
            field8546: nil,
            field8547: nil,
            field8548: nil,
            field8549: nil

  field :field8544, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8301
  field :field8545, 2, optional: true, type: Benchmarks.GoogleMessage3.Message8302
  field :field8546, 3, optional: true, type: :string
  field :field8547, 4, optional: true, type: :bool
  field :field8548, 5, optional: true, type: :int64
  field :field8549, 6, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message8513 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8550: [Benchmarks.GoogleMessage3.Message8392.t()],
          field8551: String.t(),
          field8552: boolean,
          field8553: String.t()
        }

  defstruct field8550: [],
            field8551: nil,
            field8552: nil,
            field8553: nil

  field :field8550, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message8392
  field :field8551, 2, optional: true, type: :string
  field :field8552, 3, optional: true, type: :bool
  field :field8553, 4, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message8514 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8554: String.t(),
          field8555: integer,
          field8556: boolean,
          field8557: [Benchmarks.GoogleMessage3.Message8130.t()],
          field8558: String.t()
        }

  defstruct field8554: nil,
            field8555: nil,
            field8556: nil,
            field8557: [],
            field8558: nil

  field :field8554, 1, optional: true, type: :string
  field :field8555, 2, optional: true, type: :int64
  field :field8556, 3, optional: true, type: :bool
  field :field8557, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message8130
  field :field8558, 5, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message8515 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8559: Benchmarks.GoogleMessage3.Message8479.t() | nil,
          field8560: Benchmarks.GoogleMessage3.Message8478.t() | nil,
          field8561: String.t()
        }

  defstruct field8559: nil,
            field8560: nil,
            field8561: nil

  field :field8559, 1, optional: true, type: Benchmarks.GoogleMessage3.Message8479
  field :field8560, 2, optional: true, type: Benchmarks.GoogleMessage3.Message8478
  field :field8561, 3, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message10320 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10347: Benchmarks.GoogleMessage3.Enum10335.t(),
          field10348: [Benchmarks.GoogleMessage3.Message10319.t()],
          field10349: integer,
          field10350: integer,
          field10351: integer,
          field10352: integer,
          field10353: Benchmarks.GoogleMessage3.Enum10337.t()
        }

  defstruct field10347: nil,
            field10348: [],
            field10349: nil,
            field10350: nil,
            field10351: nil,
            field10352: nil,
            field10353: nil

  field :field10347, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum10335, enum: true
  field :field10348, 2, repeated: true, type: Benchmarks.GoogleMessage3.Message10319
  field :field10349, 3, optional: true, type: :int32
  field :field10350, 4, optional: true, type: :int32
  field :field10351, 5, optional: true, type: :int32
  field :field10352, 6, optional: true, type: :int32
  field :field10353, 7, optional: true, type: Benchmarks.GoogleMessage3.Enum10337, enum: true
end
defmodule Benchmarks.GoogleMessage3.Message10321 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10354: integer,
          field10355: integer,
          field10356: non_neg_integer
        }

  defstruct field10354: nil,
            field10355: nil,
            field10356: nil

  field :field10354, 1, optional: true, type: :int32
  field :field10355, 2, optional: true, type: :int32
  field :field10356, 3, optional: true, type: :uint64
end
defmodule Benchmarks.GoogleMessage3.Message10322 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10357: Benchmarks.GoogleMessage3.Message4016.t() | nil,
          field10358: boolean,
          field10359: boolean
        }

  defstruct field10357: nil,
            field10358: nil,
            field10359: nil

  field :field10357, 1, optional: true, type: Benchmarks.GoogleMessage3.Message4016
  field :field10358, 2, optional: true, type: :bool
  field :field10359, 3, optional: true, type: :bool
end
defmodule Benchmarks.GoogleMessage3.Message11988 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12021: String.t(),
          field12022: String.t(),
          field12023: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field12024: Benchmarks.GoogleMessage3.Message10155.t() | nil
        }

  defstruct field12021: nil,
            field12022: nil,
            field12023: nil,
            field12024: nil

  field :field12021, 1, optional: true, type: :string
  field :field12022, 2, optional: true, type: :string
  field :field12023, 3, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field12024, 4, optional: true, type: Benchmarks.GoogleMessage3.Message10155
end
defmodule Benchmarks.GoogleMessage3.Message12668 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12677: [Benchmarks.GoogleMessage3.Message12669.t()],
          field12678: integer,
          field12679: integer,
          field12680: integer
        }

  defstruct field12677: [],
            field12678: nil,
            field12679: nil,
            field12680: nil

  field :field12677, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message12669
  field :field12678, 2, optional: true, type: :int32
  field :field12679, 3, optional: true, type: :int32
  field :field12680, 4, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message12825 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12862: [Benchmarks.GoogleMessage3.Message12818.t()],
          field12863: integer,
          field12864: Benchmarks.GoogleMessage3.Message12819.t() | nil,
          field12865: Benchmarks.GoogleMessage3.Message12820.t() | nil,
          field12866: integer,
          field12867: [Benchmarks.GoogleMessage3.Message12821.t()],
          field12868: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct field12862: [],
            field12863: nil,
            field12864: nil,
            field12865: nil,
            field12866: nil,
            field12867: [],
            field12868: []

  field :field12862, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message12818
  field :field12863, 2, optional: true, type: :int32
  field :field12864, 3, optional: true, type: Benchmarks.GoogleMessage3.Message12819
  field :field12865, 4, optional: true, type: Benchmarks.GoogleMessage3.Message12820
  field :field12866, 5, optional: true, type: :int32
  field :field12867, 6, repeated: true, type: Benchmarks.GoogleMessage3.Message12821
  field :field12868, 7, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end
defmodule Benchmarks.GoogleMessage3.Message16478 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16481: [Benchmarks.GoogleMessage3.Message16479.t()],
          field16482: boolean,
          field16483: integer
        }

  defstruct field16481: [],
            field16482: nil,
            field16483: nil

  field :field16481, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16479
  field :field16482, 3, optional: true, type: :bool
  field :field16483, 2, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message16552 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16565: non_neg_integer,
          field16566: integer,
          field16567: Benchmarks.GoogleMessage3.Enum16553.t()
        }

  defstruct field16565: nil,
            field16566: nil,
            field16567: nil

  field :field16565, 1, optional: true, type: :fixed64
  field :field16566, 2, optional: true, type: :int32
  field :field16567, 3, optional: true, type: Benchmarks.GoogleMessage3.Enum16553, enum: true
end
defmodule Benchmarks.GoogleMessage3.Message16660 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16668: String.t(),
          field16669: String.t(),
          field16670: integer
        }

  defstruct field16668: nil,
            field16669: nil,
            field16670: nil

  field :field16668, 1, optional: true, type: :string
  field :field16669, 2, optional: true, type: :string
  field :field16670, 3, optional: true, type: :int32
end
defmodule Benchmarks.GoogleMessage3.Message16727 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16782: Benchmarks.GoogleMessage3.Enum16728.t(),
          field16783: String.t(),
          field16784: String.t(),
          field16785: integer,
          field16786: String.t(),
          field16787: String.t(),
          field16788: String.t(),
          field16789: Benchmarks.GoogleMessage3.Enum16732.t(),
          field16790: String.t(),
          field16791: String.t(),
          field16792: String.t(),
          field16793: Benchmarks.GoogleMessage3.Enum16738.t(),
          field16794: integer,
          field16795: [Benchmarks.GoogleMessage3.Message16722.t()],
          field16796: boolean,
          field16797: boolean,
          field16798: String.t(),
          field16799: integer,
          field16800: boolean,
          field16801: String.t(),
          field16802: Benchmarks.GoogleMessage3.Enum16698.t(),
          field16803: Benchmarks.GoogleMessage3.Message16724.t() | nil,
          field16804: boolean,
          field16805: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          __pb_extensions__: map
        }

  defstruct field16782: 0,
            field16783: "",
            field16784: nil,
            field16785: nil,
            field16786: "",
            field16787: nil,
            field16788: nil,
            field16789: 0,
            field16790: nil,
            field16791: nil,
            field16792: nil,
            field16793: nil,
            field16794: nil,
            field16795: [],
            field16796: nil,
            field16797: nil,
            field16798: nil,
            field16799: nil,
            field16800: nil,
            field16801: nil,
            field16802: nil,
            field16803: nil,
            field16804: nil,
            field16805: nil,
            __pb_extensions__: nil

  field :field16782, 1, required: true, type: Benchmarks.GoogleMessage3.Enum16728, enum: true
  field :field16783, 2, required: true, type: :string
  field :field16784, 3, optional: true, type: :string
  field :field16785, 23, optional: true, type: :int32
  field :field16786, 4, required: true, type: :string
  field :field16787, 5, optional: true, type: :string
  field :field16788, 6, optional: true, type: :string
  field :field16789, 7, required: true, type: Benchmarks.GoogleMessage3.Enum16732, enum: true
  field :field16790, 8, optional: true, type: :string
  field :field16791, 9, optional: true, type: :string
  field :field16792, 10, optional: true, type: :string
  field :field16793, 11, optional: true, type: Benchmarks.GoogleMessage3.Enum16738, enum: true
  field :field16794, 12, optional: true, type: :int32
  field :field16795, 13, repeated: true, type: Benchmarks.GoogleMessage3.Message16722
  field :field16796, 19, optional: true, type: :bool
  field :field16797, 24, optional: true, type: :bool
  field :field16798, 14, optional: true, type: :string
  field :field16799, 15, optional: true, type: :int64
  field :field16800, 16, optional: true, type: :bool
  field :field16801, 17, optional: true, type: :string
  field :field16802, 18, optional: true, type: Benchmarks.GoogleMessage3.Enum16698, enum: true
  field :field16803, 20, optional: true, type: Benchmarks.GoogleMessage3.Message16724
  field :field16804, 22, optional: true, type: :bool
  field :field16805, 25, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  extensions [{1000, 536_870_912}]
end
defmodule Benchmarks.GoogleMessage3.Message16725 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16774: Benchmarks.GoogleMessage3.Enum16728.t(),
          field16775: [String.t()]
        }

  defstruct field16774: nil,
            field16775: []

  field :field16774, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum16728, enum: true
  field :field16775, 2, repeated: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message17726 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field17801: String.t(),
          field17802: [String.t()],
          field17803: String.t(),
          field17804: [String.t()],
          field17805: String.t(),
          field17806: [String.t()],
          field17807: String.t(),
          field17808: String.t(),
          field17809: [String.t()],
          field17810: [String.t()],
          field17811: [String.t()],
          field17812: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17813: String.t(),
          field17814: String.t(),
          field17815: String.t(),
          field17816: String.t(),
          field17817: String.t(),
          field17818: String.t(),
          field17819: String.t(),
          field17820: [Benchmarks.GoogleMessage3.Message17728.t()],
          field17821: [Benchmarks.GoogleMessage3.Message17728.t()],
          field17822: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct field17801: nil,
            field17802: [],
            field17803: nil,
            field17804: [],
            field17805: nil,
            field17806: [],
            field17807: nil,
            field17808: nil,
            field17809: [],
            field17810: [],
            field17811: [],
            field17812: [],
            field17813: nil,
            field17814: nil,
            field17815: nil,
            field17816: nil,
            field17817: nil,
            field17818: nil,
            field17819: nil,
            field17820: [],
            field17821: [],
            field17822: []

  field :field17801, 1, optional: true, type: :string
  field :field17802, 2, repeated: true, type: :string
  field :field17803, 3, optional: true, type: :string
  field :field17804, 4, repeated: true, type: :string
  field :field17805, 5, optional: true, type: :string
  field :field17806, 6, repeated: true, type: :string
  field :field17807, 7, optional: true, type: :string
  field :field17808, 8, optional: true, type: :string
  field :field17809, 15, repeated: true, type: :string
  field :field17810, 16, repeated: true, type: :string
  field :field17811, 17, repeated: true, type: :string
  field :field17812, 18, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17813, 9, optional: true, type: :string
  field :field17814, 10, optional: true, type: :string
  field :field17815, 11, optional: true, type: :string
  field :field17816, 12, optional: true, type: :string
  field :field17817, 13, optional: true, type: :string
  field :field17818, 14, optional: true, type: :string
  field :field17819, 19, optional: true, type: :string
  field :field17820, 20, repeated: true, type: Benchmarks.GoogleMessage3.Message17728
  field :field17821, 21, repeated: true, type: Benchmarks.GoogleMessage3.Message17728
  field :field17822, 30, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end
defmodule Benchmarks.GoogleMessage3.Message17782 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18153: String.t(),
          field18154: String.t()
        }

  defstruct field18153: nil,
            field18154: nil

  field :field18153, 1, optional: true, type: :string
  field :field18154, 2, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message17783.Message17784 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18162: String.t(),
          field18163: String.t(),
          field18164: String.t(),
          field18165: [String.t()],
          field18166: String.t(),
          field18167: String.t()
        }

  defstruct field18162: nil,
            field18163: nil,
            field18164: nil,
            field18165: [],
            field18166: nil,
            field18167: nil

  field :field18162, 5, optional: true, type: :string
  field :field18163, 6, optional: true, type: :string
  field :field18164, 7, optional: true, type: :string
  field :field18165, 8, repeated: true, type: :string
  field :field18166, 17, optional: true, type: :string
  field :field18167, 18, optional: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message17783.Message17785 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18168: String.t(),
          field18169: String.t(),
          field18170: Benchmarks.GoogleMessage3.Message17783.t() | nil,
          field18171: String.t(),
          field18172: String.t(),
          field18173: [String.t()]
        }

  defstruct field18168: nil,
            field18169: nil,
            field18170: nil,
            field18171: nil,
            field18172: nil,
            field18173: []

  field :field18168, 10, optional: true, type: :string
  field :field18169, 11, optional: true, type: :string
  field :field18170, 12, optional: true, type: Benchmarks.GoogleMessage3.Message17783
  field :field18171, 13, optional: true, type: :string
  field :field18172, 14, optional: true, type: :string
  field :field18173, 15, repeated: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message17783 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18155: String.t(),
          field18156: String.t(),
          field18157: String.t(),
          message17784: [any],
          message17785: [any],
          field18160: [String.t()]
        }

  defstruct field18155: nil,
            field18156: nil,
            field18157: nil,
            message17784: [],
            message17785: [],
            field18160: []

  field :field18155, 1, optional: true, type: :string
  field :field18156, 2, optional: true, type: :string
  field :field18157, 3, optional: true, type: :string
  field :message17784, 4, repeated: true, type: :group
  field :message17785, 9, repeated: true, type: :group
  field :field18160, 16, repeated: true, type: :string
end
defmodule Benchmarks.GoogleMessage3.Message16945 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16946: String.t(),
          field16947: String.t(),
          field16948: String.t(),
          field16949: String.t(),
          field16950: String.t(),
          field16951: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field16952: [Benchmarks.GoogleMessage3.Message0.t()],
          field16953: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16954: [Benchmarks.GoogleMessage3.Message0.t()],
          field16955: [String.t()],
          field16956: [String.t()],
          field16957: [String.t()],
          field16958: [String.t()],
          field16959: [String.t()],
          field16960: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16961: [Benchmarks.GoogleMessage3.Message0.t()],
          field16962: [Benchmarks.GoogleMessage3.Message0.t()],
          field16963: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16964: [String.t()],
          field16965: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16966: [String.t()],
          field16967: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16968: [String.t()],
          field16969: [Benchmarks.GoogleMessage3.Message0.t()],
          field16970: [String.t()],
          field16971: [String.t()],
          field16972: [String.t()],
          field16973: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16974: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16975: [String.t()],
          field16976: [String.t()],
          field16977: [Benchmarks.GoogleMessage3.Message0.t()],
          field16978: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16979: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16980: [integer],
          field16981: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16982: [String.t()],
          field16983: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16984: [String.t()],
          field16985: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16986: [String.t()],
          field16987: [String.t()],
          field16988: [String.t()],
          field16989: String.t(),
          field16990: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16991: [String.t()],
          field16992: [String.t()],
          field16993: [String.t()],
          field16994: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field16995: integer,
          field16996: integer,
          field16997: String.t(),
          field16998: [String.t()],
          field16999: [String.t()],
          field17000: String.t(),
          field17001: [String.t()],
          field17002: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17003: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17004: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17005: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17006: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17007: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17008: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17009: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field17010: [Benchmarks.GoogleMessage3.Message0.t()],
          field17011: [String.t()],
          field17012: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17013: [String.t()],
          field17014: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field17015: [Benchmarks.GoogleMessage3.Message0.t()],
          field17016: [String.t()],
          field17017: [String.t()],
          field17018: [String.t()],
          field17019: [String.t()],
          field17020: [String.t()],
          field17021: [String.t()],
          field17022: [String.t()],
          field17023: [Benchmarks.GoogleMessage3.Message0.t()],
          field17024: [String.t()],
          __pb_extensions__: map
        }

  defstruct field16946: nil,
            field16947: nil,
            field16948: nil,
            field16949: nil,
            field16950: nil,
            field16951: nil,
            field16952: [],
            field16953: [],
            field16954: [],
            field16955: [],
            field16956: [],
            field16957: [],
            field16958: [],
            field16959: [],
            field16960: [],
            field16961: [],
            field16962: [],
            field16963: [],
            field16964: [],
            field16965: [],
            field16966: [],
            field16967: [],
            field16968: [],
            field16969: [],
            field16970: [],
            field16971: [],
            field16972: [],
            field16973: [],
            field16974: [],
            field16975: [],
            field16976: [],
            field16977: [],
            field16978: [],
            field16979: [],
            field16980: [],
            field16981: [],
            field16982: [],
            field16983: [],
            field16984: [],
            field16985: [],
            field16986: [],
            field16987: [],
            field16988: [],
            field16989: nil,
            field16990: [],
            field16991: [],
            field16992: [],
            field16993: [],
            field16994: nil,
            field16995: nil,
            field16996: nil,
            field16997: nil,
            field16998: [],
            field16999: [],
            field17000: nil,
            field17001: [],
            field17002: [],
            field17003: [],
            field17004: [],
            field17005: [],
            field17006: [],
            field17007: [],
            field17008: [],
            field17009: nil,
            field17010: [],
            field17011: [],
            field17012: [],
            field17013: [],
            field17014: [],
            field17015: [],
            field17016: [],
            field17017: [],
            field17018: [],
            field17019: [],
            field17020: [],
            field17021: [],
            field17022: [],
            field17023: [],
            field17024: [],
            __pb_extensions__: nil

  field :field16946, 1, optional: true, type: :string
  field :field16947, 2, optional: true, type: :string
  field :field16948, 3, optional: true, type: :string
  field :field16949, 4, optional: true, type: :string
  field :field16950, 5, optional: true, type: :string
  field :field16951, 872, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16952, 16, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16953, 54, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16954, 55, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16955, 58, repeated: true, type: :string
  field :field16956, 59, repeated: true, type: :string
  field :field16957, 62, repeated: true, type: :string
  field :field16958, 37, repeated: true, type: :string
  field :field16959, 18, repeated: true, type: :string
  field :field16960, 38, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16961, 67, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16962, 130, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16963, 136, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16964, 138, repeated: true, type: :string
  field :field16965, 156, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16966, 139, repeated: true, type: :string
  field :field16967, 126, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16968, 152, repeated: true, type: :string
  field :field16969, 183, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16970, 168, repeated: true, type: :string
  field :field16971, 212, repeated: true, type: :string
  field :field16972, 213, repeated: true, type: :string
  field :field16973, 189, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16974, 190, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16975, 191, repeated: true, type: :string
  field :field16976, 192, repeated: true, type: :string
  field :field16977, 193, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field16978, 194, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16979, 195, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16980, 196, repeated: true, type: :int32
  field :field16981, 95, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16982, 96, repeated: true, type: :string
  field :field16983, 97, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16984, 1086, repeated: true, type: :string
  field :field16985, 98, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16986, 99, repeated: true, type: :string
  field :field16987, 100, repeated: true, type: :string
  field :field16988, 48, repeated: true, type: :string
  field :field16989, 22, optional: true, type: :string
  field :field16990, 51, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16991, 81, repeated: true, type: :string
  field :field16992, 85, repeated: true, type: :string
  field :field16993, 169, repeated: true, type: :string
  field :field16994, 260, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field16995, 198, optional: true, type: :int32
  field :field16996, 204, optional: true, type: :int32
  field :field16997, 1087, optional: true, type: :string
  field :field16998, 197, repeated: true, type: :string
  field :field16999, 206, repeated: true, type: :string
  field :field17000, 211, optional: true, type: :string
  field :field17001, 205, repeated: true, type: :string
  field :field17002, 68, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17003, 69, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17004, 70, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17005, 71, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17006, 72, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17007, 19, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17008, 24, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17009, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17010, 131, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field17011, 133, repeated: true, type: :string
  field :field17012, 142, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17013, 143, repeated: true, type: :string
  field :field17014, 153, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field17015, 170, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field17016, 171, repeated: true, type: :string
  field :field17017, 172, repeated: true, type: :string
  field :field17018, 173, repeated: true, type: :string
  field :field17019, 174, repeated: true, type: :string
  field :field17020, 175, repeated: true, type: :string
  field :field17021, 186, repeated: true, type: :string
  field :field17022, 101, repeated: true, type: :string
  field :field17023, 102, repeated: true, type: Benchmarks.GoogleMessage3.Message0
  field :field17024, 274, repeated: true, type: :string

  extensions [
    {17, 18},
    {21, 22},
    {25, 26},
    {27, 28},
    {29, 30},
    {30, 31},
    {31, 32},
    {32, 33},
    {33, 34},
    {34, 35},
    {35, 36},
    {36, 37},
    {39, 40},
    {40, 41},
    {41, 42},
    {42, 43},
    {43, 44},
    {44, 45},
    {45, 46},
    {46, 47},
    {47, 48},
    {49, 50},
    {50, 51},
    {52, 53},
    {53, 54},
    {56, 57},
    {57, 58},
    {60, 61},
    {61, 62},
    {63, 64},
    {64, 65},
    {65, 66},
    {66, 67},
    {73, 74},
    {74, 75},
    {75, 76},
    {76, 77},
    {77, 78},
    {78, 79},
    {79, 80},
    {80, 81},
    {82, 83},
    {83, 84},
    {84, 85},
    {86, 87},
    {87, 88},
    {88, 89},
    {89, 90},
    {90, 91},
    {91, 92},
    {92, 93},
    {93, 94},
    {94, 95},
    {103, 104},
    {104, 105},
    {105, 106},
    {106, 107},
    {107, 108},
    {108, 109},
    {109, 110},
    {110, 111},
    {111, 112},
    {112, 113},
    {113, 114},
    {114, 115},
    {115, 116},
    {116, 117},
    {117, 118},
    {118, 119},
    {119, 120},
    {120, 121},
    {121, 122},
    {122, 123},
    {123, 124},
    {124, 125},
    {125, 126},
    {127, 128},
    {128, 129},
    {129, 130},
    {132, 133},
    {134, 135},
    {135, 136},
    {137, 138},
    {140, 141},
    {141, 142},
    {144, 145},
    {145, 146},
    {146, 147},
    {147, 148},
    {148, 149},
    {149, 150},
    {150, 151},
    {151, 152},
    {154, 155},
    {155, 156},
    {157, 158},
    {158, 159},
    {159, 160},
    {160, 161},
    {161, 162},
    {162, 163},
    {163, 164},
    {164, 165},
    {165, 166},
    {166, 167},
    {167, 168},
    {176, 177},
    {177, 178},
    {178, 179},
    {179, 180},
    {180, 181},
    {181, 182},
    {182, 183},
    {184, 185},
    {185, 186},
    {187, 188},
    {188, 189},
    {199, 200},
    {200, 201},
    {201, 202},
    {202, 203},
    {203, 204},
    {207, 208},
    {208, 209},
    {209, 210},
    {210, 211},
    {214, 215},
    {215, 216},
    {216, 217},
    {217, 218},
    {218, 219},
    {219, 220},
    {220, 221},
    {221, 222},
    {222, 223},
    {223, 224},
    {224, 225},
    {225, 226},
    {226, 227},
    {227, 228},
    {228, 229},
    {229, 230},
    {230, 231},
    {231, 232},
    {232, 233},
    {233, 234},
    {234, 235},
    {235, 236},
    {236, 237},
    {237, 238},
    {238, 239},
    {239, 240},
    {240, 241},
    {241, 242},
    {242, 243},
    {243, 244},
    {244, 245},
    {245, 246},
    {246, 247},
    {247, 248},
    {248, 249},
    {249, 250},
    {250, 251},
    {251, 252},
    {252, 253},
    {253, 254},
    {254, 255},
    {255, 256},
    {256, 257},
    {257, 258},
    {258, 259},
    {259, 260},
    {261, 262},
    {262, 263},
    {263, 264},
    {264, 265},
    {265, 266},
    {266, 267},
    {267, 268},
    {268, 269},
    {269, 270},
    {270, 271},
    {271, 272},
    {272, 273},
    {273, 274},
    {275, 276},
    {276, 277},
    {277, 278},
    {278, 279},
    {279, 280},
    {280, 281},
    {281, 282},
    {282, 283},
    {283, 284},
    {284, 285},
    {285, 286},
    {286, 287},
    {290, 291},
    {291, 292},
    {292, 293},
    {293, 294},
    {294, 295},
    {295, 296},
    {296, 297},
    {297, 298},
    {298, 299},
    {299, 300},
    {300, 301},
    {301, 302},
    {302, 303},
    {303, 304},
    {304, 305},
    {305, 306},
    {306, 307},
    {307, 308},
    {308, 309},
    {309, 310},
    {310, 311},
    {311, 312},
    {312, 313},
    {313, 314},
    {314, 315},
    {315, 316},
    {316, 317},
    {317, 318},
    {318, 319},
    {319, 320},
    {320, 321},
    {321, 322},
    {322, 323},
    {323, 324},
    {324, 325},
    {325, 326},
    {326, 327},
    {327, 328},
    {328, 329},
    {329, 330},
    {330, 331},
    {331, 332},
    {332, 333},
    {333, 334},
    {334, 335},
    {335, 336},
    {336, 337},
    {337, 338},
    {338, 339},
    {339, 340},
    {340, 341},
    {341, 342},
    {342, 343},
    {343, 344},
    {344, 345},
    {345, 346},
    {346, 347},
    {347, 348},
    {348, 349},
    {349, 350},
    {350, 351},
    {351, 352},
    {352, 353},
    {353, 354},
    {354, 355},
    {355, 356},
    {356, 357},
    {357, 358},
    {358, 359},
    {359, 360},
    {360, 361},
    {361, 362},
    {362, 363},
    {363, 364},
    {364, 365},
    {365, 366},
    {366, 367},
    {367, 368},
    {368, 369},
    {369, 370},
    {370, 371},
    {371, 372},
    {372, 373},
    {373, 374},
    {374, 375},
    {375, 376},
    {376, 377},
    {377, 378},
    {378, 379},
    {379, 380},
    {380, 381},
    {381, 382},
    {382, 383},
    {383, 384},
    {384, 385},
    {385, 386},
    {386, 387},
    {387, 388},
    {388, 389},
    {389, 390},
    {390, 391},
    {391, 392},
    {392, 393},
    {393, 394},
    {394, 395},
    {395, 396},
    {396, 397},
    {397, 398},
    {398, 399},
    {399, 400},
    {400, 401},
    {401, 402},
    {402, 403},
    {403, 404},
    {404, 405},
    {405, 406},
    {406, 407},
    {407, 408},
    {408, 409},
    {409, 410},
    {410, 411},
    {411, 412},
    {412, 413},
    {413, 414},
    {414, 415},
    {415, 416},
    {416, 417},
    {417, 418},
    {418, 419},
    {419, 420},
    {420, 421},
    {421, 422},
    {422, 423},
    {423, 424},
    {424, 425},
    {425, 426},
    {426, 427},
    {427, 428},
    {428, 429},
    {429, 430},
    {430, 431},
    {431, 432},
    {432, 433},
    {433, 434},
    {434, 435},
    {435, 436},
    {436, 437},
    {437, 438},
    {438, 439},
    {439, 440},
    {440, 441},
    {441, 442},
    {442, 443},
    {443, 444},
    {444, 445},
    {445, 446},
    {446, 447},
    {447, 448},
    {448, 449},
    {449, 450},
    {450, 451},
    {451, 452},
    {452, 453},
    {453, 454},
    {454, 455},
    {455, 456},
    {456, 457},
    {457, 458},
    {458, 459},
    {459, 460},
    {460, 461},
    {461, 462},
    {462, 463},
    {463, 464},
    {464, 465},
    {465, 466},
    {466, 467},
    {467, 468},
    {468, 469},
    {469, 470},
    {470, 471},
    {471, 472},
    {472, 473},
    {473, 474},
    {474, 475},
    {509, 510},
    {511, 512},
    {512, 513},
    {513, 514},
    {514, 515},
    {515, 516},
    {516, 517},
    {517, 518},
    {518, 519},
    {519, 520},
    {520, 521},
    {521, 522},
    {522, 523},
    {523, 524},
    {524, 525},
    {525, 526},
    {526, 527},
    {527, 528},
    {528, 529},
    {529, 530},
    {530, 531},
    {531, 532},
    {532, 533},
    {533, 534},
    {534, 535},
    {535, 536},
    {536, 537},
    {537, 538},
    {538, 539},
    {539, 540},
    {540, 541},
    {541, 542},
    {542, 543},
    {543, 544},
    {544, 545},
    {545, 546},
    {546, 547},
    {547, 548},
    {548, 549},
    {549, 550},
    {550, 551},
    {551, 552},
    {552, 553},
    {553, 554},
    {554, 555},
    {555, 556},
    {556, 557},
    {557, 558},
    {558, 559},
    {559, 560},
    {560, 561},
    {561, 562},
    {562, 563},
    {563, 564},
    {564, 565},
    {565, 566},
    {566, 567},
    {567, 568},
    {568, 569},
    {569, 570},
    {570, 571},
    {571, 572},
    {572, 573},
    {573, 574},
    {574, 575},
    {575, 576},
    {576, 577},
    {577, 578},
    {578, 579},
    {579, 580},
    {580, 581},
    {581, 582},
    {582, 583},
    {583, 584},
    {584, 585},
    {585, 586},
    {586, 587},
    {587, 588},
    {588, 589},
    {589, 590},
    {590, 591},
    {604, 605},
    {605, 606},
    {606, 607},
    {607, 608},
    {608, 609},
    {609, 610},
    {610, 611},
    {611, 612},
    {612, 613},
    {613, 614},
    {614, 615},
    {615, 616},
    {616, 617},
    {617, 618},
    {618, 619},
    {619, 620},
    {620, 621},
    {621, 622},
    {622, 623},
    {623, 624},
    {624, 625},
    {625, 626},
    {626, 627},
    {627, 628},
    {628, 629},
    {629, 630},
    {813, 814},
    {814, 815},
    {815, 816},
    {816, 817},
    {817, 818},
    {818, 819},
    {819, 820},
    {820, 821},
    {821, 822},
    {822, 823},
    {823, 824},
    {824, 825},
    {827, 828},
    {828, 829},
    {829, 830},
    {830, 831},
    {831, 832},
    {832, 833},
    {833, 834},
    {834, 835},
    {835, 836},
    {836, 837},
    {837, 838},
    {838, 839},
    {839, 840},
    {840, 841},
    {841, 842},
    {842, 843},
    {843, 844},
    {844, 845},
    {845, 846},
    {846, 847},
    {847, 848},
    {848, 849},
    {849, 850},
    {850, 851},
    {851, 852},
    {852, 853},
    {853, 854},
    {854, 855},
    {855, 856},
    {856, 857},
    {857, 858},
    {858, 859},
    {859, 860},
    {860, 861},
    {861, 862},
    {862, 863},
    {863, 864},
    {864, 865},
    {865, 866},
    {866, 867},
    {867, 868},
    {868, 869},
    {869, 870},
    {870, 871},
    {871, 872},
    {880, 881},
    {881, 882},
    {882, 883},
    {883, 884},
    {884, 885},
    {885, 886},
    {886, 887},
    {887, 888},
    {888, 889},
    {890, 891},
    {891, 892},
    {892, 893},
    {912, 913},
    {914, 915},
    {915, 916},
    {916, 917},
    {917, 918},
    {918, 919},
    {919, 920},
    {920, 921},
    {921, 922},
    {922, 923},
    {923, 924},
    {924, 925},
    {925, 926},
    {926, 927},
    {927, 928},
    {928, 929},
    {929, 930},
    {930, 931},
    {931, 932},
    {932, 933},
    {933, 934},
    {934, 935},
    {935, 936},
    {936, 937},
    {937, 938},
    {938, 939},
    {939, 940},
    {940, 941},
    {941, 942},
    {942, 943},
    {943, 944},
    {944, 945},
    {945, 946},
    {946, 947},
    {947, 948},
    {949, 950},
    {950, 951},
    {951, 952},
    {952, 953},
    {954, 955},
    {955, 956},
    {956, 957},
    {957, 958},
    {958, 959},
    {959, 960},
    {960, 961},
    {961, 962},
    {962, 963},
    {963, 964},
    {964, 965},
    {965, 966},
    {966, 967},
    {967, 968},
    {968, 969},
    {969, 970},
    {970, 971},
    {971, 972},
    {972, 973},
    {973, 974},
    {974, 975},
    {975, 976},
    {976, 977},
    {977, 978},
    {978, 979},
    {979, 980},
    {980, 981},
    {981, 982},
    {982, 983},
    {983, 984},
    {984, 985},
    {985, 986},
    {987, 988},
    {988, 989},
    {1000, 1001},
    {1001, 1002},
    {1002, 1003},
    {1003, 1004},
    {1004, 1005},
    {1005, 1006},
    {1006, 1007},
    {1007, 1008},
    {1008, 1009},
    {1009, 1010},
    {1010, 1011},
    {1011, 1012},
    {1012, 1013},
    {1013, 1014},
    {1014, 1015},
    {1015, 1016},
    {1016, 1017},
    {1017, 1018},
    {1018, 1019},
    {1019, 1020},
    {1020, 1021},
    {1021, 1022},
    {1022, 1023},
    {1023, 1024},
    {1024, 1025},
    {1025, 1026},
    {1026, 1027},
    {1027, 1028},
    {1028, 1029},
    {1029, 1030},
    {1030, 1031},
    {1031, 1032},
    {1032, 1033},
    {1033, 1034},
    {1034, 1035},
    {1035, 1036},
    {1036, 1037},
    {1037, 1038},
    {1038, 1039},
    {1039, 1040},
    {1040, 1041},
    {1041, 1042},
    {1042, 1043},
    {1043, 1044},
    {1044, 1045},
    {1045, 1046},
    {1046, 1047},
    {1047, 1048},
    {1048, 1049},
    {1049, 1050},
    {1050, 1051},
    {1051, 1052},
    {1052, 1053},
    {1053, 1054},
    {1054, 1055},
    {1055, 1056},
    {1056, 1057},
    {1057, 1058},
    {1058, 1059},
    {1079, 1080},
    {1080, 1081},
    {1081, 1082},
    {1082, 1083},
    {1083, 1084},
    {1084, 1085},
    {1085, 1086}
  ]
end
defmodule Benchmarks.GoogleMessage3.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Benchmarks.GoogleMessage3.Message0, :"Message35807.field35818", 3_803_299,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message35807

  extend Benchmarks.GoogleMessage3.Message0, :"Message34624.field34685", 18_178_548,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message34624

  extend Benchmarks.GoogleMessage3.Message0, :"Message34390.field34453", 92_144_610,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message34390

  extend Benchmarks.GoogleMessage3.Message0, :"Message34791.field34807", 6_330_340,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message34791

  extend Benchmarks.GoogleMessage3.Message0, :"Message35483.field35505", 7_913_554,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message35483

  extend Benchmarks.GoogleMessage3.Message0, :"Message16945.field17025", 22_068_132,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message16945
end
