defmodule Protobuf.JSONTest do
  use ExUnit.Case, async: true
  doctest Protobuf.JSON

  alias TestMsg.Scalars

  test "only encodes valid protobuf structs" do
    assert_raise Protobuf.JSON.EncodeError, ~r/'proto2' syntax is unsupported/, fn ->
      Protobuf.JSON.encode!(%TestMsg.Foo2{})
    end
  end

  test "string field with invalid UTF-8 data" do
    message = Scalars.new!(string: "   \xff   ")
    assert {:error, %Jason.EncodeError{}} = Protobuf.JSON.encode(message)
  end
end
