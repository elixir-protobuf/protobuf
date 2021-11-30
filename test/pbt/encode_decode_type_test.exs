defmodule Protobuf.EncodeDecodeTypeTest.PropertyGenerator do
  def decode(type, bin) do
    bin
    |> TestMsg.Scalars.decode()
    |> Map.fetch!(type)
  end

  def encode(type, val) do
    [{type, val}]
    |> TestMsg.Scalars.new!()
    |> Protobuf.encode(iolist: false)
  end

  defmacro make_properties(gen_func, field_type) do
    quote do
      property "#{unquote(field_type)} roundtrip" do
        check all n <- unquote(gen_func) do
          field_type = unquote(field_type)
          bin = encode(field_type, n)

          assert n == decode(field_type, bin)
        end
      end

      property "repeated #{unquote(field_type)} roundtrip" do
        check all n <- unquote(gen_func) do
          field_type = :"repeated_#{unquote(field_type)}"
          bin = encode(field_type, [n, n])

          assert [n, n] == decode(field_type, bin)
        end
      end
    end
  end

  # Since float point is not precise, make canonical value before doing PBT
  # ref: http://hypothesis.works/articles/canonical-serialization/
  # and try 0.2 here: https://www.h-schmidt.net/FloatConverter/IEEE754.html
  defmacro make_canonical_properties(gen_func, field_type) do
    quote do
      property "#{unquote(field_type)} canonical roundtrip" do
        check all n <- unquote(gen_func) do
          field_type = unquote(field_type)
          encoded_val = encode(field_type, n)
          canonical_val = decode(field_type, encoded_val)
          bin = encode(field_type, canonical_val)

          assert canonical_val == decode(field_type, bin)
        end
      end

      property "repeated #{unquote(field_type)} canonical roundtrip" do
        check all n <- unquote(gen_func) do
          field_type = :"repeated_#{unquote(field_type)}"
          encoded_vals = encode(field_type, [n, n])
          canonical_vals = decode(field_type, encoded_vals)
          bin = encode(field_type, canonical_vals)

          assert canonical_vals == decode(field_type, bin)
        end
      end
    end
  end
end

defmodule Protobuf.EncodeDecodeTypeTest do
  use ExUnit.Case, async: true
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

  make_properties(integer(), :int32)
  make_properties(large_integer(), :int64)
  make_properties(uint32_gen(), :uint32)
  make_properties(uint64_gen(), :uint64)
  make_properties(integer(), :sint32)
  make_properties(large_integer(), :sint64)

  make_properties(boolean(), :bool)

  make_properties(natural_number(), :fixed64)
  make_properties(large_integer(), :sfixed64)

  make_canonical_properties(float(), :double)
  make_canonical_properties(float(), :float)
end
