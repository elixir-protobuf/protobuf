defmodule Protobuf.FieldOptionsProcessor do
  @moduledoc """
  Defines hooks to process custom field options.
  """

  @typedoc """
  Keyword list of field options. Right now only [extype: mytype].
  """
  @type options :: Keyword.t(String.t())

  @typedoc """
  The existing type of the field. Often the module name of the struct.
  """
  @type type :: atom

  @typedoc """
  A value with type extype.
  """
  @type value :: struct | any
  @callback type_to_spec(type_enum :: atom, type :: String.t(), repeated :: boolean, options) ::
              String.t()
  @callback type_default(type, options) :: any
  @callback new(type, value, options) :: value
  @callback skip?(type, value, options) :: boolean
  @callback encode_type(type, value, options) :: binary
  @callback decode_type(val :: binary, type, options) :: value

  def get_mod(options) do
    case Keyword.get(options, :extype) do
      nil -> {EnumTransform, Keyword.fetch!(options, :enum)}
      extype -> {Extype, extype}
    end
  end

  def type_to_spec(type_enum, type, repeated, []) do
    Protobuf.TypeUtil.enum_to_spec(type_enum, type, repeated)
  end

  def type_to_spec(_type_enum, type, repeated, options) do
    {mod, option} = get_mod(options)
    mod.type_to_spec(type, repeated, option)
  end

  def type_default(type, _props, []), do: Protobuf.Builder.type_default(type)

  def type_default(_type, %{repeated?: true}, _options), do: []

  def type_default(type, _props, options) do
    {mod, option} = get_mod(options)
    mod.type_default(type, option)
  end

  def new(type, value, []), do: type.new(value)

  def new(type, value, options) do
    {mod, option} = get_mod(options)
    mod.new(type, value, option)
  end

  def skip?(type, value, _prop, []), do: Protobuf.Encoder.is_enum_default?(type, value)
  def skip?(_type, nil, _prop, _options), do: true
  def skip?(_type, _value, %{repeated?: true}, _options), do: false
  def skip?(_type, _value, %{oneof: oneof}, _options) when not is_nil(oneof), do: false

  def skip?(type, value, _prop, options) do
    {mod, option} = get_mod(options)
    mod.skip?(type, value, option)
  end

  def encode_type(type, v, []), do: Protobuf.Encoder.encode(type, v, [])

  def encode_type(type, v, options) do
    {mod, option} = get_mod(options)
    mod.encode_type(type, v, option)
  end

  def decode_type(val, type, []), do: Protobuf.Decoder.decode(val, type)

  def decode_type(val, type, options) do
    {mod, option} = get_mod(options)
    mod.decode_type(val, type, option)
  end
end
