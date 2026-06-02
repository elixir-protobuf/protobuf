defmodule Protobuf.JSON.JSONLibrary do
  @moduledoc false

  alias Protobuf.JSON.{DecodeError, EncodeError, Object}

  # Uses `JSON` for encoding on Elixir >= 1.18 because it supports the Elixir encoder protocol,
  # Jason otherwise.

  def encode_to_iodata(encodable) do
    cond do
      Code.ensure_loaded?(JSON) ->
        try do
          {:ok, apply(JSON, :encode_to_iodata!, [encodable])}
        rescue
          exception ->
            {:error, exception}
        end

      Code.ensure_loaded?(Jason) ->
        apply(Jason, :encode_to_iodata, [encodable])

      true ->
        {:error, EncodeError.new(:no_json_lib)}
    end
  end

  def decode(data) do
    cond do
      Code.ensure_loaded?(JSON) and function_exported?(JSON, :decode, 3) ->
        decode_with_elixir_json(data)

      Code.ensure_loaded?(Jason) ->
        apply(Jason, :decode, [data])

      true ->
        {:error, DecodeError.new(:no_json_lib)}
    end
  end

  defp decode_with_elixir_json(data) do
    case apply(JSON, :decode, [data, nil, json_decoders()]) do
      {decoded, nil, rest} -> finalize_decode(decoded, rest)
      {:error, reason} -> {:error, DecodeError.new(reason)}
    end
  end

  defp finalize_decode(decoded, rest) do
    if json_whitespace?(rest) do
      {:ok, decoded}
    else
      {:error, DecodeError.new({:trailing_data, rest})}
    end
  end

  defp json_decoders do
    [object_finish: &object_finish/2]
  end

  defp object_finish(members, old_acc), do: {Object.new(Enum.reverse(members)), old_acc}

  defp json_whitespace?(<<>>), do: true

  defp json_whitespace?(<<byte, rest::binary>>) when byte in [?\s, ?\t, ?\n, ?\r],
    do: json_whitespace?(rest)

  defp json_whitespace?(_rest), do: false
end
