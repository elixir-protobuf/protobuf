defmodule Protobuf.EncodeDecodeVarintTest do
  use ExUnit.Case
  use EQC.ExUnit

  alias Protobuf.{Encoder, Decoder}

  property "varint roundtrip" do
    forall n <- largeint() do
      iodata = Encoder.encode_varint(n)
      bin = IO.iodata_to_binary(iodata)
      [n] = Decoder.decode_varint(bin, :value)
      ensure(<<n::signed-64>> == <<n::64>>)
    end
  end

  defp neg_gen do
    let(x <- largeint(), do: return(-abs(x)))
  end

  property "encode_varint for negative integers should always be 10 bytes" do
    forall n <- neg_gen() do
      ensure(IO.iodata_length(Encoder.encode_varint(n)) == 10)
    end
  end
end
