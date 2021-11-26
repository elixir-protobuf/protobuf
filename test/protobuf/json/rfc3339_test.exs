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

  # describe "encode/1" do
  #   test "returns {:ok, string} with the right nanos and seconds" do
  #     assert {:ok, %Google.Protobuf.Timestamp{} = timestamp} =
  #              Protobuf.JSON.RFC3339.decode("2021-11-26T16:19:13.310017Z")

  #     assert timestamp.nanos == 310_017_000
  #     {:ok, dt, _offset} = DateTime.from_iso8601("2021-11-26T16:19:13Z")
  #     assert timestamp.seconds == DateTime.to_unix(dt, :second)
  #   end
  # end
end
