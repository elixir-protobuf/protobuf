defimpl Protobuf.Encodable, for: Date do
  def to_protobuf(
        %Date{calendar: calendar, year: year, month: month, day: day},
        TestMsg.DateFoo
      ) do
    {iso_days, _} = calendar.naive_datetime_to_iso_days(year, month, day, 0, 0, 0, {0, 6})
    %TestMsg.DateFoo{iso_days: iso_days}
  end
end

defimpl Protobuf.Encodable, for: DateTime do
  def to_protobuf(%DateTime{} = datetime, Protobuf.Protoc.ExtTest.UnixDateTime) do
    microseconds = DateTime.to_unix(datetime, :microsecond)
    %Protobuf.Protoc.ExtTest.UnixDateTime{microseconds: microseconds}
  end
end
