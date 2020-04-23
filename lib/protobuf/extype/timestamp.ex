defmodule Protobuf.Extype.Timestamp do
  @moduledoc """
  Implement DateTime and NaiveDateTime casting for Google Timestamp.
  """

  def validate_extype!(Google.Protobuf.Timestamp, "NaiveDateTime.t"), do: :naivedatetime
  def validate_extype!(Google.Protobuf.Timestamp, "NaiveDateTime.t()"), do: :naivedatetime
  def validate_extype!(Google.Protobuf.Timestamp, "DateTime.t"), do: :datetime
  def validate_extype!(Google.Protobuf.Timestamp, "DateTime.t()"), do: :datetime
  def validate_extype!(type, extype) do
    raise "Invalid extype pairing, #{extype} not compatible with #{type}. " <>
      "Supported types are DateTime.t() or NaiveDateTime.t()"
  end

  def validate_extype_string!("Google.Protobuf.Timestamp", "NaiveDateTime.t"), do: "NaiveDateTime.t"
  def validate_extype_string!("Google.Protobuf.Timestamp", "NaiveDateTime.t()"), do: "NaiveDateTime.t()"
  def validate_extype_string!("Google.Protobuf.Timestamp", "DateTime.t"), do: "DateTime.t"
  def validate_extype_string!("Google.Protobuf.Timestamp", "DateTime.t()"), do: "DateTime.t()"
  def validate_extype_string!(type, extype) do
    raise "Invalid extype pairing, #{extype} not compatible with #{type}. " <>
      "Supported types are DateTime.t() or NaiveDateTime.t()"
  end

  def do_type_default(type, extype) do
    validate_extype!(type, extype)
    nil
  end

  def do_type_to_spec(type, repeated, extype) do
    string_type = validate_extype_string!(type, extype)

    if repeated do
      "[#{string_type}]"
    else
      string_type <> " | nil"
    end
  end

  def do_new(type, value, extype) do
    validate_extype!(type, extype)
    value
  end

  def do_encode_type(type, v, extype) do
    atom_type = validate_extype!(type, extype)

    v = if atom_type == :naivedatetime, do: DateTime.from_naive!(v, "Etc/UTC"), else: v

    unix = DateTime.to_unix(v, :nanosecond)

    seconds = System.convert_time_unit(unix, :nanosecond, :second)
    nanos = unix - System.convert_time_unit(seconds, :second, :nanosecond)

    value = Google.Protobuf.Timestamp.new(seconds: seconds, nanos: nanos)

    Protobuf.encode(value)
  end

  def do_decode_type(type, val, extype) do
    atom_type = validate_extype!(type, extype)

    protobuf_timestamp = Protobuf.decode(val, type)

    value =
      protobuf_timestamp.seconds
      |> System.convert_time_unit(:second, :nanosecond)
      |> Kernel.+(protobuf_timestamp.nanos)
      |> DateTime.from_unix!(:nanosecond)

    if atom_type == :naivedatetime, do: DateTime.to_naive(value), else: value
  end
end
