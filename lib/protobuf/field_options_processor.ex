defmodule Protobuf.FieldOptionsProcessor do
  @moduledoc """
  Defines hooks to process custom field options.
  """

  @typedoc """
  Keyword list of field options. Right now only [extype: mytype].
  """
  @type options :: Keyword.t(String.t)

  @typedoc """
  The existing type of the field. Often the module name of the struct.
  """
  @type type :: atom

  @typedoc """
  A value with type extype.
  """
  @type value :: struct | any
  @callback type_to_spec(type_enum :: atom, type :: String.t(), repeated :: boolean, options) :: String.t()
  @callback type_default(type, options) :: any
  @callback new(type, value, options) :: value
  @callback encode_type(type, value, options) :: binary
  @callback decode_type(val :: binary, type, options) :: value

  @wrappers [
    Google.Protobuf.DoubleValue,
    Google.Protobuf.FloatValue,
    Google.Protobuf.Int64Value,
    Google.Protobuf.UInt64Value,
    Google.Protobuf.Int32Value,
    Google.Protobuf.UInt32Value,
    Google.Protobuf.BoolValue,
    Google.Protobuf.StringValue,
    Google.Protobuf.BytesValue
  ]

  @wrappers_str [
    "Google.Protobuf.DoubleValue",
    "Google.Protobuf.FloatValue",
    "Google.Protobuf.Int64Value",
    "Google.Protobuf.UInt64Value",
    "Google.Protobuf.Int32Value",
    "Google.Protobuf.UInt32Value",
    "Google.Protobuf.BoolValue",
    "Google.Protobuf.StringValue",
    "Google.Protobuf.BytesValue"
  ]

  def get_extype_mod(type) do
    cond do
      type in @wrappers -> Protobuf.Extype.Wrappers
      true -> raise "Sorry #{type} does not support the field option extype"
    end
  end

  def get_extype_mod_string(:TYPE_MESSAGE, type) do
    cond do
      type in @wrappers_str -> Protobuf.Extype.Wrappers
      true -> raise "Sorry #{type} does not support the field option extype"
    end
  end

  def validate_options_str!(type_enum, type, extype: extype) do
    {get_extype_mod_string(type_enum, type), extype}
  end
  def validate_options_str!(_, type, options) do
    raise "The custom field option is invalid. Options: #{inspect(options)} incompatible with type: #{type}"
  end

  def validate_options!(type, extype: extype), do: {get_extype_mod(type), extype}
  def validate_options!(type, options) do
    raise "The custom field option is invalid. Options: #{inspect(options)} incompatible with type: #{type}"
  end


  def type_to_spec(type_enum, type, repeated, options) do
    {module, option_value} = validate_options_str!(type_enum, type, options)
    type_str = module.do_type_to_spec(type, option_value)

    if repeated do
      "[#{type_str}]"
    else
      type_str
    end
  end

  def type_default(type, options) do
    {module, option_value} = validate_options!(type, options)
    module.do_type_default(type, option_value)
  end

  def new(type, value, options) do
    {module, option_value} = validate_options!(type, options)
    module.do_new(type, value, option_value)
  end

  def encode_type(type, v, options) do
    {module, option_value} = validate_options!(type, options)
    module.do_encode_type(type, v, option_value)
  end

  def decode_type(val, type, options) do
    {module, option_value} = validate_options!(type, options)
    module.do_decode_type(type, val, option_value)
  end
end
