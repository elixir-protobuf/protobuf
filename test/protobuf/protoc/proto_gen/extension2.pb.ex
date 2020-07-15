defmodule Ext.TrafficLightColor do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :TRAFFIC_LIGHT_COLOR_INVALID
          | :TRAFFIC_LIGHT_COLOR_UNSET
          | :TRAFFIC_LIGHT_COLOR_GREEN
          | :TRAFFIC_LIGHT_COLOR_YELLOW
          | :TRAFFIC_LIGHT_COLOR_RED

  field :TRAFFIC_LIGHT_COLOR_INVALID, 0
  field :TRAFFIC_LIGHT_COLOR_UNSET, 1
  field :TRAFFIC_LIGHT_COLOR_GREEN, 2
  field :TRAFFIC_LIGHT_COLOR_YELLOW, 3
  field :TRAFFIC_LIGHT_COLOR_RED, 4
end

defmodule Ext.Nested do
  @moduledoc false
  use Protobuf, custom_field_options?: true, syntax: :proto3

  @type t :: %__MODULE__{
          my_timestamp: {atom, any}
        }
  defstruct [:my_timestamp]

  oneof :my_timestamp, 0

  field :dt, 1, type: Google.Protobuf.Timestamp, oneof: 0, options: [extype: "DateTime.t"]
  field :ndt, 2, type: Google.Protobuf.Timestamp, oneof: 0, options: [extype: "NaiveDateTime.t"]
end

defmodule Ext.MyMessage do
  @moduledoc false
  use Protobuf, custom_field_options?: true, syntax: :proto3

  @type t :: %__MODULE__{
          enums_oneof: {atom, any},
          f1: float | nil,
          f2: float | nil,
          f3: integer | nil,
          f4: non_neg_integer | nil,
          f5: integer | nil,
          f6: non_neg_integer | nil,
          f7: boolean | nil,
          f8: String.t() | nil,
          f9: String.t() | nil,
          no_extype: Google.Protobuf.StringValue.t() | nil,
          repeated_field: [String.t()],
          normal1: non_neg_integer,
          normal2: String.t(),
          nested: Ext.Nested.t() | nil,
          color: Ext.TrafficLightColor.t(),
          color_lc: Ext.TrafficLightColor.t(),
          color_depr: Ext.TrafficLightColor.t(),
          color_atom: Ext.TrafficLightColor.t(),
          color_repeated: [Ext.TrafficLightColor.t()],
          color_repeated_normal: [[Ext.TrafficLightColor.t()]],
          normal3: [String.t()]
        }
  defstruct [
    :enums_oneof,
    :f1,
    :f2,
    :f3,
    :f4,
    :f5,
    :f6,
    :f7,
    :f8,
    :f9,
    :no_extype,
    :repeated_field,
    :normal1,
    :normal2,
    :nested,
    :color,
    :color_lc,
    :color_depr,
    :color_atom,
    :color_repeated,
    :color_repeated_normal,
    :normal3
  ]

  oneof :enums_oneof, 0

  field :f1, 1, type: Google.Protobuf.DoubleValue, options: [extype: "float"]
  field :f2, 2, type: Google.Protobuf.FloatValue, options: [extype: "float"]
  field :f3, 3, type: Google.Protobuf.Int64Value, options: [extype: "integer"]
  field :f4, 4, type: Google.Protobuf.UInt64Value, options: [extype: "non_neg_integer"]
  field :f5, 5, type: Google.Protobuf.Int32Value, options: [extype: "integer"]
  field :f6, 6, type: Google.Protobuf.UInt32Value, options: [extype: "non_neg_integer"]
  field :f7, 7, type: Google.Protobuf.BoolValue, options: [extype: "boolean"]
  field :f8, 8, type: Google.Protobuf.StringValue, options: [extype: "String.t"]
  field :f9, 9, type: Google.Protobuf.BytesValue, options: [extype: "String.t()"]
  field :no_extype, 10, type: Google.Protobuf.StringValue, json_name: "noExtype"

  field :repeated_field, 11,
    repeated: true,
    type: Google.Protobuf.StringValue,
    json_name: "repeatedField",
    options: [extype: "String.t"]

  field :normal1, 12, type: :uint64
  field :normal2, 13, type: :string
  field :nested, 14, type: Ext.Nested
  field :color, 15, type: Ext.TrafficLightColor, enum: true

  field :color_lc, 16,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorLc",
    options: [enum: "lowercase"]

  field :color_depr, 17,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorDepr",
    options: [enum: "deprefix"]

  field :color_atom, 18,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorAtom",
    options: [enum: "atomize"]

  field :color_repeated, 19,
    repeated: true,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorRepeated",
    options: [enum: "atomize"]

  field :color_repeated_normal, 20,
    repeated: true,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorRepeatedNormal"

  field :normal3, 21, repeated: true, type: :string

  field :color_oneof, 22,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorOneof",
    oneof: 0

  field :color_oneof_atom, 23,
    type: Ext.TrafficLightColor,
    enum: true,
    json_name: "colorOneofAtom",
    oneof: 0,
    options: [enum: "atomize"]
end
