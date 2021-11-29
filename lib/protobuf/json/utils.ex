defmodule Protobuf.JSON.Utils do
  @moduledoc false

  @compile {:inline, check_syntax: 1}

  @doc false
  def message_props(module) when is_atom(module), do: check_syntax(module)
  def message_props(%module{}), do: check_syntax(module)

  defp check_syntax(module) do
    case module.__message_props__() do
      %Protobuf.MessageProps{syntax: :proto3} = props -> props
      %Protobuf.MessageProps{syntax: syntax} -> throw({:unsupported_syntax, syntax})
    end
  end

  # Used to encode nanoseconds for Google.Protobuf.Duration and Google.Protobuf.Timestamp.
  # Examples:
  # 1 -> "000000001"
  # 1_000 -> "001000"
  # 1_000_000 -> "001000000"
  # 999_999_999 -> "999999999"
  @doc false
  @spec format_nanoseconds(integer()) :: String.t()
  def format_nanoseconds(nanoseconds)
      when nanoseconds >= -999_999_999 and nanoseconds <= 999_999_999 do
    nanoseconds
    |> abs()
    |> Integer.to_string()
    |> String.pad_leading(9, "0")
    |> String.trim_trailing("000")
    |> String.trim_trailing("000")
  end

  # Used to decode nanoseconds for Google.Protobuf.Duration and Google.Protobuf.Timestamp (in
  # Protobuf.JSON.RFC3339). Has the same spec as Integer.parse/2.
  # Examples:
  # "100" -> 100_000_000 (nanosec)
  # "000010" => 10_000 (nanosec)
  # "000000001" => 1 (nanosec)
  # "01" -> 10_000_000 (nanosec)
  @doc false
  @spec parse_nanoseconds(binary()) :: {nanoseconds :: integer(), rest :: binary()} | :error
  def parse_nanoseconds(binary) when is_binary(binary) do
    case parse_nanoseconds(binary, _acc = 0, _starting_power = 100_000_000) do
      :error -> :error
      {_, ^binary} -> :error
      {_nanoseconds, _rest} = result -> result
    end
  end

  defp parse_nanoseconds(<<digit, _rest::binary>>, _acc, _power = 0) when digit in ?0..?9 do
    :error
  end

  defp parse_nanoseconds(<<digit, rest::binary>>, acc, power) when digit in ?0..?9 do
    digit = digit - ?0
    parse_nanoseconds(rest, acc + digit * power, div(power, 10))
  end

  defp parse_nanoseconds(rest, acc, _power) do
    {acc, rest}
  end
end
