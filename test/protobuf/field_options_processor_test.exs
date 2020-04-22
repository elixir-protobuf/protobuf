defmodule Protobuf.FieldOptionsProcessorTest do
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
    assert_raise RuntimeError, "The custom field option is invalid. " <>
      "Options: [extype: \"integer\"] incompatible with type: Google.Protobuf.StringValue",
      fn ->
        FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.StringValue", false, [extype: "integer"])
      end
  end

  test "type_to_spec invalid type" do
    extype = "String.t()"
    assert_raise RuntimeError, "The custom field option is invalid. " <>
      "Options: [extype: \"String.t()\"] incompatible with type: Google.Protobuf.UnrealValue",
      fn ->
        FieldOptionsProcessor.type_to_spec(:TYPE_MESSAGE, "Google.Protobuf.UnrealValue", false, [extype: extype])
      end
  end
end
