defmodule Google.ProtobufTest do
  use ExUnit.Case, async: true

  import Google.Protobuf

  alias Google.Protobuf.{Struct, Timestamp}

  @basic_json """
  {
    "key_one": "value_one",
    "key_two": 1234,
    "key_three": null,
    "key_four": true
  }
  """

  @basic_elixir %{
    "key_one" => "value_one",
    "key_two" => 1234,
    "key_three" => nil,
    "key_four" => true
  }

  @advanced_json """
  {
    "key_two": [1, 2, 3, null, true, "value"],
    "key_three": {
      "key_four": "value_four",
      "key_five": {
        "key_six": 99,
        "key_seven": {
          "key_eight": "value_eight"
        }
      }
    }
  }
  """

  @advanced_elixir %{
    "key_two" => [1, 2, 3, nil, true, "value"],
    "key_three" => %{
      "key_four" => "value_four",
      "key_five" => %{
        "key_six" => 99,
        "key_seven" => %{
          "key_eight" => "value_eight"
        }
      }
    }
  }

  describe "to_map/1" do
    test "converts nil values to empty map" do
      assert %{} == to_map(%Struct{})
    end

    test "converts basic json to map" do
      assert @basic_elixir == to_map(Protobuf.JSON.decode!(@basic_json, Struct))
    end

    test "converts advanced json to map" do
      assert @advanced_elixir == to_map(Protobuf.JSON.decode!(@advanced_json, Struct))
    end
  end

  describe "from_map/1" do
    test "converts basic elixir to struct" do
      assert Protobuf.JSON.decode!(@basic_json, Struct) == from_map(@basic_elixir)
    end

    test "converts advanced elixir to struct" do
      assert Protobuf.JSON.decode!(@advanced_json, Struct) == from_map(@advanced_elixir)
    end
  end

  describe "to_datetime/1" do
    # This matches golang behaviour
    # https://github.com/golang/protobuf/blob/5d5e8c018a13017f9d5b8bf4fad64aaa42a87308/ptypes/timestamp.go#L43
    test "converts nil values to unix time start" do
      assert ~U[1970-01-01 00:00:00.000000Z] == to_datetime(%Timestamp{})
    end

    test "converts to DateTime" do
      assert ~U[1970-01-01 00:00:05.000000Z] ==
               to_datetime(%Timestamp{seconds: 5, nanos: 0})
    end

    test "nanosecond precision" do
      one = to_datetime(%Timestamp{seconds: 10, nanos: 100})
      two = to_datetime(%Timestamp{seconds: 10, nanos: 105})
      assert 0 == DateTime.diff(one, two, :nanosecond)
    end
  end

  describe "from_datetime/1" do
    test "converts from DateTime" do
      assert %Timestamp{seconds: 5, nanos: 0} ==
               from_datetime(~U[1970-01-01 00:00:05.000000Z])
    end
  end
end
