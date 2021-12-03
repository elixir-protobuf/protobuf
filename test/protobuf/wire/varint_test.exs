defmodule Protobuf.Wire.VarintTest do
  use ExUnit.Case, async: true

  doctest Protobuf.Wire.Varint

  describe "encode/1" do
    alias Protobuf.Wire.Varint

    test "300" do
      assert encode(300) == <<0b10101100, 0b00000010>>
    end

    test "150" do
      assert encode(150) == <<150, 1>>
    end

    test "0" do
      assert encode(0) == <<0>>
    end

    test "1" do
      assert encode(1) == <<1>>
    end

    test "min int32" do
      assert encode(-2_147_483_648) == <<128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>
    end

    test "max int32" do
      assert encode(2_147_483_647) == <<255, 255, 255, 255, 7>>
    end

    test "min int64" do
      assert encode(-9_223_372_036_854_775_808) ==
               <<128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>
    end

    test "max int64" do
      assert encode(9_223_372_036_854_775_807) ==
               <<255, 255, 255, 255, 255, 255, 255, 255, 127>>
    end

    test "max uint32" do
      assert encode(4_294_967_295) == <<255, 255, 255, 255, 15>>
    end

    test "max uint64" do
      assert encode(18_446_744_073_709_551_615) ==
               <<255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>
    end

    defp encode(n) do
      n
      |> Varint.encode()
      |> IO.iodata_to_binary()
    end
  end

  describe "defdecoderp/2" do
    import Protobuf.Wire.Varint

    defdecoderp(decode(), do: {value, rest})
    defdecoderp(decode_with_args(arg, _, :fixed_arg), do: {value, rest, arg})

    test "some numbers" do
      cases = [
        {300, <<0b1010110000000010::16>>},
        {150, <<150, 01>>},
        {0, <<0>>},
        {1, <<1>>}
      ]

      for {number, bits} <- cases do
        assert decode(bits) == {number, ""}
      end
    end

    test "min int32" do
      assert {val, ""} = decode(<<128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>)
      assert <<-2_147_483_648::signed-32>> == <<val::32>>
    end

    test "max int32" do
      assert decode(<<255, 255, 255, 255, 7>>) == {2_147_483_647, ""}
    end

    test "min int64" do
      assert {val, ""} = decode(<<128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>)
      assert <<-9_223_372_036_854_775_808::signed-64>> == <<val::64>>
    end

    test "max int64" do
      assert decode(<<255, 255, 255, 255, 255, 255, 255, 255, 127>>) ==
               {9_223_372_036_854_775_807, ""}
    end

    test "max uint32" do
      assert decode(<<255, 255, 255, 255, 15>>) == {4_294_967_295, ""}
    end

    test "max uint64" do
      assert decode(<<255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>) ==
               {18_446_744_073_709_551_615, ""}
    end

    test "raises an error if the varint is not decodable" do
      assert_raise Protobuf.DecodeError, "cannot decode binary data", fn ->
        decode(<<>>)
      end
    end

    test "can define a decoder that takes any kinds of arguments" do
      assert decode_with_args(<<150, 01>>, :some_arg, :ignored, :fixed_arg) ==
               {150, _rest = "", :some_arg}

      assert_raise Protobuf.DecodeError, "cannot decode binary data", fn ->
        decode_with_args(<<>>, :some_arg, :ignored, :fixed_arg)
      end
    end
  end
end
