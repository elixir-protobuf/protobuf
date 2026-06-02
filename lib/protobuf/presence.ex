defmodule Protobuf.Presence do
  @moduledoc false

  # Centralizes Protobuf field presence rules for the public
  # `Protobuf.field_presence/2` API and for encoder skip/emit decisions.

  alias Protobuf.{FieldProps, MessageProps}

  @type presence() :: :present | :not_present | :maybe

  @spec field_presence(message :: struct(), field :: atom()) :: presence()
  def field_presence(%mod{} = message, field) when is_atom(field) do
    message_props = mod.__message_props__()
    transformed_message = transform_module(message, mod)
    field_prop = field_prop!(message_props, field)
    value = field_value(transformed_message, message_props, field, field_prop)

    field_presence_for_value(message_props.syntax, value, field_prop)
  end

  defp field_prop!(%MessageProps{field_tags: field_tags, field_props: field_props}, field) do
    fnum = Map.fetch!(field_tags, field)
    Map.fetch!(field_props, fnum)
  end

  defp field_value(message, _message_props, field, %FieldProps{oneof: nil}) do
    Map.fetch!(message, field)
  end

  defp field_value(message, %MessageProps{oneof: oneofs}, field, %FieldProps{oneof: oneof_num}) do
    {oneof_field, _oneof_num} = Enum.find(oneofs, fn {_name, tag} -> tag == oneof_num end)

    case Map.fetch!(message, oneof_field) do
      {^field, value} -> value
      _other -> nil
    end
  end

  defp field_presence_for_value(
         syntax,
         value,
         %FieldProps{embedded?: true, type: mod} = field_prop
       )
       when not is_nil(value) do
    get_field_presence(syntax, transform_module(value, mod), field_prop)
  end

  defp field_presence_for_value(syntax, value, field_prop) do
    get_field_presence(syntax, value, field_prop)
  end

  @doc false
  @spec get_field_presence(:proto2 | :proto3, term(), FieldProps.t()) :: presence()
  def get_field_presence(syntax, value, field_prop)

  # Repeated fields and maps have implicit presence. Empty values are ambiguous:
  # they could be explicitly assigned or just be the generated default.
  def get_field_presence(_syntax, [], _field_prop), do: :maybe

  def get_field_presence(_syntax, %{} = value, %FieldProps{map?: true}) do
    if map_size(value) == 0 do
      :maybe
    else
      :present
    end
  end

  # Proto2 singular fields track explicit presence, but this library's struct
  # representation can't distinguish absent custom defaults from explicit ones.
  def get_field_presence(:proto2, nil, _field_prop), do: :not_present
  def get_field_presence(:proto2, value, %FieldProps{default: value, oneof: nil}), do: :maybe
  def get_field_presence(:proto2, _value, _field_prop), do: :present

  # Proto3 optional fields and oneofs track explicit presence.
  def get_field_presence(:proto3, nil, %FieldProps{proto3_optional?: true}), do: :not_present
  def get_field_presence(:proto3, _value, %FieldProps{proto3_optional?: true}), do: :present

  def get_field_presence(_syntax, value, %FieldProps{oneof: oneof}) when not is_nil(oneof) do
    if is_nil(value) do
      :not_present
    else
      :present
    end
  end

  def get_field_presence(:proto3, nil, _field_prop), do: :not_present
  def get_field_presence(:proto3, 0, _field_prop), do: :maybe
  def get_field_presence(:proto3, +0.0, _field_prop), do: :maybe
  def get_field_presence(:proto3, "", _field_prop), do: :maybe
  def get_field_presence(:proto3, false, _field_prop), do: :maybe

  def get_field_presence(_syntax, value, %FieldProps{type: {:enum, enum_mod}}) do
    if enum_default?(enum_mod, value) do
      :maybe
    else
      :present
    end
  end

  def get_field_presence(_syntax, _value, _field_prop), do: :present

  defp transform_module(value, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(value, module)
    else
      value
    end
  end

  defp enum_default?(enum_mod, value) when is_atom(value), do: enum_mod.value(value) == 0
  defp enum_default?(_enum_mod, value) when is_integer(value), do: value == 0
  defp enum_default?(_enum_mod, values) when is_list(values), do: false
end
