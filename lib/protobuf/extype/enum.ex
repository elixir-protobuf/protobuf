defimpl Extype.Protocol, for: Tuple do
  @moduledoc false

  require Logger

  def validate_and_to_atom_extype!({:enum, type}, "atom"), do: type
  def validate_and_to_atom_extype!(type, "atom") do
    raise "Invalid extype pairing, #{type} does not support the extype extension."
  end
  def validate_and_to_atom_extype!({:enum, _type}, extype) do
    raise "Invalid extype pairing, expected \"atom\", got #{extype}"
  end
  def validate_and_to_atom_extype!(type, extype) do
    raise "Invalid extype pairing, #{extype} not compatible with type #{type}."
  end

  def type_default({:enum, _enum_type}, _extype), do: 0

  # Never called as of now, because enums aren't an embedded field.
  def new(_type, value, _extype), do: value

  def skip?(type, v, _extype), do: Protobuf.Encoder.is_enum_default?(type, to_uppercase_atom(v))

  def encode_type({:enum, type}, v, _extype) when is_atom(v) do
    v |> to_uppercase_atom |> type.value() |> Protobuf.Encoder.encode_varint()
  end
  def encode_type({:enum, _}, v, _extype), do: Protobuf.Encoder.encode_varint(v)

  def decode_type({:enum, type}, val, _extype) do
    try do
      val
      |> type.key()
      |> to_lowercase_atom()
    rescue
      FunctionClauseError ->
        Logger.warn(
          "unknown enum value #{val} when decoding for #{inspect(type)}"
        )

        val
    end
  end

  def to_uppercase_atom(atom) do
    transform_atom(atom, &String.upcase/1)
  end

  def to_lowercase_atom(atom) do
    transform_atom(atom, &String.downcase/1)
  end

  defp transform_atom(atom, transformer) do
    string =
      atom
      |> Atom.to_string()
      |> transformer.()

    try do
      String.to_existing_atom(string)
    rescue
      ArgumentError -> String.to_atom(string)
    end
  end
end
