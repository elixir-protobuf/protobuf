defmodule Protobuf.UnknownFieldsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Protobuf.Wire.Types

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3

  property "round-trip encoding and decoding of unknown fields" do
    unknown_field_generator = unknown_field_generator()

    check all unknown_fields <- list_of(unknown_field_generator) do
      decoded =
        TestAllTypesProto3.new!([])
        |> Map.put(:__unknown_fields__, unknown_fields)
        |> Protobuf.encode()
        |> Protobuf.decode(TestAllTypesProto3)

      assert Protobuf.get_unknown_fields(decoded) == unknown_fields
    end
  end

  defp unknown_field_generator() do
    value_generator =
      one_of([delimited_generator(), varint_generator(), bits32_generator(), bits64_generator()])

    gen all field_number <- integer(_unknown_fields_range = 100_000..200_000),
            {wire_type, value} <- value_generator do
      {field_number, wire_type, value}
    end
  end

  defp delimited_generator(), do: map(binary(), &{wire_delimited(), &1})
  defp varint_generator(), do: map(integer(0..10_000), &{wire_varint(), &1})
  defp bits64_generator(), do: map(binary(length: 8), &{wire_64bits(), &1})
  defp bits32_generator(), do: map(binary(length: 4), &{wire_32bits(), &1})
end
