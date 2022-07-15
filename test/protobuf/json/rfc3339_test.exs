defmodule Protobuf.JSON.RFC3339Test do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Protobuf.JSON.RFC3339

  describe "decode/1" do
    test "returns {:ok, seconds, nanos} with the right nanos and seconds" do
      assert {:ok, seconds, nanos} = RFC3339.decode("2021-11-26T16:19:13.310017Z")

      {:ok, dt, _offset} = DateTime.from_iso8601("2021-11-26T16:19:13Z")

      assert seconds == DateTime.to_unix(dt, :second)
      assert nanos == 310_017_000
    end

    test "returns {:ok, seconds, nanos} with a time offset" do
      assert {:ok, seconds, nanos} = RFC3339.decode("2021-11-26T16:19:13.310017+01:00")

      {:ok, dt, _offset} = DateTime.from_iso8601("2021-11-26T16:19:13+01:00")

      assert seconds == DateTime.to_unix(dt, :second)
      assert nanos == 310_017_000
    end

    test "returns {:error, reason} if the timestamp is outside of the allowed range" do
      assert {:error, reason} = RFC3339.decode("0000-01-01T00:00:00Z")
      assert reason == "timestamp is outside of allowed range"
    end

    test "returns {:error, reason} if the timestamp has cruft after" do
      assert {:error, reason} = RFC3339.decode("0000-01-01T00:00:00Zand the rest")
      assert reason == ~s(expected empty string, got: "and the rest")
    end

    test "returns {:error, reason} if the timestamp is missing the offset" do
      assert {:error, reason} = RFC3339.decode("0000-01-01T00:00:00")
      assert reason == "expected time offset, but it's missing"
    end

    test "returns {:error, reason} with bad nanoseconds" do
      assert {:error, reason} = RFC3339.decode("0000-01-01T00:00:00.nonanoZ")
      assert reason == ~s(bad time secfrac after ".", got: "nonanoZ")
    end

    test "returns {:error, reason} with bad digit something" do
      assert {:error, reason} = RFC3339.decode("000-01-01T00:00:00Z")
      assert reason == ~s(expected 4 digits but got unparsable integer: "000-")
    end

    test "returns {:error, reason} with missing T to separate date and time" do
      assert {:error, reason} = RFC3339.decode("0000-01-01.00:00:00Z")
      assert reason == ~s(expected literal "T", got: ".00:00:00Z")
    end

    test "returns {:error, reason} with not enough digits" do
      assert {:error, reason} = RFC3339.decode("000")
      assert reason == ~s(expected 4 digits, got: "000")
    end

    test "returns {:ok, seconds, nanos} for the latest possible timestamp" do
      assert {:ok, _seconds, 999_999_999} = RFC3339.decode("9999-12-31T23:59:59.999999999Z")
    end

    property "returns the right nanoseconds regardless of how many digits" do
      check all digits_count <- member_of([3, 6, 9]),
                max_range = String.to_integer(String.duplicate("9", digits_count)),
                nanos <- integer(1..max_range),
                nanos = nanos * round(:math.pow(10, 9 - digits_count)) do
        real_nanos = String.to_integer(String.pad_trailing(Integer.to_string(nanos), 9, "0"))
        nanos_str = String.pad_leading(Integer.to_string(real_nanos), digits_count, "0")
        timestamp_str = "1970-01-01T00:00:00.#{nanos_str}Z"

        assert {:ok, 0, ^real_nanos} = RFC3339.decode(timestamp_str)
      end
    end
  end

  describe "encode/1" do
    test "returns {:ok, formatted_string} with the right nanos and seconds" do
      {:ok, dt, _offset} = DateTime.from_iso8601("2021-11-26T16:19:13Z")
      unix_sec = dt |> DateTime.truncate(:second) |> DateTime.to_unix(:second)

      assert RFC3339.encode(unix_sec, 123_000) == {:ok, "2021-11-26T16:19:13.000123Z"}
    end

    test "returns {:error, reason} with too big nanos" do
      assert {:error, message} = RFC3339.encode(_unix_sec = 0, _nanos = 10_000_000_000)
      assert message == "nanos can't be bigger than 1000000000, got: 10000000000"
    end

    test "returns {:error, reason} with invalid seconds" do
      assert {:error, message} = RFC3339.encode(10_000_000_000_000_000, _nanos = 0)
      assert message == ":invalid_unix_time"
    end

    property "injects the right nanoseconds regardless of how many digits" do
      check all digits_count <- member_of([3, 6, 9]),
                max_range = String.to_integer(String.duplicate("9", digits_count)),
                nanos <- integer(1..max_range),
                nanos = nanos * round(:math.pow(10, 9 - digits_count)) do
        real_nanos = String.to_integer(String.pad_trailing(Integer.to_string(nanos), 9, "0"))

        nanos_str =
          String.pad_leading(Integer.to_string(real_nanos), digits_count, "0")
          |> String.trim_trailing("000")
          |> String.trim_trailing("000")

        timestamp_str = "1970-01-01T00:00:00.#{nanos_str}Z"

        assert RFC3339.encode(0, real_nanos) == {:ok, timestamp_str}
      end
    end
  end
end
