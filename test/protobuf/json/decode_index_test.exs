defmodule Protobuf.JSON.DecodeIndexTest do
  # Decoding visits only the fields present in the input, using an index
  # computed when the message's props are built. These pin down that it
  # still decodes exactly as visiting every field did.
  use ExUnit.Case, async: true

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3

  defmodule CollidingNames do
    use Protobuf, syntax: :proto3

    # `foo`'s JSON name is `bar`'s proto name.
    field :foo, 1, type: :string, json_name: "bar"
    field :bar, 2, type: :string
  end

  # A message whose props carry no index, as props built by hand or by an
  # older version of this library do.
  defmodule WithoutIndex do
    defstruct %TestAllTypesProto3{} |> Map.from_struct() |> Map.to_list()

    def __message_props__,
      do: %{TestAllTypesProto3.__message_props__() | json_index: nil}

    def transform_module, do: nil
  end

  test "a key that names two fields sets both, as before" do
    assert Protobuf.JSON.from_decoded(%{"bar" => "x"}, CollidingNames) ==
             {:ok, %CollidingNames{foo: "x", bar: "x"}}
  end

  test "with several invalid fields, the first in field_props order is reported" do
    bad = %{
      "optionalInt32" => "x",
      "optionalString" => 1,
      "optionalBool" => "x",
      "repeatedInt64" => "x",
      "optionalNestedMessage" => 1,
      "mapStringString" => [],
      "optionalNestedEnum" => "NOPE"
    }

    order =
      TestAllTypesProto3.__message_props__().field_props
      |> Enum.map(fn {_num, prop} -> prop.json_name end)

    first = Enum.find(order, &Map.has_key?(bad, &1))
    expected = Protobuf.JSON.from_decoded(Map.take(bad, [first]), TestAllTypesProto3)

    assert {:error, _} = expected
    assert Protobuf.JSON.from_decoded(bad, TestAllTypesProto3) == expected
  end

  test "props without an index decode the same" do
    inputs = [
      %{},
      %{"optionalInt32" => 1, "optional_string" => "s", "repeatedBool" => [true, false]},
      %{"optionalNestedMessage" => %{"a" => 1}, "mapInt32Int32" => %{"1" => 2}},
      %{"oneofUint32" => 1},
      %{"oneofUint32" => 1, "oneofString" => "s"},
      %{"optionalInt32" => "x"},
      %{"optionalInt32" => 1, "optional_int32" => 1},
      %{"unknown" => 1, "optionalNestedEnum" => "BAZ"}
    ]

    for data <- inputs do
      indexed = Protobuf.JSON.from_decoded(data, TestAllTypesProto3)
      without = Protobuf.JSON.from_decoded(data, WithoutIndex)

      case indexed do
        {:ok, struct} ->
          assert {:ok, other} = without
          assert Map.from_struct(other) == Map.from_struct(struct), inspect(data)

        error ->
          assert without == error, inspect(data)
      end
    end
  end

  test "enum modules carry no index" do
    assert TestAllTypesProto3.NestedEnum.__message_props__().json_index == nil
  end
end
