defmodule Protobuf.AnyTest do
  use ExUnit.Case, async: true

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
