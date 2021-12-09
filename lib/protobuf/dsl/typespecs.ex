defmodule Protobuf.DSL.Typespecs do
  @moduledoc false

  alias Protobuf.{FieldProps, MessageProps}

  @spec quoted_enum_typespec(MessageProps.t()) :: Macro.t()
  def quoted_enum_typespec(%MessageProps{field_props: field_props}) do
    atom_specs =
      field_props
      |> Enum.map(fn {_fnum, %FieldProps{name_atom: name}} -> name end)
      |> union_specs()

    quote do
      integer() | unquote(atom_specs)
    end
  end

  @spec quoted_message_typespec(MessageProps.t()) :: Macro.t()
  def quoted_message_typespec(%MessageProps{} = message_props) do
    regular_fields =
      for {_fnum, prop} <- message_props.field_props,
          is_nil(prop.oneof),
          do: {prop.name_atom, field_prop_to_spec(prop)}

    oneof_fields =
      for {field_name, fnum} <- message_props.oneof do
        possible_fields =
          for {_fnum, prop} <- message_props.field_props,
              prop.oneof == fnum,
              do: prop

        {field_name, oneof_spec(possible_fields)}
      end

    extension_fields =
      if is_list(message_props.extension_range) and message_props.extension_range != [] do
        [{:__pb_extensions__, quote(do: map())}]
      else
        []
      end

    quote do
      %__MODULE__{unquote_splicing(regular_fields ++ oneof_fields ++ extension_fields)}
    end
  end

  defp oneof_spec(possible_oneof_fields) do
    possible_oneof_fields
    |> Enum.map(fn prop ->
      quote do: {unquote(prop.name_atom), unquote(field_prop_to_spec(prop))}
    end)
    |> union_specs()
  end

  defp field_prop_to_spec(%FieldProps{map?: true, type: map_mod} = prop) do
    Code.ensure_loaded!(map_mod)
    map_props = map_mod.__message_props__()

    key_spec = scalar_type_to_spec(map_props.field_props[map_props.field_tags.key].type)
    value_prop = map_props.field_props[map_props.field_tags.value]

    value_spec = type_to_spec(value_prop.type, value_prop)

    value_spec = if prop.embedded?, do: quote(do: unquote(value_spec) | nil), else: value_spec
    quote do: %{optional(unquote(key_spec)) => unquote(value_spec)}
  end

  defp field_prop_to_spec(%FieldProps{type: type} = prop) do
    spec = type_to_spec(type, prop)

    cond do
      prop.repeated? -> quote do: [unquote(spec)]
      prop.embedded? -> quote do: unquote(spec) | nil
      true -> spec
    end
  end

  defp field_prop_to_spec(%FieldProps{repeated?: true} = prop) do
    nested_spec = field_prop_to_spec(%FieldProps{prop | repeated?: false})
    quote do: [unquote(nested_spec)]
  end

  defp field_prop_to_spec(%FieldProps{embedded?: true, type: mod}) do
    quote do: unquote(mod).t()
  end

  defp field_prop_to_spec(%FieldProps{optional?: true} = prop) do
    nested_spec = field_prop_to_spec(%FieldProps{prop | optional?: false})
    quote do: unquote(nested_spec) | nil
  end

  defp field_prop_to_spec(%FieldProps{}) do
    quote do: term()
  end

  defp type_to_spec({:enum, enum_mod}, _prop), do: quote(do: unquote(enum_mod).t())
  defp type_to_spec(mod, %FieldProps{embedded?: true}), do: quote(do: unquote(mod).t())
  defp type_to_spec(:group, _prop), do: quote(do: term())
  defp type_to_spec(type, _prop), do: scalar_type_to_spec(type)

  defp scalar_type_to_spec(:string), do: quote(do: String.t())
  defp scalar_type_to_spec(:bytes), do: quote(do: binary())
  defp scalar_type_to_spec(:bool), do: quote(do: boolean())

  defp scalar_type_to_spec(type)
       when type in [:int32, :int64, :sint32, :sint64, :sfixed32, :sfixed64],
       do: quote(do: integer())

  defp scalar_type_to_spec(type)
       when type in [:uint32, :uint64, :fixed32, :fixed64],
       do: quote(do: non_neg_integer())

  defp scalar_type_to_spec(type) when type in [:float, :double],
    do: quote(do: float() | :infinity | :negative_infinity | :nan)

  # We do this because the :| operator is left-associative, so if we just map and build "acc |
  # spec" then we end up with "((foo | bar) | baz) | bong". By building it from right to left, it
  # works just fine.
  defp union_specs(specs) do
    Enum.reduce(Enum.reverse(specs), fn spec, acc ->
      quote do: unquote(spec) | unquote(acc)
    end)
  end
end
