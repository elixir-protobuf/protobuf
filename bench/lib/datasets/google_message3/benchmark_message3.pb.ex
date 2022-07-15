defmodule Benchmarks.GoogleMessage3.GoogleMessage3 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message1327 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field1369, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field1370, 3, repeated: true, type: Benchmarks.GoogleMessage3.Message1328
  field :field1371, 5, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field1372, 6, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message3672.Message3673 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field3738, 4, required: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true
  field :field3739, 5, required: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message3672.Message3674 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field3740, 7, required: true, type: Benchmarks.GoogleMessage3.Enum3476, enum: true
  field :field3741, 8, required: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message3672 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message3804 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field3818, 1, required: true, type: :int64
  field :field3819, 2, required: true, type: :bool
  field :field3820, 4, repeated: true, type: Benchmarks.GoogleMessage3.Enum3805, enum: true
  field :field3821, 5, optional: true, type: :int32
  field :field3822, 6, optional: true, type: :bool
  field :field3823, 7, optional: true, type: :int64
  field :field3824, 8, optional: true, type: Benchmarks.GoogleMessage3.Enum3783, enum: true
end

defmodule Benchmarks.GoogleMessage3.Message6849 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field6910, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6850
end

defmodule Benchmarks.GoogleMessage3.Message6866 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field6973, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6863
end

defmodule Benchmarks.GoogleMessage3.Message6870 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field6991, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message6871
end

defmodule Benchmarks.GoogleMessage3.Message7651 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message7864 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field7866, 1, optional: true, type: :string
  field :field7867, 2, optional: true, type: :string
  field :field7868, 5, repeated: true, type: Benchmarks.GoogleMessage3.Message7865
  field :field7869, 6, repeated: true, type: Benchmarks.GoogleMessage3.Message7865
  field :field7870, 7, repeated: true, type: Benchmarks.GoogleMessage3.Message7865
  field :field7871, 8, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
end

defmodule Benchmarks.GoogleMessage3.Message7929 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message8508 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message9122 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field9132, 1, optional: true, type: :float
  field :field9133, 2, optional: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message10177 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field10270, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10155
end

defmodule Benchmarks.GoogleMessage3.Message10278 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field10286, 1, repeated: true, type: :int32, packed: true, deprecated: false
  field :field10287, 2, repeated: true, type: :int32, packed: true, deprecated: false
  field :field10288, 3, optional: true, type: :int32
end

defmodule Benchmarks.GoogleMessage3.Message10323 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field10360, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10320
end

defmodule Benchmarks.GoogleMessage3.Message10324 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field10362, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message10322
  field :field10363, 2, optional: true, type: Benchmarks.GoogleMessage3.Message10321
end

defmodule Benchmarks.GoogleMessage3.Message11990 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field12030, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message11988
end

defmodule Benchmarks.GoogleMessage3.Message12691 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field12713, 1, optional: true, type: :string
  field :field12714, 2, optional: true, type: :int32
  field :field12715, 3, optional: true, type: Benchmarks.GoogleMessage3.Message12668
end

defmodule Benchmarks.GoogleMessage3.Message12870 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message13154 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field13164, 1, required: true, type: :float
  field :field13165, 2, required: true, type: :float
end

defmodule Benchmarks.GoogleMessage3.Message16507 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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

  extensions [{21, 22}]
end

defmodule Benchmarks.GoogleMessage3.Message16564 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field16568, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16552
end

defmodule Benchmarks.GoogleMessage3.Message16661 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field16671, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16660
  field :field16672, 2, repeated: true, type: :uint64
end

defmodule Benchmarks.GoogleMessage3.Message16746 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field16806, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message16727
  field :field16807, 2, optional: true, type: :bool
  field :field16808, 3, optional: true, type: :bool
  field :field16809, 4, repeated: true, type: Benchmarks.GoogleMessage3.Message16725
end

defmodule Benchmarks.GoogleMessage3.Message17786.Message17787 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message17786 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :message17787, 1, repeated: true, type: :group
  field :field18175, 20, repeated: true, type: Benchmarks.GoogleMessage3.Message17782
end

defmodule Benchmarks.GoogleMessage3.Message22857 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field22874, 1, repeated: true, type: Benchmarks.GoogleMessage3.Message22853
end

defmodule Benchmarks.GoogleMessage3.Message24404.Message24405 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.Message24404 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :message24405, 1, repeated: true, type: :group
  field :field24684, 30, optional: true, type: Benchmarks.GoogleMessage3.Message24403
end

defmodule Benchmarks.GoogleMessage3.Message27300 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

  field :field27302, 1, repeated: true, type: Benchmarks.GoogleMessage3.UnusedEmptyMessage
  field :field27303, 2, optional: true, type: :string
end

defmodule Benchmarks.GoogleMessage3.Message27453 do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
end

defmodule Benchmarks.GoogleMessage3.PbExtension do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.1-dev", syntax: :proto2

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
