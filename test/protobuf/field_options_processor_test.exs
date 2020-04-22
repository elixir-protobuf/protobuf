defmodule Protobuf.FieldOptionsProcessorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Protobuf.FieldOptionsProcessor

  test "type_to_spec String.t and StringValue" do
    extype = "String.t"
    assert FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.StringValue", false, [extype: extype]) ==
      extype <> " | nil"
  end

  test "type_to_spec String.t() and StringValue" do
    extype = "String.t()"
    assert FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.StringValue", false, [extype: extype]) ==
      extype <> " | nil"
  end

  test "type_to_spec repeated" do
    extype = "String.t()"
    assert FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.StringValue", true, [extype: extype]) ==
      "[String.t() | nil]"
  end

  test "type_to_spec invalid extype" do
    extype = "integer"
    assert_raise RuntimeError, "Invalid extype pairing, " <>
      "integer not compatible with Google.Protobuf.StringValue",
      fn ->
        FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.StringValue", false, [extype: extype])
      end
  end

  test "type_to_spec invalid type" do
    extype = "String.t()"
    assert_raise RuntimeError,
      "Sorry Google.Protobuf.UnrealValue does not support the field option extype",
      fn ->
        FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.UnrealValue", false, [extype: extype])
      end
  end

  test "type_default" do

    assert is_nil(FieldOptionsProcessor.type_default(Google.Protobuf.BoolValue, extype: "boolean"))

    assert is_nil(FieldOptionsProcessor.type_default(Google.Protobuf.Timestamp, extype: "DateTime.t()"))
    assert is_nil(FieldOptionsProcessor.type_default(Google.Protobuf.Timestamp, extype: "DateTime.t"))
    assert is_nil(FieldOptionsProcessor.type_default(Google.Protobuf.Timestamp, extype: "NaiveDateTime.t()"))

    # Typo
    assert_raise RuntimeError, "Invalid extype pairing, Datetime.t not compatible with " <>
      "Elixir.Google.Protobuf.Timestamp. Supported types are DateTime.t() or NaiveDateTime.t()",
      fn -> FieldOptionsProcessor.type_default(Google.Protobuf.Timestamp, extype: "Datetime.t") end
  end

  test "encoding and decoding timestamp" do
    dt = DateTime.utc_now()
    ndt = DateTime.to_naive(dt)

    output = FieldOptionsProcessor.encode_type(Google.Protobuf.Timestamp, dt, extype: "DateTime.t")
    output1 = FieldOptionsProcessor.encode_type(Google.Protobuf.Timestamp, ndt, extype: "NaiveDateTime.t")

    assert output == output1

    assert FieldOptionsProcessor.decode_type(output, Google.Protobuf.Timestamp, extype: "DateTime.t") == dt

    assert FieldOptionsProcessor.decode_type(output, Google.Protobuf.Timestamp, extype: "NaiveDateTime.t") == ndt

    # DateTime.from_naive accepts DateTime.t as well
    assert FieldOptionsProcessor.encode_type(Google.Protobuf.Timestamp, dt, extype: "NaiveDateTime.t") == output

    # Cannot encode NaiveDateTime as DateTime, missing timezone info.
    assert_raise FunctionClauseError, fn ->
      FieldOptionsProcessor.encode_type(Google.Protobuf.Timestamp, ndt, extype: "DateTime.t")
    end
  end
end
