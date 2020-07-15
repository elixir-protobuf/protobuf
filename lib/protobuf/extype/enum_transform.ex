defmodule EnumTransform do
  @moduledoc """
  Transforms enums if the enum field extension is present. Accepted values are lowercase, deprefix,
  and atomize. Atomize is an alias for deprefix and lowercase.
  """

  require Protobuf.Decoder
  require Logger
  import Protobuf.Decoder, only: [decode_zigzag: 1]

  @type transform :: String.t()

  @type type :: {:enum, atom}

  @type value :: atom

  def validate_and_get_transformers!({:enum, _type}, transform) when is_binary(transform) do
    transform
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.sort()
    |> Enum.flat_map(fn
      "lowercase" ->
        [EnumTransform.Lowercase]

      "deprefix" ->
        [EnumTransform.Deprefix]

      "atomize" ->
        [EnumTransform.Deprefix, EnumTransform.Lowercase]

      _ ->
        raise "Invalid enum transformation: #{transform}. Accepted values are lowercase, deprefix, and atomize"
    end)
    |> Enum.uniq()
  end

  def validate_and_get_transformers!(type, _transform) do
    raise "Enum transformation applied to incorrect type: #{type}."
  end

  # TODO: add lowercase, deprefixed to spec?
  @spec type_to_spec(type :: String.t(), repeated :: boolean, transform :: String.t()) ::
          String.t()
  def type_to_spec(type, repeated, _transform) do
    if repeated, do: "[#{type}.t]", else: type <> ".t"
  end

  @spec type_default(type, transform) :: any
  def type_default({:enum, enum_type} = type, transform) do
    mods = validate_and_get_transformers!(type, transform)
    transform_atom(type, enum_type.key(0), mods, :backward)
  end

  # Note: Never called as of now, because enums aren't an embedded field.
  @spec new(type, value, transform) :: value
  def new(type, value, transform) do
    validate_and_get_transformers!(type, transform)
    value
  end

  def skip?(type, v, transform) do
    mods = validate_and_get_transformers!(type, transform)
    v = transform_atom(type, v, mods, :forward)
    Protobuf.Encoder.is_enum_default?(type, v)
  end

  @spec encode_type(type, value, transform) :: binary
  def encode_type(type, v, transform) do
    mods = validate_and_get_transformers!(type, transform)
    v = transform_atom(type, v, mods, :forward)
    Protobuf.Encoder.encode_type(type, v)
  end

  @spec decode_type(val :: binary, type, transform) :: value
  def decode_type(val, type, transform) do
    mods = validate_and_get_transformers!(type, transform)
    # Pass decode_type_m a false key. Should be field name
    val = Protobuf.Decoder.decode_type_m(type, :enum, val)
    transform_atom(type, val, mods, :backward)
  end

  defp transform_atom(type, atom, mods, direction) do
    value = Atom.to_string(atom)

    # Review: very functional. Can anyone read it?
    value = Enum.reduce(mods, value, fn mod, v -> Kernel.apply(mod, direction, [type]).(v) end)

    try do
      String.to_existing_atom(value)
    rescue
      ArgumentError -> String.to_atom(value)
    end
  end
end

defmodule EnumTransform.Lowercase do
  @moduledoc """
  Converts enums to lowercase.
  """

  def forward(_type), do: &String.upcase/1

  def backward(_type), do: &String.downcase/1
end

defmodule EnumTransform.Deprefix do
  @moduledoc """
  Deprefixes enums according to the enum message name.
  """

  def forward({:enum, type}), do: &String.replace_prefix(&1, "", type.prefix)

  def backward({:enum, type}), do: &String.replace_prefix(&1, type.prefix, "")
end
