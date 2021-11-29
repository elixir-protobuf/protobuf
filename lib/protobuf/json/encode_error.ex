defmodule Protobuf.JSON.EncodeError do
  defexception [:message]

  @type t :: %__MODULE__{message: String.t()}

  def new({:unsupported_syntax, syntax}) do
    %__MODULE__{message: "JSON encoding of '#{syntax}' syntax is unsupported, try proto3"}
  end

  def new(:no_json_lib) do
    %__MODULE__{message: "JSON library not loaded, make sure to add :jason to your mix.exs file"}
  end

  def new({:bad_duration, :seconds_outside_of_range, seconds}) do
    %__MODULE__{
      message: "invalid Google.Protobuf.Duration, seconds are outside of range: #{seconds}"
    }
  end

  def new({:invalid_timestamp, timestamp, reason}) do
    %__MODULE__{
      message:
        "invalid Google.Protobuf.Timestamp value #{inspect(timestamp)}, reason: #{inspect(reason)}"
    }
  end

  def new({:bad_field_mask, mask}) do
    %__MODULE__{message: "unencodable field mask: #{inspect(mask)}"}
  end

  def new({:bad_encoding, term}) do
    %__MODULE__{message: "bad encoding: #{inspect(term)}"}
  end
end
