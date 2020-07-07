defmodule Protobuf.EncodeDecodeTypeTest.PropertyGenerator do
  alias Protobuf.{Encoder}

  require Logger
  import Protobuf.Decoder

  def decode_type(wire, type, bin) do
    [n] = raw_decode_value(wire, bin, [])
    decode_type_m(type, :fake_key, n)
  end

  defmacro make_property(gen_func, field_type, wire_type) do
    quote do
      property unquote(Atom.to_string(field_type)) <> " roundtrip" do
        forall n <- unquote(gen_func) do
          bin = Encoder.encode_type(unquote(field_type), n)

          ensure(
            n ==
              decode_type(
                unquote(wire_type),
                unquote(field_type),
                bin
              )
          )
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
        forall n <- unquote(gen_func) do
          canonical_val =
            decode_type(
              unquote(wire_type),
              unquote(field_type),
              Encoder.encode_type(unquote(field_type), n)
            )

          bin = Encoder.encode_type(unquote(field_type), canonical_val)

          ensure(
            canonical_val ==
              decode_type(
                unquote(wire_type),
                unquote(field_type),
                bin
              )
          )
        end
      end
    end
  end
end

defmodule Protobuf.EncodeDecodeTypeTest do
  use ExUnit.Case
  use EQC.ExUnit

  import Protobuf.EncodeDecodeTypeTest.PropertyGenerator

  defp uint32_gen do
    let(<<x::unsigned-integer-size(32)>> <- binary(4), do: return(x))
  end

  defp uint64_gen do
    let(<<x::unsigned-integer-size(64)>> <- binary(8), do: return(x))
  end

  make_property(int(), :int32, 0)
  make_property(largeint(), :int64, 0)
  make_property(uint32_gen(), :uint32, 0)
  make_property(uint64_gen(), :uint64, 0)
  make_property(int(), :sint32, 0)
  make_property(largeint(), :sint64, 0)
  make_property(bool(), :bool, 0)

  make_property(nat(), :fixed64, 1)
  make_property(largeint(), :sfixed64, 1)
  make_canonical_property(resize(64, real()), :double, 1)

  make_canonical_property(resize(32, real()), :float, 5)
end
