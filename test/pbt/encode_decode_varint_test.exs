defmodule Protobuf.EncodeDecodeVarintTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Protobuf.Wire.Varint

  decoder :defp, :decode do
    "" = rest
    value
  end

  property "varint roundtrip" do
    check all n <- large_integer_gen() do
      iodata = encode(n)
      bin = IO.iodata_to_binary(iodata)
      n = decode(bin)
      assert <<n::signed-64>> == <<n::64>>
    end
  end

  property "encode_varint for negative integers should always be 10 bytes" do
    negative_large_integer_gen = map(large_integer_gen(), &(-abs(&1)))

    check all n <- negative_large_integer_gen do
      assert IO.iodata_length(encode(n)) == 10
    end
  end

  defp large_integer_gen do
    scale(integer(), &(&1 * 10_000))
  end
end
