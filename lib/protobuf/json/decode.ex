defmodule Protobuf.JSON.Decode do
  @moduledoc false

  import Bitwise, only: [bsl: 2]

  alias Protobuf.JSON.Utils

  @compile {:inline,
            field_value: 2,
            decode_map: 2,
            decode_repeated: 2,
            decode_integer: 1,
            decode_float: 1,
            parse_float: 1,
            decode_bytes: 1,
            decode_key: 3,
            parse_key: 2}

  @int32_range -bsl(1, 31)..(bsl(1, 31) - 1)
  @int64_range -bsl(1, 63)..(bsl(1, 63) - 1)
  @uint32_range 0..(bsl(1, 32) - 1)
  @uint64_range 0..(bsl(1, 64) - 1)

  @int_ranges %{
    int32: @int32_range,
    int64: @int64_range,
    sint32: @int32_range,
    sint64: @int64_range,
    sfixed32: @int32_range,
    sfixed64: @int64_range,
    fixed32: @int32_range,
    fixed64: @int64_range,
    uint32: @uint32_range,
    uint64: @uint64_range
  }

  @int_types Map.keys(@int_ranges)

  @float_types [:float, :double]

  def from_json_data(data, module) when is_map(data) and is_atom(module) do
    message_props = Utils.message_props(module)
    regular = decode_regular_fields(data, message_props)
    oneofs = decode_oneof_fields(data, message_props)

    module.__default_struct__()
    |> struct(regular)
    |> struct(oneofs)
  end

  def from_json_data(data, module) when is_atom(module), do: throw({:bad_message, data})

  defp decode_regular_fields(data, %{field_props: field_props}) do
    for {_field_num, %{oneof: nil} = prop} <- field_props,
        value = field_value(prop, data) do
      {prop.name_atom, decode_value(prop, value)}
    end
  end

  defp decode_oneof_fields(data, %{field_props: field_props, oneof: oneofs}) do
    for {oneof, index} <- oneofs,
        {_field_num, %{oneof: ^index} = prop} <- field_props,
        not is_nil(value = field_value(prop, data)) do
      {oneof, prop, value}
    end
    |> Enum.reduce(%{}, fn {oneof, prop, value}, acc ->
      Map.update(acc, oneof, {prop.name_atom, decode_value(prop, value)}, fn _ ->
        throw({:duplicated_oneof, oneof})
      end)
    end)
  end

  defp field_value(%{json_name: json_key, name: name_key}, data) do
    case data do
      %{^json_key => value} -> value
      %{^name_key => value} -> value
      _ -> nil
    end
  end

  defp decode_value(%{map?: true} = prop, map), do: decode_map(prop, map)
  defp decode_value(%{repeated?: true} = prop, list), do: decode_repeated(prop, list)
  defp decode_value(%{repeated?: false} = prop, value), do: decode_singular(prop, value)

  defp decode_map(%{type: module, name_atom: field}, map) when is_map(map) do
    %{field_props: field_props, field_tags: field_tags} = Utils.message_props(module)
    key_type = field_props[field_tags[:key]].type
    val_prop = field_props[field_tags[:value]]

    for {key, val} <- map, into: %{} do
      {decode_key(key_type, key, field), decode_singular(val_prop, val)}
    end
  end

  defp decode_map(prop, bad_map), do: throw({:bad_map, prop.name_atom, bad_map})

  defp decode_key(type, key, field) when is_binary(key) do
    case parse_key(type, key) do
      {:ok, decoded} -> decoded
      :error -> throw({:bad_map_key, field, type, key})
    end
  end

  defp decode_key(type, key, field), do: throw({:bad_map_key, field, type, key})

  # Map keys can be of any scalar type except float, double and bytes. they
  # must always be wrapped in strings. Other types should not compile.
  defp parse_key(:string, key), do: {:ok, key}
  defp parse_key(:bool, "true"), do: {:ok, true}
  defp parse_key(:bool, "false"), do: {:ok, false}
  defp parse_key(type, key) when type in @int_types, do: parse_int(key)
  defp parse_key(_type, _key), do: :error

  defp decode_repeated(prop, value) when is_list(value) do
    for val <- value, do: decode_singular(prop, val)
  end

  defp decode_repeated(prop, value) do
    throw({:bad_repeated, prop.name_atom, value})
  end

  defp decode_singular(%{type: :string} = prop, value) do
    if is_binary(value),
      do: value,
      else: throw({:bad_string, prop.name_atom, value})
  end

  defp decode_singular(%{type: :bool} = prop, value) do
    if is_boolean(value),
      do: value,
      else: throw({:bad_bool, prop.name_atom, value})
  end

  defp decode_singular(%{type: type} = prop, value) when type in @int_types do
    with {:ok, integer} <- decode_integer(value),
         true <- integer in @int_ranges[type] do
      integer
    else
      _ -> throw({:bad_int, prop.name_atom, value})
    end
  end

  defp decode_singular(%{type: type} = prop, value) when type in @float_types do
    case decode_float(value) do
      {:ok, float} -> float
      _ -> throw({:bad_float, prop.name_atom, value})
    end
  end

  defp decode_singular(%{type: :bytes} = prop, value) do
    with true <- is_binary(value),
         {:ok, bytes} <- decode_bytes(value) do
      bytes
    else
      _ -> throw({:bad_bytes, prop.name_atom})
    end
  end

  defp decode_singular(%{type: {:enum, enum}} = prop, value) do
    Map.get_lazy(enum.__reverse_mapping__(), value, fn ->
      if is_integer(value) && value in @int32_range,
        do: value,
        else: throw({:bad_enum, prop.name_atom, value})
    end)
  end

  defp decode_singular(%{type: module, embedded?: true}, value) do
    from_json_data(value, module)
  end

  defp decode_integer(integer) when is_integer(integer), do: {:ok, integer}
  defp decode_integer(string) when is_binary(string), do: parse_int(string)
  defp decode_integer(_bad), do: :error

  defp parse_int(string) do
    case Integer.parse(string) do
      {int, ""} -> {:ok, int}
      _ -> :error
    end
  end

  defp decode_float(float) when is_float(float), do: {:ok, float}
  defp decode_float(string) when is_binary(string), do: parse_float(string)
  defp decode_float(_bad), do: :error

  defp parse_float("-Infinity"), do: {:ok, :negative_infinity}
  defp parse_float("Infinity"), do: {:ok, :infinity}
  defp parse_float("NaN"), do: {:ok, :nan}

  defp parse_float(string) do
    case Float.parse(string) do
      {float, ""} -> {:ok, float}
      _ -> :error
    end
  end

  # Both url-encoded and regular base64 are accepted, with and without padding.
  defp decode_bytes(bytes) do
    pattern = :binary.compile_pattern(["-", "_"])

    if String.contains?(bytes, pattern) do
      Base.url_decode64(bytes, padding: false)
    else
      Base.decode64(bytes, padding: false)
    end
  end
end
