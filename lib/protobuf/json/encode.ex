defmodule Protobuf.JSON.Encode do
  @moduledoc """
  Internal JSON encoding API.
  """

  alias Protobuf.MessageProps

  @type encode_opt ::
          {:use_proto_names, boolean}
          | {:use_enum_numbers, boolean}
          | {:emit_unpopulated, boolean}

  @compile {:inline,
            encode_field: 3,
            encode_key: 2,
            maybe_repeat: 3,
            encode_float: 1,
            encode_enum: 3,
            safe_enum_key: 2}

  @doc false
  @spec encode(struct, MessageProps.t(), [encode_opt]) :: map
  def encode(%_{} = struct, %MessageProps{} = message_props, opts \\ []) do
    regular = encode_regular_fields(struct, message_props, opts)
    oneofs = encode_oneof_fields(struct, message_props, opts)

    :maps.from_list(regular ++ oneofs)
  end

  defp encode_regular_fields(struct, %{field_props: field_props}, opts) do
    for {_field_num, %{name_atom: name, oneof: nil} = prop} <- field_props,
        %{^name => value} = struct,
        opts[:emit_unpopulated] || !default?(prop, value) do
      encode_field(prop, value, opts)
    end
  end

  defp encode_oneof_fields(struct, message_props, opts) do
    %{field_tags: field_tags, field_props: field_props, oneof: oneofs} = message_props

    for {oneof_name, _index} <- oneofs,
        tag_and_value = Map.get(struct, oneof_name) do
      {tag, value} = tag_and_value
      prop = field_props[field_tags[tag]]
      encode_field(prop, value, opts)
    end
  end

  # TODO: handle invalid values? check types?
  defp encode_field(prop, value, opts) do
    {encode_key(prop, opts), encode_value(value, prop, opts)}
  end

  defp encode_key(prop, opts) do
    if opts[:use_proto_names], do: prop.name, else: prop.json_name
  end

  @int32_types ~w(int32 sint32 sfixed32 fixed32 uint32)a
  @int64_types ~w(int64 sint64 sfixed64 fixed64 uint64)a
  @float_types [:float, :double]
  @raw_types [:string, :bool] ++ @int32_types

  defp encode_value(nil, _prop, _opts), do: nil

  defp encode_value(value, %{type: type} = prop, _opts) when type in @raw_types do
    maybe_repeat(prop, value, & &1)
  end

  defp encode_value(value, %{type: type} = prop, _opts) when type in @int64_types do
    maybe_repeat(prop, value, &Integer.to_string/1)
  end

  defp encode_value(value, %{type: :bytes} = prop, _opts) do
    maybe_repeat(prop, value, &Base.encode64/1)
  end

  defp encode_value(value, %{type: type} = prop, _opts) when type in @float_types do
    maybe_repeat(prop, value, &encode_float/1)
  end

  defp encode_value(value, %{type: {:enum, enum}} = prop, opts) do
    maybe_repeat(prop, value, &encode_enum(enum, &1, opts))
  end

  # Map keys can be of any scalar type except float, double and bytes. Therefore, we need to
  # convert them to strings before encoding. Map values can be anything except another map.
  # According to the specs: "If you provide a key but no value for a map field, the behavior
  # when the field is serialized is language-dependent. In C++, Java, and Python the default
  # value for the type is serialized, while in other languages nothing is serialized". Here
  # we do serialize these values as `nil` by default.
  defp encode_value(map, %{map?: true, type: module}, opts) do
    %{field_props: field_props, field_tags: field_tags} = module.__message_props__()
    key_prop = field_props[field_tags[:key]]
    value_prop = field_props[field_tags[:value]]

    for {key, val} <- map, into: %{} do
      name = encode_value(key, key_prop, opts)
      value = encode_value(val, value_prop, opts)

      {to_string(name), value}
    end
  end

  defp encode_value(value, %{embedded?: true, type: module} = prop, opts) do
    props = module.__message_props__()
    maybe_repeat(prop, value, &encode(&1, props, opts))
  end

  defp encode_float(value) when is_float(value), do: value
  defp encode_float(:negative_infinity), do: "-Infinity"
  defp encode_float(:infinity), do: "Infinity"
  defp encode_float(:nan), do: "NaN"

  # TODO: maybe define a helper for all enums messages, with strict validation.
  defp encode_enum(enum, key, opts) when is_atom(key) do
    if opts[:use_enum_numbers], do: enum.value(key), else: key
  end

  defp encode_enum(enum, num, opts) when is_integer(num) do
    if opts[:use_enum_numbers], do: num, else: safe_enum_key(enum, num)
  end

  # proto3 allows unknown enum values, that is why we can't call enum.key(num) here.
  defp safe_enum_key(enum, num) do
    %{tags_map: tags_map, field_props: field_props} = enum.__message_props__()

    case field_props[tags_map[num]] do
      %{name_atom: key} -> key
      _ -> num
    end
  end

  defp maybe_repeat(%{repeated?: false}, val, fun), do: fun.(val)
  defp maybe_repeat(%{repeated?: true}, val, fun), do: Enum.map(val, fun)

  defp default?(_prop, value) when value in [nil, 0, false, [], "", 0.0, %{}], do: true
  defp default?(%{type: {:enum, enum}}, key) when is_atom(key), do: enum.value(key) == 0
  defp default?(_prop, _value), do: false
end
