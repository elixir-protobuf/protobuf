defmodule Protobuf.Extype.Wrappers do
  @moduledoc """
  Implement value unwrapping for Google Wrappers.
  """

  require Protobuf.Decoder
  require Logger
  import Protobuf.Decoder, only: [decode_zigzag: 1]

  def validate_extype!(Google.Protobuf.DoubleValue, "float"), do: :double
  def validate_extype!(Google.Protobuf.FloatValue, "float"), do: :float
  def validate_extype!(Google.Protobuf.Int64Value, "integer"), do: :int64
  def validate_extype!(Google.Protobuf.UInt64Value, "non_neg_integer"), do: :uint64
  def validate_extype!(Google.Protobuf.Int32Value, "integer"), do: :int32
  def validate_extype!(Google.Protobuf.UInt32Value, "non_neg_integer"), do: :uint32
  def validate_extype!(Google.Protobuf.BoolValue, "boolean"), do: :bool
  def validate_extype!(Google.Protobuf.StringValue, "String.t"), do: :string
  def validate_extype!(Google.Protobuf.StringValue, "String.t()"), do: :string
  def validate_extype!(Google.Protobuf.BytesValue, "String.t"), do: :bytes
  def validate_extype!(Google.Protobuf.BytesValue, "String.t()"), do: :bytes
  def validate_extype!(type, extype) do
    raise "Invalid extype pairing, #{extype} not compatible with #{type}"
  end

  def validate_extype_string!("Google.Protobuf.DoubleValue", "float"), do: "float"
  def validate_extype_string!("Google.Protobuf.FloatValue", "float"), do: "float"
  def validate_extype_string!("Google.Protobuf.Int64Value", "integer"), do: "integer"
  def validate_extype_string!("Google.Protobuf.UInt64Value", "non_neg_integer"), do: "non_neg_integer"
  def validate_extype_string!("Google.Protobuf.Int32Value", "integer"), do: "integer"
  def validate_extype_string!("Google.Protobuf.UInt32Value", "non_neg_integer"), do: "non_neg_integer"
  def validate_extype_string!("Google.Protobuf.BoolValue", "boolean"), do: "boolean"
  def validate_extype_string!("Google.Protobuf.StringValue", "String.t"), do: "String.t"
  def validate_extype_string!("Google.Protobuf.StringValue", "String.t()"), do: "String.t()"
  def validate_extype_string!("Google.Protobuf.BytesValue", "String.t"), do: "String.t"
  def validate_extype_string!("Google.Protobuf.BytesValue", "String.t()"), do: "String.t()"
  def validate_extype_string!(type, extype) do
    raise "Invalid extype pairing, #{extype} not compatible with #{type}"
  end

  def do_type_default(type, extype) do
    validate_extype!(type, extype)
    nil
  end

  def do_type_to_spec(type, extype) do
    string_type = validate_extype_string!(type, extype)
    string_type <> " | nil"
  end

  def do_new(type, value, extype) do
    validate_extype!(type, extype)
    # No type check, just shape check.
    if is_map(value) or is_list(value) do
      raise "When extype option is present, new expects unwrapped value, not struct."
    else
      value
    end
  end

  def do_encode_type(type, v, extype) do
    atom_type = validate_extype!(type, extype)
    fnum = type.__message_props__.field_props[1].encoded_fnum
    encoded = Protobuf.Encoder.encode_type(atom_type, v)
    IO.iodata_to_binary([[fnum, encoded]])
  end

  def do_decode_type(type, val, extype) do
    atom_type = validate_extype!(type, extype)
    [_tag, _wire, val | _rest] = Protobuf.Decoder.decode_raw(val)
    Protobuf.Decoder.decode_type_m(atom_type, :value, val)
  end
end
