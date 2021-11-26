defmodule Protobuf.JSON.RFC3339 do
  @moduledoc false

  # date-fullyear   = 4DIGIT
  # date-month      = 2DIGIT  ; 01-12
  # date-mday       = 2DIGIT  ; 01-28, 01-29, 01-30, 01-31 based on
  #                           ; month/year
  # time-hour       = 2DIGIT  ; 00-23
  # time-minute     = 2DIGIT  ; 00-59
  # time-second     = 2DIGIT  ; 00-58, 00-59, 00-60 based on leap second
  #                           ; rules
  # time-secfrac    = "." 1*DIGIT
  # time-numoffset  = ("+" / "-") time-hour ":" time-minute
  # time-offset     = "Z" / time-numoffset

  # partial-time    = time-hour ":" time-minute ":" time-second
  #                   [time-secfrac]
  # full-date       = date-fullyear "-" date-month "-" date-mday
  # full-time       = partial-time time-offset

  # date-time       = full-date "T" full-time

  # date-time       = full-date "T" full-time

  @spec decode(String.t()) ::
          {:ok, seconds :: integer(), nanos :: non_neg_integer()} | {:error, String.t()}
  def decode(string) when is_binary(string) do
    rest = eat_full_date(string)
    rest = eat_literal(rest, "T")
    {time_secfrac_nano, rest} = parse_full_time(rest)
    ensure_empty(rest)

    case DateTime.from_iso8601(string) do
      {:ok, datetime, _offset_in_seconds} ->
        seconds =
          datetime
          |> DateTime.truncate(:second)
          |> DateTime.to_unix(:second)

        {:ok, seconds, time_secfrac_nano}

      {:error, reason} ->
        {:error, reason}
    end
  catch
    :throw, reason -> {:error, reason}
  end

  @spec encode(integer(), non_neg_integer()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(seconds, nanos)

  def encode(seconds, nanos)
      when is_integer(seconds) and is_integer(nanos) and nanos >= 1_000_000_000 do
    {:error, "nanos can't be bigger than 1000000000, got: #{nanos}"}
  end

  def encode(seconds, nanos) when is_integer(seconds) and is_integer(nanos) and nanos >= 0 do
    case DateTime.from_unix(seconds, :second) do
      {:ok, datetime} ->
        string = DateTime.to_iso8601(datetime)

        if nanos > 0 do
          nanos_str =
            nanos
            |> Integer.to_string()
            |> String.pad_leading(9, "0")
            |> String.trim_trailing("000")
            |> String.trim_trailing("000")

          bytes_before_time_secfrac = unquote(byte_size("1970-01-01T00:00:00"))
          {before_secfrac, after_secfrac} = String.split_at(string, bytes_before_time_secfrac)
          {:ok, before_secfrac <> "." <> nanos_str <> after_secfrac}
        else
          {:ok, string}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  # full-date       = date-fullyear "-" date-month "-" date-mday
  defp eat_full_date(rest) do
    rest
    |> eat_digits(_fullyear = 4)
    |> eat_literal("-")
    |> eat_digits(_month = 2)
    |> eat_literal("-")
    |> eat_digits(_mday = 2)
  end

  # full-time       = partial-time time-offset
  defp parse_full_time(string) do
    rest = eat_partial_time(string)
    {time_secfrac, rest} = parse_time_secfrac(rest)
    rest = eat_time_offset(rest)
    {time_secfrac, rest}
  end

  # partial-time    = time-hour ":" time-minute ":" time-second
  defp eat_partial_time(rest) do
    rest
    |> eat_digits(2)
    |> eat_literal(":")
    |> eat_digits(2)
    |> eat_literal(":")
    |> eat_digits(2)
  end

  # time-secfrac    = "." 1*DIGIT
  defp parse_time_secfrac("." <> rest) do
    case parse_nanosec(rest, _acc = 0, _power = 100_000_000) do
      {_, ^rest} ->
        throw("bad time secfrac after \".\", got: #{inspect(rest)}")

      {secfrac_nano, rest} ->
        {secfrac_nano, rest}
    end
  end

  defp parse_time_secfrac(rest), do: {0, rest}

  defp parse_nanosec(<<digit, _rest::binary>>, _acc, _power = 0) when digit in ?0..?9 do
    throw("expected a max of 9 digits for the second fraction")
  end

  defp parse_nanosec(<<digit, rest::binary>>, acc, power) when digit in ?0..?9 do
    digit = digit - ?0
    parse_nanosec(rest, acc + digit * power, div(power, 10))
  end

  defp parse_nanosec(rest, acc, _power) do
    {acc, rest}
  end

  # time-numoffset  = ("+" / "-") time-hour ":" time-minute

  defp eat_literal(string, literal) do
    literal_size = byte_size(literal)

    case string do
      <<^literal::bytes-size(literal_size), rest::binary>> -> rest
      other -> throw("expected literal #{inspect(literal)}, got: #{inspect(other)}")
    end
  end

  # time-offset     = "Z" / time-numoffset
  defp eat_time_offset("Z" <> rest), do: rest

  defp eat_time_offset("z" <> rest), do: rest

  defp eat_time_offset(<<sign, rest::binary>>) when sign in [?+, ?-] do
    rest
    |> eat_digits(2)
    |> eat_literal(":")
    |> eat_digits(2)
  end

  defp eat_time_offset("") do
    throw("expected time offset, but it's missing")
  end

  defp ensure_empty(""), do: :ok
  defp ensure_empty(other), do: throw("expected empty string, got: #{inspect(other)}")

  defp eat_digits(string, count) do
    {_parsed, rest} = parse_digits(string, count)
    rest
  end

  defp parse_digits(string, count) do
    case string do
      <<digits::bytes-size(count), rest::binary>> ->
        case Integer.parse(digits) do
          {digits, ""} ->
            {digits, rest}

          _other ->
            throw("expected #{count} digits but got unparsable integer: #{inspect(digits)}")
        end

      _other ->
        throw("expected #{count} digits, got: #{inspect(string)}")
    end
  end
end
