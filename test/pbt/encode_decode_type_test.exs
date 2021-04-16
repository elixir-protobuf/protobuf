defmodule Protobuf.EncodeDecodeTypeTest.PropertyGenerator do
  alias Protobuf.Encoder

  require Logger
  import Protobuf.Decoder

  def decode_type(wire, type, bin) do
    [n] = raw_decode_value(wire, bin, [])
    decode_type_m(type, :fake_key, n)
  end

  defmacro make_property(gen_func, field_type, wire_type) do
    quote do
      property unquote(Atom.to_string(field_type)) <> " roundtrip" do
        check all n <- unquote(gen_func) do
          iodata = Encoder.encode_type(unquote(field_type), n)
          bin = IO.iodata_to_binary(iodata)
          assert n == decode_type(unquote(wire_type), unquote(field_type), bin)
        end
      end
    end
  end

  # Since float point is not precise, make canonical value before doing PBT
  # ref: http://hypothesis.works/articles/canonical-serialization/
  # and try 0.2 here: https://www.h-schmidt.net/FloatConverter/IEEE754.html
  defmacro make_canonical_property(gen_func, field_type, wire_type) do
    quote do
      property unquote(Atom.to_string(field_type)) <> " canonical roundtrip" do
        check all n <- unquote(gen_func) do
          encoded_val =
            unquote(field_type)
            |> Encoder.encode_type(n)
            |> IO.iodata_to_binary()

          canonical_val =
            decode_type(
              unquote(wire_type),
              unquote(field_type),
              encoded_val
            )

          bin =
            unquote(field_type)
            |> Encoder.encode_type(canonical_val)
            |> IO.iodata_to_binary()

          assert canonical_val == decode_type(unquote(wire_type), unquote(field_type), bin)
        end
      end
    end
  end
end

defmodule Protobuf.EncodeDecodeTypeTest do
  use ExUnit.Case
  use ExUnitProperties

  import Protobuf.EncodeDecodeTypeTest.PropertyGenerator

  defp uint32_gen do
    map(binary(length: 4), fn <<x::unsigned-integer-size(32)>> -> x end)
  end

  defp uint64_gen do
    map(binary(length: 8), fn <<x::unsigned-integer-size(64)>> -> x end)
  end

  defp large_integer do
    scale(integer(), &(&1 * 10_000))
  end

  defp natural_number do
    map(integer(), &abs/1)
  end

  make_property(integer(), :int32, 0)
  make_property(large_integer(), :int64, 0)
  make_property(uint32_gen(), :uint32, 0)
  make_property(uint64_gen(), :uint64, 0)
  make_property(integer(), :sint32, 0)
  make_property(large_integer(), :sint64, 0)

  make_property(boolean(), :bool, 0)

  make_property(natural_number(), :fixed64, 1)
  make_property(large_integer(), :sfixed64, 1)

  make_canonical_property(float(), :double, 1)
  make_canonical_property(float(), :float, 5)
end
