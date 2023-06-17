defmodule Google.Protobuf do
  @moduledoc """
  Utility functions for working with Google Protobuf structs.
  """

  @doc """
  Converts a `Google.Protobuf.Duration` struct to a value and `System.time_unit()`.

  ## Examples

      iex> to_time_unit(%Google.Protobuf.Duration{seconds: 10})
      {10, :second}

      iex> to_time_unit(%Google.Protobuf.Duration{seconds: 20, nanos: 100})
      {20_000_000_100, :nanosecond}

  """
  @spec to_time_unit(Google.Protobuf.Duration.t()) :: {integer(), System.time_unit()}
  def to_time_unit(%{seconds: seconds, nanos: 0}) do
    {seconds, :second}
  end

  def to_time_unit(%{seconds: seconds, nanos: nanos}) do
    {seconds * 1_000_000_000 + nanos, :nanosecond}
  end

  @doc """
  Converts a value and `System.time_unit()` to a `Google.Protobuf.Duration` struct.

  ## Examples

      iex> from_time_unit(420, :second)
      %Google.Protobuf.Duration{seconds: 420}

      iex> from_time_unit(11_111_111, :microsecond)
      %Google.Protobuf.Duration{seconds: 11, nanos: 111_111_000}

  """
  @spec from_time_unit(integer(), System.time_unit()) :: Google.Protobuf.Duration.t()
  def from_time_unit(seconds, :second) do
    struct(Google.Protobuf.Duration, %{
      seconds: seconds
    })
  end

  def from_time_unit(millisecond, :millisecond) do
    struct(Google.Protobuf.Duration, %{
      seconds: div(millisecond, 1_000),
      nanos: rem(millisecond, 1_000) * 1_000_000
    })
  end

  def from_time_unit(millisecond, :microsecond) do
    struct(Google.Protobuf.Duration, %{
      seconds: div(millisecond, 1_000_000),
      nanos: rem(millisecond, 1_000_000) * 1_000
    })
  end

  def from_time_unit(millisecond, :nanosecond) do
    struct(Google.Protobuf.Duration, %{
      seconds: div(millisecond, 1_000_000_000),
      nanos: rem(millisecond, 1_000_000_000)
    })
  end

  @doc """
  Converts a `Google.Protobuf.Struct` struct to a `map()` recursively
  converting values to their Elixir equivalents.

  ## Examples

      iex> to_map(%Google.Protobuf.Struct{})
      %{}

  """
  @spec to_map(Google.Protobuf.Struct.t()) :: map()
  def to_map(struct) do
    Map.new(struct.fields, fn {k, v} ->
      {k, to_map_value(v)}
    end)
  end

  defp to_map_value(%{kind: {:null_value, :NULL_VALUE}}), do: nil
  defp to_map_value(%{kind: {:number_value, value}}), do: value
  defp to_map_value(%{kind: {:string_value, value}}), do: value
  defp to_map_value(%{kind: {:bool_value, value}}), do: value

  defp to_map_value(%{kind: {:struct_value, struct}}),
    do: to_map(struct)

  defp to_map_value(%{kind: {:list_value, %{values: values}}}),
    do: Enum.map(values, &to_map_value/1)

  @doc """
  Converts a `map()` to a `Google.Protobuf.Struct` struct recursively
  wrapping values in their `Google.Protobuf.Value` equivalents.

  ## Examples

      iex> from_map(%{})
      %Google.Protobuf.Struct{}

  """
  @spec from_map(map()) :: Google.Protobuf.Struct.t()
  def from_map(map) do
    struct(Google.Protobuf.Struct, %{
      fields:
        Map.new(map, fn {k, v} ->
          {to_string(k), from_map_value(v)}
        end)
    })
  end

  defp from_map_value(nil) do
    struct(Google.Protobuf.Value, %{kind: {:null_value, :NULL_VALUE}})
  end

  defp from_map_value(value) when is_number(value) do
    struct(Google.Protobuf.Value, %{kind: {:number_value, value}})
  end

  defp from_map_value(value) when is_binary(value) do
    struct(Google.Protobuf.Value, %{kind: {:string_value, value}})
  end

  defp from_map_value(value) when is_boolean(value) do
    struct(Google.Protobuf.Value, %{kind: {:bool_value, value}})
  end

  defp from_map_value(value) when is_map(value) do
    struct(Google.Protobuf.Value, %{kind: {:struct_value, from_map(value)}})
  end

  defp from_map_value(value) when is_list(value) do
    struct(Google.Protobuf.Value, %{
      kind:
        {:list_value,
         struct(Google.Protobuf.ListValue, %{
           values: Enum.map(value, &from_map_value/1)
         })}
    })
  end

  @doc """
  Converts a `DateTime` struct to a `Google.Protobuf.Timestamp` struct.

  Note: Elixir `DateTime.from_unix!/2` will convert units to
  microseconds internally. Nanosecond precision is not guaranteed.
  See examples for details.

  ## Examples

      iex> to_datetime(%Google.Protobuf.Timestamp{seconds: 5, nanos: 0})
      ~U[1970-01-01 00:00:05.000000Z]

      iex> one = to_datetime(%Google.Protobuf.Timestamp{seconds: 10, nanos: 100})
      ...> two = to_datetime(%Google.Protobuf.Timestamp{seconds: 10, nanos: 105})
      ...> DateTime.diff(one, two, :nanosecond)
      0

  """
  @spec to_datetime(Google.Protobuf.Timestamp.t()) :: DateTime.t()
  def to_datetime(%{seconds: seconds, nanos: nanos}) do
    DateTime.from_unix!(seconds * 1_000_000_000 + nanos, :nanosecond)
  end

  @doc """
    Converts a `Google.Protobuf.Timestamp` struct to a `DateTime` struct.

    ## Examples

        iex> from_datetime(~U[1970-01-01 00:00:05.000000Z])
        %Google.Protobuf.Timestamp{seconds: 5, nanos: 0}

  """
  @spec from_datetime(DateTime.t()) :: Google.Protobuf.Timestamp.t()
  def from_datetime(%DateTime{} = datetime) do
    nanoseconds = DateTime.to_unix(datetime, :nanosecond)

    struct(Google.Protobuf.Timestamp, %{
      seconds: div(nanoseconds, 1_000_000_000),
      nanos: rem(nanoseconds, 1_000_000_000)
    })
  end
end
