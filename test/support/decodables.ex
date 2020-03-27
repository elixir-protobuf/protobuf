defimpl Protobuf.Decodable, for: TestMsg.DateFoo do
  def to_elixir(%TestMsg.DateFoo{iso_days: iso_days}) do
    {year, month, day, _, _, _, _} =
      Calendar.ISO.naive_datetime_from_iso_days({iso_days, {0, 86_400_000_000}})

    {:ok, date} = Date.new(year, month, day)
    date
  end
end

defimpl Protobuf.Decodable, for: Protobuf.Protoc.ExtTest.UnixDateTime do
  def to_elixir(%Protobuf.Protoc.ExtTest.UnixDateTime{microseconds: microseconds}) do
    DateTime.from_unix!(microseconds, :microsecond)
  end
end
