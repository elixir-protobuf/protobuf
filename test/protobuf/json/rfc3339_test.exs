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

    test "returns {:error, reason} if the timestamp is outside of the allowed range" do
      assert {:error, reason} = RFC3339.decode("0000-01-01T00:00:00Z")
      assert reason == "timestamp is outside of allowed range"
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
