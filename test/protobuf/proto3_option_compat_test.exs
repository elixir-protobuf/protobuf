defmodule Protobuf.Proto3OptionCompatTest do
  use ExUnit.Case, async: true

  alias Protobuf.Encoder
  alias Protobuf.Decoder

  test "optional compat round trip works" do
    bin1 = Encoder.encode(%TestMsg.Proto3OptionalCompat{_a: {:a, 12}})
    bin2 = Encoder.encode(%TestMsg.Proto3OptionalCompat{a: 12})
    bin3 = Encoder.encode(%TestMsg.Proto3OptionalCompat{a: 12, _a: {:a, 12}})
    assert bin1 == bin2
    assert bin1 == bin3

    struct = Decoder.decode(bin1, TestMsg.Proto3OptionalCompat)
    assert Map.fetch!(struct, :_a) == {:a, 12}
    assert struct.a == 12
  end

  test "raises on conflicting values" do
    assert_raise Protobuf.EncodeError, fn ->
      Encoder.encode(%TestMsg.Proto3OptionalCompat{_a: {:a, 12}, a: 13})
    end
  end

end
