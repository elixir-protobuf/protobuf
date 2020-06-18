defmodule Protobuf.JSON.DecodeError do
  defexception [:message]

  @type t :: %__MODULE__{message: String.t()}

  def new({:unsupported_syntax, syntax}) do
    %__MODULE__{message: "JSON encoding of '#{syntax}' syntax is unsupported, try proto3"}
  end

  def new(:no_json_lib) do
    %__MODULE__{message: "JSON library not loaded, make sure to add :jason to your mix.exs file"}
  end

  def new({:bad_message, data}) do
    %__MODULE__{message: "JSON map expected, got: #{inspect(data)}"}
  end

  def new({:bad_string, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid string (#{inspect(value)})"}
  end

  def new({:bad_bool, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid boolean (#{inspect(value)})"}
  end

  def new({:bad_int, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid integer (#{inspect(value)})"}
  end

  def new({:bad_float, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid floating point (#{inspect(value)})"}
  end

  def new({:bad_bytes, field}) do
    %__MODULE__{message: "Field '#{field}' has an invalid Base64-encoded byte sequence"}
  end

  def new({:bad_enum, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid enum value (#{inspect(value)})"}
  end

  def new({:bad_map, field, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid map (#{inspect(value)})"}
  end

  def new({:bad_map_key, field, type, value}) do
    %__MODULE__{message: "Field '#{field}' has an invalid map key (#{type}: #{inspect(value)})"}
  end

  def new({:duplicated_oneof, oneof}) do
    %__MODULE__{message: "Oneof field '#{oneof}' cannot be set twice"}
  end

  def new({:bad_repeated, field, value}) do
    %__MODULE__{message: "Repeated field '#{field}' expected a list, got #{inspect(value)}"}
  end
end
