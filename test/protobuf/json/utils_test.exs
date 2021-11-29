defmodule Protobuf.JSON.UtilsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Protobuf.JSON.Utils

  @max_nanosec 999_999_999

  property "format_nanoseconds/1 and parse_nanoseconds/1 are circular" do
    check all nanoseconds <- integer(0..@max_nanosec) do
      formatted = Utils.format_nanoseconds(nanoseconds)
      assert {parsed, ""} = Utils.parse_nanoseconds(formatted)
      assert parsed == nanoseconds
    end
  end

  describe "format_nanoseconds/1" do
    test "correctly pads the string and removes trailing zeros" do
      assert Utils.format_nanoseconds(1) == "000000001"
      assert Utils.format_nanoseconds(1_000) == "000001"
      assert Utils.format_nanoseconds(1_000_000) == "001"
      assert Utils.format_nanoseconds(999_999_999) == "999999999"
    end

    property "always formats nanoseconds as 3, 6, or 9 digits" do
      check all nanoseconds <- integer(0..@max_nanosec), max_runs: 100 do
        formatted = Utils.format_nanoseconds(nanoseconds)
        assert byte_size(formatted) in [3, 6, 9]
      end
    end
  end

  describe "parse_nanoseconds/1" do
    test "returns :error if no digits are present" do
      assert Utils.parse_nanoseconds("foo") == :error
    end

    test "returns :error if more than 9 digits are passed" do
      assert Utils.parse_nanoseconds("1234567899") == :error
    end

    property "returns whatever's left after parsing the digits" do
      assert Utils.parse_nanoseconds("123456789foo") == {123_456_789, "foo"}
      assert Utils.parse_nanoseconds("123456789") == {123_456_789, ""}

      check all nanos <- string(?0..?9, min_length: 1, max_length: 9),
                rest <- string([?a..?z, ?A..?Z], min_length: 0, max_length: 5),
                max_runs: 10 do
        assert {parsed_nanos, ^rest} = Utils.parse_nanoseconds(nanos <> rest)
        assert parsed_nanos in 0..@max_nanosec
      end
    end
  end
end
