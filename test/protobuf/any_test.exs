defmodule Protobuf.AnyTest do
  use ExUnit.Case, async: true

  doctest Protobuf.Any

  describe "pack/1" do
    test "packs a message into Any" do
      message = %Google.Protobuf.Duration{seconds: 42}
      assert %Google.Protobuf.Any{} = result = Protobuf.Any.pack(message)
      assert result.type_url == "type.googleapis.com/google.protobuf.Duration"
      assert result.value == Google.Protobuf.Duration.encode(message)
    end

    test "packs a message into Any with a prefix" do
      message = %My.Test.Request.SomeGroup{group_field: 42}
      assert %Google.Protobuf.Any{} = result = Protobuf.Any.pack(message)
      assert result.type_url == "type.googleapis.com/test.Request.SomeGroup"
      assert result.value == My.Test.Request.SomeGroup.encode(message)
    end
  end

  describe "type_url_to_module/1" do
    test "returns the module for a valid type_url" do
      assert Protobuf.Any.type_url_to_module("type.googleapis.com/google.protobuf.Duration") ==
               Google.Protobuf.Duration
    end

    test "raises an error for an invalid type_url" do
      assert_raise ArgumentError, ~r/type_url must be in the form/, fn ->
        Protobuf.Any.type_url_to_module("invalid")
      end
    end
  end
end
