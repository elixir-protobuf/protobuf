defmodule Protobuf.WireTest do
  use ExUnit.Case, async: true

  alias Protobuf.EncodeError
  alias Protobuf.Wire

  describe "encode/2" do
    test "varint" do
      assert encode(:int32, 42) == <<42>>
    end

    test "min int32" do
      assert encode(:int32, -2_147_483_648) ==
               <<128, 128, 128, 128, 248, 255, 255, 255, 255, 1>>
    end

    test "min int64" do
      assert encode(:int64, -9_223_372_036_854_775_808) ==
               <<128, 128, 128, 128, 128, 128, 128, 128, 128, 1>>
    end

    test "min sint32" do
      assert encode(:sint32, -2_147_483_648) == <<255, 255, 255, 255, 15>>
    end

    test "max sint32" do
      assert encode(:sint32, 2_147_483_647) == <<254, 255, 255, 255, 15>>
    end

    test "min sint64" do
      assert encode(:sint64, -9_223_372_036_854_775_808) ==
               <<255, 255, 255, 255, 255, 255, 255, 255, 255, 1>>
    end

    test "max sint64" do
      assert encode(:sint64, 9_223_372_036_854_775_807) ==
               <<254, 255, 255, 255, 255, 255, 255, 255, 255, 1>>
    end

    test "bool false" do
      assert encode(:bool, false) == <<0>>
    end

    test "bool true" do
      assert encode(:bool, true) == <<1>>
    end

    test "enum atom and alias" do
      assert encode({:enum, TestMsg.EnumFoo}, :C) == <<4>>
      assert encode({:enum, TestMsg.EnumFoo}, :D) == <<4>>
    end

    test "enum known and unknown integer" do
      assert encode({:enum, TestMsg.EnumFoo}, 1) == <<1>>
      assert encode({:enum, TestMsg.EnumFoo}, 5) == <<5>>
    end

    test "wrong enum" do
      assert_raise EncodeError, fn ->
        encode({:enum, TestMsg.EnumFoo}, "invalid")
      end

      assert_raise EncodeError, fn ->
        encode({:enum, TestMsg.EnumFoo}, 0.1)
      end
    end

    test "a fixed64" do
      assert encode(:fixed64, 8_446_744_073_709_551_615) ==
               <<255, 255, 23, 118, 251, 220, 56, 117>>
    end

    test "max fixed64" do
      assert encode(:fixed64, 18_446_744_073_709_551_615) ==
               <<255, 255, 255, 255, 255, 255, 255, 255>>
    end

    test "min sfixed64" do
      assert encode(:sfixed64, -9_223_372_036_854_775_808) ==
               <<0, 0, 0, 0, 0, 0, 0, 128>>
    end

    test "max sfixed64" do
      assert encode(:sfixed64, 9_223_372_036_854_775_807) ==
               <<255, 255, 255, 255, 255, 255, 255, 127>>
    end

    test "min double" do
      assert encode(:double, 5.0e-324) == <<1, 0, 0, 0, 0, 0, 0, 0>>
    end

    test "max double" do
      assert encode(:double, 1.7976931348623157e308) == <<255, 255, 255, 255, 255, 255, 239, 127>>
    end

    test "int as double" do
      assert encode(:double, -9_223_372_036_854_775_808) == <<0, 0, 0, 0, 0, 0, 224, 195>>
    end

    test "string" do
      assert encode(:string, "testing") == <<7, 116, 101, 115, 116, 105, 110, 103>>

      assert_raise Protobuf.EncodeError, fn -> encode(:string, <<255>>) end
    end

    test "bytes" do
      assert encode(:bytes, <<42, 43, 44, 45>>) == <<4, 42, 43, 44, 45>>
    end

    test "fixed32" do
      assert encode(:fixed32, 4_294_967_295) == <<255, 255, 255, 255>>
    end

    test "sfixed32" do
      assert encode(:sfixed32, 2_147_483_647) == <<255, 255, 255, 127>>
    end

    test "float" do
      assert encode(:float, 3.4028234663852886e38) == <<255, 255, 127, 127>>
    end

    test "int as float" do
      assert encode(:float, 3) == <<0, 0, 64, 64>>
    end

    test "float infinity/-infinity/nan" do
      Enum.each([:infinity, :negative_infinity, :nan], fn f ->
        bin = encode(:float, f)
        assert f == Wire.decode(:float, bin)
      end)
    end

    test "double infinity, -infinity, nan" do
      Enum.each([:infinity, :negative_infinity, :nan], fn f ->
        bin = encode(:double, f)
        assert f == Wire.decode(:double, bin)
      end)
    end

    test "wrong uint32" do
      assert_raise EncodeError, fn ->
        encode(:uint32, 12_345_678_901_234_567_890)
      end

      assert_raise EncodeError, fn ->
        encode(:uint32, -1)
      end
    end

    test "wrong uint64" do
      assert_raise EncodeError, fn ->
        encode(:uint64, 184_467_440_737_095_516_150)
      end

      assert_raise EncodeError, fn ->
        encode(:uint64, -1)
      end
    end

    test "wrong fixed32" do
      assert_raise EncodeError, fn ->
        encode(:fixed32, 12_345_678_901_234_567_890)
      end

      assert_raise EncodeError, fn ->
        encode(:fixed32, -1)
      end
    end

    test "wrong fixed64" do
      assert_raise EncodeError, fn ->
        encode(:fixed64, 184_467_440_737_095_516_150)
      end

      assert_raise EncodeError, fn ->
        encode(:fixed64, -1)
      end
    end

    test "wrong int32" do
      assert_raise EncodeError, fn ->
        encode(:int32, 2_147_483_648)
      end

      assert_raise EncodeError, fn ->
        encode(:int32, -2_147_483_649)
      end
    end

    test "wrong int64" do
      assert_raise EncodeError, fn ->
        encode(:int64, 184_467_440_737_095_516_150)
      end

      assert_raise EncodeError, fn ->
        encode(:int64, -184_467_440_737_095_516_150)
      end
    end

    test "wrong sint32" do
      assert_raise EncodeError, fn ->
        encode(:sint32, 2_147_483_648)
      end

      assert_raise EncodeError, fn ->
        encode(:sint32, -2_147_483_649)
      end
    end

    test "wrong sint64" do
      assert_raise EncodeError, fn ->
        encode(:sint64, 184_467_440_737_095_516_150)
      end

      assert_raise EncodeError, fn ->
        encode(:sint64, -184_467_440_737_095_516_150)
      end
    end

    test "wrong sfixed32" do
      assert_raise EncodeError, fn ->
        encode(:sfixed32, 2_147_483_648)
      end

      assert_raise EncodeError, fn ->
        encode(:sfixed32, -2_147_483_649)
      end
    end

    test "wrong sfixed64" do
      assert_raise EncodeError, fn ->
        encode(:sfixed64, 184_467_440_737_095_516_150)
      end

      assert_raise EncodeError, fn ->
        encode(:sfixed64, -184_467_440_737_095_516_150)
      end
    end

    defp encode(type, value) do
      type
      |> Wire.encode(value)
      |> IO.iodata_to_binary()
    end
  end

  describe "decode/2" do
    test "varint" do
      assert 42 == Wire.decode(:int32, 42)
    end

    test "int64" do
      assert -1 == Wire.decode(:int64, -1)
    end

    test "min int32" do
      assert -2_147_483_648 == Wire.decode(:int32, 18_446_744_071_562_067_968)
    end

    test "max int32" do
      assert -2_147_483_647 == Wire.decode(:int32, 18_446_744_071_562_067_969)
    end

    test "min int64" do
      assert -9_223_372_036_854_775_808 == Wire.decode(:int64, 9_223_372_036_854_775_808)
    end

    test "max int64" do
      assert 9_223_372_036_854_775_807 == Wire.decode(:int64, 9_223_372_036_854_775_807)
    end

    test "min sint32" do
      assert -2_147_483_648 == Wire.decode(:sint32, 4_294_967_295)
    end

    test "max sint32" do
      assert 2_147_483_647 == Wire.decode(:sint32, 4_294_967_294)
    end

    test "overflowing sint32" do
      assert Wire.decode(:sint32, Wire.Zigzag.encode(2_147_483_647 + 2)) == 1
    end

    test "min sint64" do
      assert -9_223_372_036_854_775_808 == Wire.decode(:sint64, 18_446_744_073_709_551_615)
    end

    test "max sint64" do
      assert 9_223_372_036_854_775_807 == Wire.decode(:sint64, 18_446_744_073_709_551_614)
    end

    test "max uint32" do
      assert 4_294_967_295 == Wire.decode(:uint32, 4_294_967_295)
    end

    test "max uint64" do
      assert 9_223_372_036_854_775_807 == Wire.decode(:uint64, 9_223_372_036_854_775_807)
    end

    test "bool works" do
      assert true == Wire.decode(:bool, 1)
      assert false == Wire.decode(:bool, 0)
    end

    test "enum known and unknown integer" do
      assert :A == Wire.decode({:enum, TestMsg.EnumFoo}, 1)
      assert 5 == Wire.decode({:enum, TestMsg.EnumFoo}, 5)
    end

    test "enum wraps to an int32" do
      max_int32 = 0x7FFFFFFFFFFFFFFF
      assert Wire.decode({:enum, TestMsg.EnumFoo}, max_int32 + 2) == :A
    end

    test "a fixed64" do
      assert 8_446_744_073_709_551_615 ==
               Wire.decode(:fixed64, <<255, 255, 23, 118, 251, 220, 56, 117>>)
    end

    test "max fixed64" do
      assert 18_446_744_073_709_551_615 ==
               Wire.decode(:fixed64, <<255, 255, 255, 255, 255, 255, 255, 255>>)
    end

    test "min sfixed64" do
      assert -9_223_372_036_854_775_808 == Wire.decode(:sfixed64, <<0, 0, 0, 0, 0, 0, 0, 128>>)
    end

    test "max sfixed64" do
      assert 9_223_372_036_854_775_807 ==
               Wire.decode(:sfixed64, <<255, 255, 255, 255, 255, 255, 255, 127>>)
    end

    test "min double" do
      assert 5.0e-324 == Wire.decode(:double, <<1, 0, 0, 0, 0, 0, 0, 0>>)
    end

    test "max double" do
      assert 1.7976931348623157e308 ==
               Wire.decode(:double, <<255, 255, 255, 255, 255, 255, 239, 127>>)
    end

    test "string" do
      assert "testing" == Wire.decode(:string, <<116, 101, 115, 116, 105, 110, 103>>)

      assert_raise Protobuf.DecodeError, fn -> Wire.decode(:string, <<255>>) end
    end

    test "bytes" do
      assert <<42, 43, 44, 45>> == Wire.decode(:bytes, <<42, 43, 44, 45>>)
    end

    test "fixed32" do
      assert 4_294_967_295 == Wire.decode(:fixed32, <<255, 255, 255, 255>>)
    end

    test "sfixed32" do
      assert 2_147_483_647 == Wire.decode(:sfixed32, <<255, 255, 255, 127>>)
    end

    test "float" do
      assert 3.4028234663852886e38 == Wire.decode(:float, <<255, 255, 127, 127>>)
    end

    test "float infinity, -infinity, nan" do
      assert :infinity == Wire.decode(:float, <<0, 0, 128, 127>>)
      assert :negative_infinity == Wire.decode(:float, <<0, 0, 128, 255>>)
      assert :nan == Wire.decode(:float, <<0, 0, 192, 127>>)
    end

    test "double infinity, -infinity, nan" do
      assert :infinity == Wire.decode(:double, <<0, 0, 0, 0, 0, 0, 240, 127>>)
      assert :negative_infinity == Wire.decode(:double, <<0, 0, 0, 0, 0, 0, 240, 255>>)
      assert :nan == Wire.decode(:double, <<1, 0, 0, 0, 0, 0, 248, 127>>)
    end

    test "mismatching fixed-length sizes" do
      msg = "can't decode <<0, 0, 0>> into type :fixed32"

      assert_raise Protobuf.DecodeError, msg, fn ->
        Wire.decode(:fixed32, <<0, 0, 0>>)
      end

      msg = "can't decode <<0, 0, 0, 0, 0>> into type :fixed32"

      assert_raise Protobuf.DecodeError, msg, fn ->
        Wire.decode(:fixed32, <<0, 0, 0, 0, 0>>)
      end

      msg = "can't decode <<0, 0, 0, 0, 0, 0, 0>> into type :fixed64"

      assert_raise Protobuf.DecodeError, msg, fn ->
        Wire.decode(:fixed64, <<0, 0, 0, 0, 0, 0, 0>>)
      end

      msg = "can't decode <<0, 0, 0, 0, 0, 0, 0, 0, 0>> into type :fixed64"

      assert_raise Protobuf.DecodeError, msg, fn ->
        Wire.decode(:fixed64, <<0, 0, 0, 0, 0, 0, 0, 0, 0>>)
      end
    end

    test "Protobuf.DecodeError when unknown or mismatched type" do
      msg = "can't decode <<0>> into type {:enum, \"invalid\"}"

      assert_raise Protobuf.DecodeError, msg, fn ->
        Wire.decode({:enum, "invalid"}, <<0>>)
      end
    end
  end
end
