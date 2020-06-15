defmodule Protobuf.JSONTest do
  use ExUnit.Case, async: true
  doctest Protobuf.JSON

  alias TestMsg.Scalars

  test "string field with invalid UTF-8 data" do
    message = Scalars.new!(string: "   \xff   ")
    assert {:error, %Jason.EncodeError{}} = Protobuf.JSON.encode(message)
  end
end
