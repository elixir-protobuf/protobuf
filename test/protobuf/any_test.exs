defmodule Protobuf.AnyTest do
  use ExUnit.Case, async: true

  test "packs a message into an Any protobuf" do
    message = Google.Protobuf.Duration.new(%{seconds: 42})
    assert %Google.Protobuf.Any{} = result = Protobuf.Any.pack(message)
    assert result.type_url == "type.googleapis.com/google.protobuf.Duration"
    assert result.value == Google.Protobuf.Duration.encode(message)
  end

  test "packs a message into an Any protobuf with a prefix" do
    message = My.Test.Request.SomeGroup.new(%{group_field: 42})
    assert %Google.Protobuf.Any{} = result = Protobuf.Any.pack(message)
    assert result.type_url == "type.googleapis.com/test.Request.SomeGroup"
    assert result.value == My.Test.Request.SomeGroup.encode(message)
  end

  test "unpacks a message into an Any protobuf" do
    message = Google.Protobuf.Duration.new(%{seconds: 42})

    any = %Google.Protobuf.Any{
      type_url: "type.googleapis.com/google.protobuf.Duration",
      value: Protobuf.encode(message)
    }

    assert ^message = Protobuf.Any.unpack(any)
  end

  test "unpacks a message into an Any protobuf with a prefix" do
    message = My.Test.Request.SomeGroup.new(%{group_field: 42})

    any = %Google.Protobuf.Any{
      type_url: "type.googleapis.com/test.Request.SomeGroup",
      value: Protobuf.encode(message)
    }

    assert ^message = Protobuf.Any.unpack(any, prefix: My)
  end
end
