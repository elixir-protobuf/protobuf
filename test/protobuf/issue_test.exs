Code.require_file("../support/test_msg.ex", __DIR__)

defmodule Protobuf.IssueTest do
  use ExUnit.Case, async: true

  alias Protobuf.{Decoder, Encoder}

  test "oneof proto3" do
    msg = %TestMsg.OneofProto3{first: {:b, ""}, second: {:c, 0}, other: "other"}
    assert msg == msg |> Encoder.encode() |> Decoder.decode(TestMsg.OneofProto3)
  end
end
