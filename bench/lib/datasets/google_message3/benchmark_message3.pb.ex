defmodule Benchmarks.GoogleMessage3.GoogleMessage3 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field37519: Benchmarks.GoogleMessage3.Message37487.t() | nil,
          field37520: Benchmarks.GoogleMessage3.Message36876.t() | nil,
          field37521: Benchmarks.GoogleMessage3.Message13062.t() | nil,
          field37522: Benchmarks.GoogleMessage3.Message952.t() | nil,
          field37523: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37524: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37525: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37526: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37527: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37528: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37529: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37530: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37531: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37532: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field37533: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field37519: nil,
            field37520: nil,
            field37521: nil,
            field37522: nil,
            field37523: nil,
            field37524: nil,
            field37525: nil,
            field37526: nil,
            field37527: nil,
            field37528: nil,
            field37529: nil,
            field37530: nil,
            field37531: nil,
            field37532: nil,
            field37533: nil

  field :field37519, 2, optional: true, type: Benchmarks.GoogleMessage3.Message37487

  field :field37520, 3, optional: true, type: Benchmarks.GoogleMessage3.Message36876

  field :field37521, 4, optional: true, type: Benchmarks.GoogleMessage3.Message13062

  field :field37522, 5, optional: true, type: Benchmarks.GoogleMessage3.Message952

  field :field37523, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37524, 7, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37525, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37526, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37527, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37528, 11, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37529, 12, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37530, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37531, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37532, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field37533, 16, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message1327 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field1369: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field1370: [Benchmarks.GoogleMessage3.Message1328.t()],
          field1371: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field1372: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct field1369: [],
            field1370: [],
            field1371: [],
            field1372: []

  field :field1369, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field1370, 3, repeated: true, type: Benchmarks.GoogleMessage3.Message1328

  field :field1371, 5, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field1372, 6, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message3672.Message3673 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3738: Benchmarks.GoogleMessage3.Enum3476.t(),
          field3739: integer
        }

  defstruct field3738: 0,
            field3739: 0

  field :field3738, 4, required: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true

  field :field3739, 5, required: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message3672.Message3674 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3740: Benchmarks.GoogleMessage3.Enum3476.t(),
          field3741: integer
        }

  defstruct field3740: 0,
            field3741: 0

  field :field3740, 7, required: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true

  field :field3741, 8, required: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message3672 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3727: Benchmarks.GoogleMessage3.Enum3476.t(),
          field3728: integer,
          field3729: integer,
          message3673: [any],
          message3674: [any],
          field3732: boolean,
          field3733: integer,
          field3734: Benchmarks.GoogleMessage3.Enum3476.t(),
          field3735: integer,
          field3736: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field3727: nil,
            field3728: nil,
            field3729: nil,
            message3673: [],
            message3674: [],
            field3732: nil,
            field3733: nil,
            field3734: nil,
            field3735: nil,
            field3736: nil

  field :field3727, 1, optional: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true

  field :field3728, 11, optional: true, type: :int32

  field :field3729, 2, optional: true, type: :int32

  field :message3673, 3, repeated: true, type: :group

  field :message3674, 6, repeated: true, type: :group

  field :field3732, 9, optional: true, type: :bool

  field :field3733, 10, optional: true, type: :int32

  field :field3734, 20, optional: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true

  field :field3735, 21, optional: true, type: :int32

  field :field3736, 50, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message3804 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field3818: integer,
          field3819: boolean,
          field3820: [Benchmarks.GoogleMessage3.Enum3805.t()],
          field3821: integer,
          field3822: boolean,
          field3823: integer,
          field3824: Benchmarks.GoogleMessage3.Enum3783.t()
        }

  defstruct field3818: 0,
            field3819: false,
            field3820: [],
            field3821: nil,
            field3822: nil,
            field3823: nil,
            field3824: nil

  field :field3818, 1, required: true, type: :int64

  field :field3819, 2, required: true, type: :bool

  field :field3820, 4, repeated: true, type: Benchmarks.GoogleMessage3.Enum3805, enum: true

  field :field3821, 5, optional: true, type: :int32

  field :field3822, 6, optional: true, type: :bool

  field :field3823, 7, optional: true, type: :int64

  field :field3824, 8, optional: true, type: Benchmarks.GoogleMessage3.Enum3783, enum: true

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message6849 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6910: [Benchmarks.GoogleMessage3.Message6850.t()]
        }

  defstruct field6910: []

  field :field6910, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6850

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message6866 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6973: [Benchmarks.GoogleMessage3.Message6863.t()]
        }

  defstruct field6973: []

  field :field6973, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6863

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message6870 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field6991: [Benchmarks.GoogleMessage3.Message6871.t()]
        }

  defstruct field6991: []

  field :field6991, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6871

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message7651 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7685: String.t(),
          field7686: integer,
          field7687: integer,
          field7688: integer,
          field7689: integer,
          field7690: integer,
          field7691: integer,
          field7692: integer,
          field7693: integer,
          field7694: integer,
          field7695: integer,
          field7696: integer,
          field7697: integer,
          field7698: integer,
          field7699: integer,
          field7700: integer,
          field7701: integer,
          field7702: integer,
          field7703: boolean,
          field7704: [integer],
          field7705: [integer],
          field7706: [String.t()],
          field7707: [String.t()],
          field7708: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field7709: integer,
          field7710: integer,
          field7711: integer,
          field7712: integer,
          field7713: integer,
          field7714: integer,
          field7715: [Benchmarks.GoogleMessage3.Message7547.t()],
          field7716: [Benchmarks.GoogleMessage3.Message7547.t()],
          field7717: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field7718: [String.t()],
          field7719: [String.t()],
          field7720: [Benchmarks.GoogleMessage3.Message7648.t()],
          field7721: boolean,
          field7722: boolean,
          field7723: boolean,
          field7724: boolean,
          field7725: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field7726: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field7727: Benchmarks.GoogleMessage3.Enum7654.t(),
          field7728: String.t(),
          field7729: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field7685: nil,
            field7686: nil,
            field7687: nil,
            field7688: nil,
            field7689: nil,
            field7690: nil,
            field7691: nil,
            field7692: nil,
            field7693: nil,
            field7694: nil,
            field7695: nil,
            field7696: nil,
            field7697: nil,
            field7698: nil,
            field7699: nil,
            field7700: nil,
            field7701: nil,
            field7702: nil,
            field7703: nil,
            field7704: [],
            field7705: [],
            field7706: [],
            field7707: [],
            field7708: nil,
            field7709: nil,
            field7710: nil,
            field7711: nil,
            field7712: nil,
            field7713: nil,
            field7714: nil,
            field7715: [],
            field7716: [],
            field7717: [],
            field7718: [],
            field7719: [],
            field7720: [],
            field7721: nil,
            field7722: nil,
            field7723: nil,
            field7724: nil,
            field7725: nil,
            field7726: nil,
            field7727: nil,
            field7728: nil,
            field7729: nil

  field :field7685, 1, optional: true, type: :string

  field :field7686, 2, optional: true, type: :int64

  field :field7687, 3, optional: true, type: :int64

  field :field7688, 4, optional: true, type: :int64

  field :field7689, 5, optional: true, type: :int32

  field :field7690, 6, optional: true, type: :int32

  field :field7691, 7, optional: true, type: :int32

  field :field7692, 8, optional: true, type: :int32

  field :field7693, 9, optional: true, type: :int32

  field :field7694, 10, optional: true, type: :int32

  field :field7695, 11, optional: true, type: :int32

  field :field7696, 12, optional: true, type: :int32

  field :field7697, 13, optional: true, type: :int32

  field :field7698, 14, optional: true, type: :int32

  field :field7699, 15, optional: true, type: :int32

  field :field7700, 16, optional: true, type: :int32

  field :field7701, 17, optional: true, type: :int32

  field :field7702, 18, optional: true, type: :int32

  field :field7703, 19, optional: true, type: :bool

  field :field7704, 20, repeated: true, type: :int32

  field :field7705, 21, repeated: true, type: :int32

  field :field7706, 22, repeated: true, type: :string

  field :field7707, 23, repeated: true, type: :string

  field :field7708, 24, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field7709, 25, optional: true, type: :int32

  field :field7710, 26, optional: true, type: :int32

  field :field7711, 27, optional: true, type: :int32

  field :field7712, 43, optional: true, type: :int32

  field :field7713, 28, optional: true, type: :int32

  field :field7714, 29, optional: true, type: :int32

  field :field7715, 30, repeated: true, type: Benchmarks.GoogleMessage3.Message7547

  field :field7716, 31, repeated: true, type: Benchmarks.GoogleMessage3.Message7547

  field :field7717, 32, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field7718, 33, repeated: true, type: :string

  field :field7719, 34, repeated: true, type: :string

  field :field7720, 35, repeated: true, type: Benchmarks.GoogleMessage3.Message7648

  field :field7721, 36, optional: true, type: :bool

  field :field7722, 37, optional: true, type: :bool

  field :field7723, 38, optional: true, type: :bool

  field :field7724, 39, optional: true, type: :bool

  field :field7725, 40, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field7726, 41, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true

  field :field7727, 42, optional: true, type: Benchmarks.GoogleMessage3.Enum7654, enum: true

  field :field7728, 44, optional: true, type: :string

  field :field7729, 45, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message7864 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field7866: String.t(),
          field7867: String.t(),
          field7868: [Benchmarks.GoogleMessage3.Message7865.t()],
          field7869: [Benchmarks.GoogleMessage3.Message7865.t()],
          field7870: [Benchmarks.GoogleMessage3.Message7865.t()],
          field7871: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()]
        }

  defstruct field7866: nil,
            field7867: nil,
            field7868: [],
            field7869: [],
            field7870: [],
            field7871: []

  field :field7866, 1, optional: true, type: :string

  field :field7867, 2, optional: true, type: :string

  field :field7868, 5, repeated: true, type: Benchmarks.GoogleMessage3.Message7865

  field :field7869, 6, repeated: true, type: Benchmarks.GoogleMessage3.Message7865

  field :field7870, 7, repeated: true, type: Benchmarks.GoogleMessage3.Message7865

  field :field7871, 8, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message7929 do
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
          field7950: [Benchmarks.GoogleMessage3.Message7919.t()],
          field7951: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field7952: [Benchmarks.GoogleMessage3.Message7920.t()],
          field7953: [Benchmarks.GoogleMessage3.Message7921.t()],
          field7954: [Benchmarks.GoogleMessage3.Message7928.t()],
          field7955: integer,
          field7956: boolean,
          field7957: integer,
          field7958: integer,
          field7959: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
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

  field :field7950, 8, repeated: true, type: Benchmarks.GoogleMessage3.Message7919

  field :field7951, 20, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field7952, 14, repeated: true, type: Benchmarks.GoogleMessage3.Message7920

  field :field7953, 15, repeated: true, type: Benchmarks.GoogleMessage3.Message7921

  field :field7954, 17, repeated: true, type: Benchmarks.GoogleMessage3.Message7928

  field :field7955, 19, optional: true, type: :int64

  field :field7956, 2, optional: true, type: :bool

  field :field7957, 3, optional: true, type: :int64

  field :field7958, 9, optional: true, type: :int64

  field :field7959, 10, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field7960, 11, repeated: true, type: :bytes

  field :field7961, 16, optional: true, type: :int64

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message8508 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field8517: [Benchmarks.GoogleMessage3.Message8511.t()],
          field8518: [Benchmarks.GoogleMessage3.Message8512.t()],
          field8519: [Benchmarks.GoogleMessage3.Message8513.t()],
          field8520: boolean,
          field8521: Benchmarks.GoogleMessage3.Message8514.t() | nil,
          field8522: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field8523: [Benchmarks.GoogleMessage3.Message8515.t()],
          field8524: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field8525: integer,
          field8526: float | :infinity | :negative_infinity | :nan,
          field8527: integer,
          field8528: integer,
          field8529: integer,
          field8530: binary,
          field8531: [binary],
          field8532: boolean,
          field8533: binary
        }

  defstruct field8517: [],
            field8518: [],
            field8519: [],
            field8520: nil,
            field8521: nil,
            field8522: [],
            field8523: [],
            field8524: [],
            field8525: nil,
            field8526: nil,
            field8527: nil,
            field8528: nil,
            field8529: nil,
            field8530: nil,
            field8531: [],
            field8532: nil,
            field8533: nil

  field :field8517, 8, repeated: true, type: Benchmarks.GoogleMessage3.Message8511

  field :field8518, 9, repeated: true, type: Benchmarks.GoogleMessage3.Message8512

  field :field8519, 11, repeated: true, type: Benchmarks.GoogleMessage3.Message8513

  field :field8520, 13, optional: true, type: :bool

  field :field8521, 14, optional: true, type: Benchmarks.GoogleMessage3.Message8514

  field :field8522, 15, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field8523, 16, repeated: true, type: Benchmarks.GoogleMessage3.Message8515

  field :field8524, 17, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field8525, 1, optional: true, type: :int64

  field :field8526, 2, optional: true, type: :float

  field :field8527, 3, optional: true, type: :int64

  field :field8528, 4, optional: true, type: :int64

  field :field8529, 5, optional: true, type: :int32

  field :field8530, 6, optional: true, type: :bytes

  field :field8531, 7, repeated: true, type: :bytes

  field :field8532, 10, optional: true, type: :bool

  field :field8533, 12, optional: true, type: :bytes

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message9122 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field9132: float | :infinity | :negative_infinity | :nan,
          field9133: float | :infinity | :negative_infinity | :nan
        }

  defstruct field9132: nil,
            field9133: nil

  field :field9132, 1, optional: true, type: :float

  field :field9133, 2, optional: true, type: :float

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message10177 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10270: [Benchmarks.GoogleMessage3.Message10155.t()]
        }

  defstruct field10270: []

  field :field10270, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10155

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message10278 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10286: [integer],
          field10287: [integer],
          field10288: integer
        }

  defstruct field10286: [],
            field10287: [],
            field10288: nil

  field :field10286, 1, repeated: true, type: :int32, packed: true

  field :field10287, 2, repeated: true, type: :int32, packed: true

  field :field10288, 3, optional: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message10323 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10360: [Benchmarks.GoogleMessage3.Message10320.t()]
        }

  defstruct field10360: []

  field :field10360, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10320

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message10324 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field10362: [Benchmarks.GoogleMessage3.Message10322.t()],
          field10363: Benchmarks.GoogleMessage3.Message10321.t() | nil
        }

  defstruct field10362: [],
            field10363: nil

  field :field10362, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10322

  field :field10363, 2, optional: true, type: Benchmarks.GoogleMessage3.Message10321

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message11990 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12030: [Benchmarks.GoogleMessage3.Message11988.t()]
        }

  defstruct field12030: []

  field :field12030, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message11988

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message12691 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field12713: String.t(),
          field12714: integer,
          field12715: Benchmarks.GoogleMessage3.Message12668.t() | nil
        }

  defstruct field12713: nil,
            field12714: nil,
            field12715: nil

  field :field12713, 1, optional: true, type: :string

  field :field12714, 2, optional: true, type: :int32

  field :field12715, 3, optional: true, type: Benchmarks.GoogleMessage3.Message12668

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message12870 do
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
          field12888: [Benchmarks.GoogleMessage3.Message12870.t()],
          field12889: integer,
          field12890: non_neg_integer,
          field12891: integer,
          field12892: integer,
          field12893: float | :infinity | :negative_infinity | :nan,
          field12894: Benchmarks.GoogleMessage3.Message12825.t() | nil,
          field12895: float | :infinity | :negative_infinity | :nan,
          field12896: String.t(),
          field12897: Benchmarks.GoogleMessage3.Enum12871.t(),
          field12898: integer
        }

  defstruct field12879: 0,
            field12880: nil,
            field12881: 0,
            field12882: nil,
            field12883: nil,
            field12884: nil,
            field12885: [],
            field12886: nil,
            field12887: nil,
            field12888: [],
            field12889: nil,
            field12890: nil,
            field12891: nil,
            field12892: nil,
            field12893: nil,
            field12894: nil,
            field12895: nil,
            field12896: nil,
            field12897: nil,
            field12898: nil

  field :field12879, 1, required: true, type: :int32

  field :field12880, 7, optional: true, type: :int32

  field :field12881, 2, required: true, type: :int32

  field :field12882, 3, optional: true, type: :uint64

  field :field12883, 2001, optional: true, type: :string

  field :field12884, 4, optional: true, type: :fixed64

  field :field12885, 14, repeated: true, type: :fixed64

  field :field12886, 9, optional: true, type: :int32

  field :field12887, 18, optional: true, type: :int64

  field :field12888, 8, repeated: true, type: Benchmarks.GoogleMessage3.Message12870

  field :field12889, 5, optional: true, type: :int32

  field :field12890, 6, optional: true, type: :uint64

  field :field12891, 10, optional: true, type: :int32

  field :field12892, 11, optional: true, type: :int32

  field :field12893, 12, optional: true, type: :double

  field :field12894, 13, optional: true, type: Benchmarks.GoogleMessage3.Message12825

  field :field12895, 15, optional: true, type: :double

  field :field12896, 16, optional: true, type: :string

  field :field12897, 17, optional: true, type: Benchmarks.GoogleMessage3.Enum12871, enum: true

  field :field12898, 19, optional: true, type: :int32

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message13154 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field13164: float | :infinity | :negative_infinity | :nan,
          field13165: float | :infinity | :negative_infinity | :nan
        }

  defstruct field13164: 0.0,
            field13165: 0.0

  field :field13164, 1, required: true, type: :float

  field :field13165, 2, required: true, type: :float

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message16507 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16510: boolean,
          field16511: boolean,
          field16512: boolean,
          field16513: [String.t()],
          field16514: [String.t()],
          field16515: String.t(),
          field16516: [integer],
          field16517: [integer],
          field16518: integer,
          field16519: String.t(),
          field16520: [String.t()],
          field16521: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16522: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16523: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field16524: String.t(),
          field16525: integer,
          field16526: integer,
          field16527: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field16528: boolean,
          field16529: [String.t()],
          field16530: float | :infinity | :negative_infinity | :nan,
          field16531: Benchmarks.GoogleMessage3.Message16478.t() | nil,
          field16532: boolean,
          field16533: String.t(),
          field16534: boolean,
          field16535: boolean,
          field16536: boolean,
          field16537: boolean,
          field16538: boolean,
          field16539: boolean,
          field16540: boolean,
          field16541: [String.t()],
          __pb_extensions__: map
        }

  defstruct field16510: nil,
            field16511: nil,
            field16512: nil,
            field16513: [],
            field16514: [],
            field16515: nil,
            field16516: [],
            field16517: [],
            field16518: nil,
            field16519: nil,
            field16520: [],
            field16521: [],
            field16522: [],
            field16523: [],
            field16524: nil,
            field16525: nil,
            field16526: nil,
            field16527: nil,
            field16528: nil,
            field16529: [],
            field16530: nil,
            field16531: nil,
            field16532: nil,
            field16533: nil,
            field16534: nil,
            field16535: nil,
            field16536: nil,
            field16537: nil,
            field16538: nil,
            field16539: nil,
            field16540: nil,
            field16541: [],
            __pb_extensions__: nil

  field :field16510, 3, optional: true, type: :bool

  field :field16511, 4, optional: true, type: :bool

  field :field16512, 14, optional: true, type: :bool

  field :field16513, 5, repeated: true, type: :string

  field :field16514, 6, repeated: true, type: :string

  field :field16515, 8, optional: true, type: :string

  field :field16516, 9, repeated: true, type: :int32

  field :field16517, 10, repeated: true, type: :int32

  field :field16518, 7, optional: true, type: :int32

  field :field16519, 15, optional: true, type: :string

  field :field16520, 11, repeated: true, type: :string

  field :field16521, 27, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field16522, 22, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field16523, 28, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field16524, 18, optional: true, type: :string

  field :field16525, 19, optional: true, type: :int32

  field :field16526, 20, optional: true, type: :int32

  field :field16527, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field16528, 24, optional: true, type: :bool

  field :field16529, 25, repeated: true, type: :string

  field :field16530, 26, optional: true, type: :double

  field :field16531, 30, optional: true, type: Benchmarks.GoogleMessage3.Message16478

  field :field16532, 31, optional: true, type: :bool

  field :field16533, 32, optional: true, type: :string

  field :field16534, 33, optional: true, type: :bool

  field :field16535, 35, optional: true, type: :bool

  field :field16536, 36, optional: true, type: :bool

  field :field16537, 37, optional: true, type: :bool

  field :field16538, 38, optional: true, type: :bool

  field :field16539, 39, optional: true, type: :bool

  field :field16540, 40, optional: true, type: :bool

  field :field16541, 41, repeated: true, type: :string

  def transform_module(), do: nil

  extensions [{21, 22}]
end
defmodule Benchmarks.GoogleMessage3.Message16564 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16568: [Benchmarks.GoogleMessage3.Message16552.t()]
        }

  defstruct field16568: []

  field :field16568, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16552

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message16661 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16671: [Benchmarks.GoogleMessage3.Message16660.t()],
          field16672: [non_neg_integer]
        }

  defstruct field16671: [],
            field16672: []

  field :field16671, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16660

  field :field16672, 2, repeated: true, type: :uint64

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message16746 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field16806: [Benchmarks.GoogleMessage3.Message16727.t()],
          field16807: boolean,
          field16808: boolean,
          field16809: [Benchmarks.GoogleMessage3.Message16725.t()]
        }

  defstruct field16806: [],
            field16807: nil,
            field16808: nil,
            field16809: []

  field :field16806, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16727

  field :field16807, 2, optional: true, type: :bool

  field :field16808, 3, optional: true, type: :bool

  field :field16809, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message16725

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message17786.Message17787 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field18177: integer,
          field18178: integer,
          field18179: Benchmarks.GoogleMessage3.Message17783.t() | nil,
          field18180: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18181: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18182: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field18183: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18184: Benchmarks.GoogleMessage3.Message17726.t() | nil,
          field18185: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18186: Benchmarks.GoogleMessage3.Message16945.t() | nil,
          field18187: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18188: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18189: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18190: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18191: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18192: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18193: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18194: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18195: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18196: Benchmarks.GoogleMessage3.Enum16925.t(),
          field18197: boolean,
          field18198: [Benchmarks.GoogleMessage3.UnusedEnum.t()],
          field18199: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field18200: String.t(),
          field18201: String.t(),
          field18202: boolean
        }

  defstruct field18177: 0,
            field18178: 0,
            field18179: nil,
            field18180: nil,
            field18181: nil,
            field18182: [],
            field18183: nil,
            field18184: nil,
            field18185: nil,
            field18186: nil,
            field18187: nil,
            field18188: nil,
            field18189: nil,
            field18190: nil,
            field18191: nil,
            field18192: nil,
            field18193: nil,
            field18194: nil,
            field18195: nil,
            field18196: nil,
            field18197: nil,
            field18198: [],
            field18199: nil,
            field18200: nil,
            field18201: nil,
            field18202: nil

  field :field18177, 2, required: true, type: :int32

  field :field18178, 3, required: true, type: :int32

  field :field18179, 4, optional: true, type: Benchmarks.GoogleMessage3.Message17783

  field :field18180, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18181, 6, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18182, 8, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18183, 9, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18184, 10, optional: true, type: Benchmarks.GoogleMessage3.Message17726

  field :field18185, 11, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18186, 102, optional: true, type: Benchmarks.GoogleMessage3.Message16945

  field :field18187, 12, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18188, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18189, 7, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18190, 100, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18191, 101, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18192, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18193, 19, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18194, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18195, 24, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18196, 21, optional: true, type: Benchmarks.GoogleMessage3.Enum16925, enum: true

  field :field18197, 18, optional: true, type: :bool

  field :field18198, 23, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true

  field :field18199, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field18200, 16, optional: true, type: :string

  field :field18201, 17, optional: true, type: :string

  field :field18202, 99, optional: true, type: :bool

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message17786 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message17787: [any],
          field18175: [Benchmarks.GoogleMessage3.Message17782.t()]
        }

  defstruct message17787: [],
            field18175: []

  field :message17787, 1, repeated: true, type: :group

  field :field18175, 20, repeated: true, type: Benchmarks.GoogleMessage3.Message17782

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message22857 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field22874: [Benchmarks.GoogleMessage3.Message22853.t()]
        }

  defstruct field22874: []

  field :field22874, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message22853

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message24404.Message24405 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field24686: integer,
          field24687: integer,
          field24688: Benchmarks.GoogleMessage3.Message24317.t() | nil,
          field24689: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24690: Benchmarks.GoogleMessage3.Message24376.t() | nil,
          field24691: Benchmarks.GoogleMessage3.Message24345.t() | nil,
          field24692: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24693: Benchmarks.GoogleMessage3.Message24379.t() | nil,
          field24694: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24695: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24696: Benchmarks.GoogleMessage3.Message24391.t() | nil,
          field24697: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24698: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24699: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24700: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24701: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24702: Benchmarks.GoogleMessage3.Enum16925.t(),
          field24703: float | :infinity | :negative_infinity | :nan,
          field24704: boolean,
          field24705: [Benchmarks.GoogleMessage3.Enum16891.t()],
          field24706: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field24707: String.t(),
          field24708: String.t(),
          field24709: float | :infinity | :negative_infinity | :nan,
          field24710: boolean,
          field24711: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24712: boolean,
          field24713: Benchmarks.GoogleMessage3.UnusedEnum.t(),
          field24714: boolean,
          field24715: boolean,
          field24716: integer
        }

  defstruct field24686: 0,
            field24687: 0,
            field24688: nil,
            field24689: nil,
            field24690: nil,
            field24691: nil,
            field24692: nil,
            field24693: nil,
            field24694: nil,
            field24695: nil,
            field24696: nil,
            field24697: nil,
            field24698: nil,
            field24699: nil,
            field24700: nil,
            field24701: nil,
            field24702: nil,
            field24703: nil,
            field24704: nil,
            field24705: [],
            field24706: nil,
            field24707: nil,
            field24708: nil,
            field24709: nil,
            field24710: nil,
            field24711: nil,
            field24712: nil,
            field24713: nil,
            field24714: nil,
            field24715: nil,
            field24716: nil

  field :field24686, 2, required: true, type: :int32

  field :field24687, 3, required: true, type: :int32

  field :field24688, 4, optional: true, type: Benchmarks.GoogleMessage3.Message24317

  field :field24689, 5, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24690, 6, optional: true, type: Benchmarks.GoogleMessage3.Message24376

  field :field24691, 7, optional: true, type: Benchmarks.GoogleMessage3.Message24345

  field :field24692, 8, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24693, 9, optional: true, type: Benchmarks.GoogleMessage3.Message24379

  field :field24694, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24695, 11, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24696, 12, optional: true, type: Benchmarks.GoogleMessage3.Message24391

  field :field24697, 13, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24698, 14, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24699, 22, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24700, 23, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24701, 25, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24702, 18, optional: true, type: Benchmarks.GoogleMessage3.Enum16925, enum: true

  field :field24703, 20, optional: true, type: :float

  field :field24704, 19, optional: true, type: :bool

  field :field24705, 24, repeated: true, type: Benchmarks.GoogleMessage3.Enum16891, enum: true

  field :field24706, 15, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field24707, 16, optional: true, type: :string

  field :field24708, 17, optional: true, type: :string

  field :field24709, 21, optional: true, type: :float

  field :field24710, 26, optional: true, type: :bool

  field :field24711, 27, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true

  field :field24712, 28, optional: true, type: :bool

  field :field24713, 29, optional: true, type: Benchmarks.GoogleMessage3.UnusedEnum, enum: true

  field :field24714, 31, optional: true, type: :bool

  field :field24715, 99, optional: true, type: :bool

  field :field24716, 32, optional: true, type: :int64

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message24404 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message24405: [any],
          field24684: Benchmarks.GoogleMessage3.Message24403.t() | nil
        }

  defstruct message24405: [],
            field24684: nil

  field :message24405, 1, repeated: true, type: :group

  field :field24684, 30, optional: true, type: Benchmarks.GoogleMessage3.Message24403

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message27300 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field27302: [Benchmarks.GoogleMessage3.UnusedEmptyMessage.t()],
          field27303: String.t()
        }

  defstruct field27302: [],
            field27303: nil

  field :field27302, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field27303, 2, optional: true, type: :string

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.Message27453 do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          field27459: String.t(),
          field27460: [String.t()],
          field27461: [float | :infinity | :negative_infinity | :nan],
          field27462: [integer],
          field27463: [integer],
          field27464: [Benchmarks.GoogleMessage3.Message27454.t()],
          field27465: [String.t()],
          field27466: [float | :infinity | :negative_infinity | :nan],
          field27467: [String.t()],
          field27468: [String.t()],
          field27469: String.t(),
          field27470: [Benchmarks.GoogleMessage3.Message27357.t()],
          field27471: Benchmarks.GoogleMessage3.Message27360.t() | nil,
          field27472: String.t(),
          field27473: String.t(),
          field27474: boolean,
          field27475: boolean,
          field27476: boolean,
          field27477: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil,
          field27478: boolean,
          field27479: boolean,
          field27480: String.t(),
          field27481: Benchmarks.GoogleMessage3.UnusedEmptyMessage.t() | nil
        }

  defstruct field27459: nil,
            field27460: [],
            field27461: [],
            field27462: [],
            field27463: [],
            field27464: [],
            field27465: [],
            field27466: [],
            field27467: [],
            field27468: [],
            field27469: nil,
            field27470: [],
            field27471: nil,
            field27472: nil,
            field27473: nil,
            field27474: nil,
            field27475: nil,
            field27476: nil,
            field27477: nil,
            field27478: nil,
            field27479: nil,
            field27480: nil,
            field27481: nil

  field :field27459, 15, optional: true, type: :string

  field :field27460, 1, repeated: true, type: :string

  field :field27461, 6, repeated: true, type: :float

  field :field27462, 27, repeated: true, type: :int32

  field :field27463, 28, repeated: true, type: :int32

  field :field27464, 24, repeated: true, type: Benchmarks.GoogleMessage3.Message27454

  field :field27465, 2, repeated: true, type: :string

  field :field27466, 7, repeated: true, type: :float

  field :field27467, 22, repeated: true, type: :string

  field :field27468, 23, repeated: true, type: :string

  field :field27469, 26, optional: true, type: :string

  field :field27470, 8, repeated: true, type: Benchmarks.GoogleMessage3.Message27357

  field :field27471, 16, optional: true, type: Benchmarks.GoogleMessage3.Message27360

  field :field27472, 25, optional: true, type: :string

  field :field27473, 11, optional: true, type: :string

  field :field27474, 13, optional: true, type: :bool

  field :field27475, 14, optional: true, type: :bool

  field :field27476, 17, optional: true, type: :bool

  field :field27477, 12, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  field :field27478, 34_268_945, optional: true, type: :bool

  field :field27479, 20, optional: true, type: :bool

  field :field27480, 21, optional: true, type: :string

  field :field27481, 10, optional: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage

  def transform_module(), do: nil
end
defmodule Benchmarks.GoogleMessage3.PbExtension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  extend Benchmarks.GoogleMessage3.Message16945, :field17026, 472, optional: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17027, 818, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17031, 215,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17032, 292,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17038, 234,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17039, 235,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17042, 246,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17043, 224, optional: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17044, 225, optional: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17048, 63, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17049, 64, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17052, 233,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17053, 66,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17056, 275, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17057, 226, optional: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17060, 27,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17073, 75, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17076, 77,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17078, 296, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17082, 160,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17091, 585,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17098, 987,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17101, 157,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17102, 158, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17107, 166, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17133, 567, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17134, 572, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17160, 49, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17168, 32, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17170, 34, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17172, 509,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17174, 39, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17175, 40,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17178, 511,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17185, 50,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17207, 1081, repeated: true, type: :int32

  extend Benchmarks.GoogleMessage3.Message16945, :field17238, 184,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17289, 177,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17290, 178,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17296, 474,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17298, 44, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17301, 47,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17412, 21,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17438, 132,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17458, 512,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17460, 560, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17466, 552, repeated: true, type: :string

  extend Benchmarks.GoogleMessage3.Message16945, :field17617, 1080,
    repeated: true,
    type: Benchmarks.GoogleMessage3.Message0

  extend Benchmarks.GoogleMessage3.Message16945, :field17618, 1084, repeated: true, type: :int32

  extend Benchmarks.GoogleMessage3.Message0, :"Message27300.field27304", 24_956_467,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message27300

  extend Benchmarks.GoogleMessage3.Message0, :"Message24404.field24685", 9_129_287,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message24404

  extend Benchmarks.GoogleMessage3.Message0, :"Message16746.field16810", 28_406_765,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message16746

  extend Benchmarks.GoogleMessage3.Message0, :"Message16564.field16569", 25_830_030,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message16564

  extend Benchmarks.GoogleMessage3.Message13145, :"Message13154.field13166", 47_301_086,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message13154

  extend Benchmarks.GoogleMessage3.Message0, :"Message12691.field12716", 28_426_536,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message12691

  extend Benchmarks.GoogleMessage3.Message10155, :"Message10324.field10364", 27_832_297,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message10324

  extend Benchmarks.GoogleMessage3.Message10155, :"Message10278.field10289", 29_374_161,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message10278

  extend Benchmarks.GoogleMessage3.Message0, :"Message9122.field9134", 120_398_939,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message9122

  extend Benchmarks.GoogleMessage3.Message0, :"Message7929.field7962", 53_392_238,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message7929

  extend Benchmarks.GoogleMessage3.Message0, :"Message7651.field7730", 55_876_009,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message7651

  extend Benchmarks.GoogleMessage3.Message0, :"Message6866.field6974", 22_259_060,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message6866

  extend Benchmarks.GoogleMessage3.Message0, :"Message3804.field3825", 59_241_828,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message3804

  extend Benchmarks.GoogleMessage3.Message0, :"Message3672.field3737", 3_144_435,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message3672

  extend Benchmarks.GoogleMessage3.Message0, :"Message1327.field1373", 23_104_162,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message1327

  extend Benchmarks.GoogleMessage3.Message0, :"Message6849.field6911", 107_558_455,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message6849

  extend Benchmarks.GoogleMessage3.Message0, :"Message6870.field6992", 90_034_652,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message6870

  extend Benchmarks.GoogleMessage3.Message0, :"Message7864.field7872", 44_542_730,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message7864

  extend Benchmarks.GoogleMessage3.Message0, :"Message8508.field8534", 3_811_804,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message8508

  extend Benchmarks.GoogleMessage3.Message0, :"Message10177.field10271", 26_801_105,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message10177

  extend Benchmarks.GoogleMessage3.Message10155, :"Message10323.field10361", 27_922_524,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message10323

  extend Benchmarks.GoogleMessage3.Message0, :"Message11990.field12031", 21_265_426,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message11990

  extend Benchmarks.GoogleMessage3.Message0, :"Message12870.field12899", 5_447_656,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message12870

  extend Benchmarks.GoogleMessage3.Message0, :"Message16507.field16542", 5_569_941,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message16507

  extend Benchmarks.GoogleMessage3.Message0, :"Message16661.field16673", 31_274_398,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message16661

  extend Benchmarks.GoogleMessage3.Message0, :"Message17786.field18176", 11_823_055,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message17786

  extend Benchmarks.GoogleMessage3.Message10155, :"Message22857.field22875", 67_799_715,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message22857

  extend Benchmarks.GoogleMessage3.Message0, :"Message27453.field27482", 8_086_204,
    optional: true,
    type: Benchmarks.GoogleMessage3.Message27453
end
