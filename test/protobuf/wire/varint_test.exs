defmodule Protobuf.Wire.VarintTest do
  use ExUnit.Case, async: true
  doctest Protobuf.Wire.Varint

  alias Protobuf.Wire.Varint

  describe "encode/1" do
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

  describe "decode/1" do
    require Varint

    Varint.decoder(:defp, :decode, do: {value, rest})

    test "300" do
      assert {300, ""} == decode(<<0b1010110000000010::16>>)
    end

    test "150" do
      assert {150, ""} == decode(<<150, 01>>)
    end

    test "0" do
      assert {0, ""} == decode(<<0>>)
    end

    test "1" do
      assert {1, ""} == decode(<<1>>)
    end

    test "min int32" do
      {val, ""} = decode(<<128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>)
      assert <<-2_147_483_648::signed-32>> == <<val::32>>
    end

    test "max int32" do
      assert {2_147_483_647, ""} == decode(<<255, 255, 255, 255, 7>>)
    end

    test "min int64" do
      {val, ""} = decode(<<128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>)
      assert <<-9_223_372_036_854_775_808::signed-64>> == <<val::64>>
    end

    test "max int64" do
      assert {9_223_372_036_854_775_807, ""} ==
               decode(<<255, 255, 255, 255, 255, 255, 255, 255, 127>>)
    end

    test "max uint32" do
      assert {4_294_967_295, ""} == decode(<<255, 255, 255, 255, 15>>)
    end

    test "max uint64" do
      assert {18_446_744_073_709_551_615, ""} ==
               decode(<<255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>)
    end
  end
end
