defmodule Protobuf.FieldOptionsProcessor do
  @moduledoc """
  Defines hooks to process custom field options.
  """

  @type options :: Keyword.t(String.t)

  @callback type_to_spec(type_enum :: atom, type :: String.t(), repeated :: boolean, options) :: String.t()

  def validate_options_str!(:TYPE_MESSAGE, "Google.Protobuf.StringValue", [extype: "String.t()" = extype]), do: extype
  def validate_options_str!(:TYPE_MESSAGE, "Google.Protobuf.StringValue", [extype: "String.t" = extype]), do: extype
  def validate_options_str!(_, type, options) do
    raise "The custom field option is invalid. Options: #{inspect(options)} incompatible with type: #{type}"
  end

  def type_to_spec(type_enum, type, repeated, options) do
    extype = validate_options_str!(type_enum, type, options)
    type_str = extype <> " | nil"
    if repeated do
      "[#{type_str}]"
    else
      type_str
    end
  end
end
