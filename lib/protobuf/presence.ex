defmodule Protobuf.Presence do
  @moduledoc """
  Helpers for determining Protobuf field presence.
  """

  alias Protobuf.FieldProps

  @doc """
  Returns whether a field or oneof is present, not present, or maybe present

  `:present` and `:not present` mean that a field is **explicitly** present or not,
  respectively.

  Some values may be implicitly present. For example, lists in `repeated` fields
  always have implicit presence. In these cases, if the presence is ambiguous,
  returns `:maybe`.

  For more information about field presence tracking rules, refer to the official
  [Field Presence docs](https://protobuf.dev/programming-guides/field_presence/).


  ## Examples

      # Non-optional proto3 field:
      Protobuf.Presence(%MyMessage{foo: 42}, :foo)
      #=> :present

      Protobuf.Presence(%MyMessage{foo: 0}, :foo)
      #=> :maybe

      Protobuf.Presence(%MyMessage{}, :foo)
      #=> :maybe

      # Optional proto3 field:
      Protobuf.Presence(%MyMessage{bar: 42}, :bar)
      #=> :present

      Protobuf.Presence(%MyMessage{bar: 0}, :bar)
      #=> :present

      Protobuf.Presence(%MyMessage{}, :bar)
      #=> :not_present

  """
  @spec field_presence(message :: struct(), field :: atom()) :: :present | :not_present | :maybe
  def field_presence(%mod{} = message, field) do
    message_props = mod.__message_props__()
    transformed_message = transform_module(message, mod)
    fnum = Map.fetch!(message_props.field_tags, field)
    field_prop = Map.fetch!(message_props.field_props, fnum)
    value = get_oneof_value(transformed_message, message_props, field, field_prop)

    transformed_value =
      case field_prop do
        %{embedded: true, type: mod} -> transform_module(value, mod)
        _ -> value
      end

    get_field_presence(message_props.syntax, transformed_value, field_prop)
  end

  defp get_oneof_value(message, message_props, field, field_prop) do
    case field_prop.oneof do
      nil ->
        Map.fetch!(message, field)

      oneof_num ->
        {oneof_field, _} = Enum.find(message_props.oneof, fn {_name, tag} -> tag == oneof_num end)

        case Map.fetch!(message, oneof_field) do
          {^field, value} -> value
          _ -> nil
        end
    end
  end

  defp transform_module(message, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(message, module)
    else
      message
    end
  end

  # We probably want to make this public eventually, but it makes sense to hold
  # it until we add editions support, since we definitely don't want to add
  # `syntax` in a public API
  @doc false
  @spec get_field_presence(:proto2 | :proto3, term(), FieldProps.t()) :: :present | :not_present | :maybe
  def get_field_presence(syntax, value, field_prop)

  # Repeated and maps are always implicit.
  def get_field_presence(_syntax, [], _prop) do
    :maybe
  end

  def get_field_presence(_syntax, val, _prop) when is_map(val) do
    if map_size(val) == 0 do
      :maybe
    else
      :present
    end
  end

  # For proto2 singular cardinality fields:
  #
  # - Non-one_of fields with default values have implicit presence
  # - Others have explicit presence
  def get_field_presence(:proto2, nil, _prop) do
    :not_present
  end

  def get_field_presence(:proto2, value, %FieldProps{default: value, oneof: nil}) do
    :maybe
  end

  def get_field_presence(:proto2, _value, _props) do
    :present
  end

  # For proto3 singular cardinality fields:
  #
  # - Optional and Oneof fields have explicit presence tracking
  # - Other fields have implicit presence tracking
  def get_field_presence(:proto3, nil, %FieldProps{proto3_optional?: true}) do
    :not_present
  end

  def get_field_presence(:proto3, _, %FieldProps{proto3_optional?: true}) do
    :present
  end

  def get_field_presence(_syntax, value, %FieldProps{oneof: oneof}) when not is_nil(oneof) do
    if is_nil(value) do
      :not_present
    else
      :present
    end
  end

  # Messages have explicit presence tracking in proto3
  def get_field_presence(:proto3, nil, _prop) do
    :not_present
  end

  # Defaults for different field types: implicit presence means they are maybe set
  def get_field_presence(:proto3, 0, _prop) do
    :maybe
  end

  def get_field_presence(:proto3, +0.0, _prop) do
    :maybe
  end

  def get_field_presence(:proto3, "", _prop) do
    :maybe
  end

  def get_field_presence(:proto3, false, _prop) do
    :maybe
  end

  def get_field_presence(_syntax, value, %FieldProps{type: {:enum, enum_mod}}) do
    if enum_default?(enum_mod, value) do
      :maybe
    else
      :present
    end
  end

  # Finally, everything else.
  def get_field_presence(_syntax, _val, _prop) do
    :present
  end

  defp enum_default?(enum_mod, val) when is_atom(val), do: enum_mod.value(val) == 0
  defp enum_default?(_enum_mod, val) when is_integer(val), do: val == 0
  defp enum_default?(_enum_mod, list) when is_list(list), do: false
end
