defmodule Protobuf.Encoder do
  @moduledoc false

  import Protobuf.Wire.Types
  import Bitwise, only: [bsl: 2, bor: 2]

  alias Protobuf.{FieldProps, MessageProps, Wire, Wire.Varint}

  @spec encode(struct(), keyword()) :: iodata()
  def encode(%mod{} = struct, opts) when is_list(opts) do
    iolist? =
      case Keyword.get(opts, :iolist, false) do
        value when is_boolean(value) -> value
        other -> raise ArgumentError, "expected bool for :iolist option, got: #{inspect(other)}"
      end

    case encode_with_message_props(struct, mod.__message_props__()) do
      result when iolist? -> result
      result -> IO.iodata_to_binary(result)
    end
  end

  defp encode(mod, msg, opts) do
    case msg do
      %{__struct__: ^mod} -> encode(msg, opts)
      _ -> encode(mod.new(msg), opts)
    end
  end

  defp encode_with_message_props(
         struct,
         %MessageProps{syntax: syntax, field_props: field_props} = props
       ) do
    oneofs = oneof_actual_vals(props, struct)

    encoded = encode_fields(Map.values(field_props), syntax, struct, oneofs, _acc = [])

    if syntax == :proto2 do
      [encoded | encode_extensions(struct)]
    else
      encoded
    end
  end

  defp encode_fields(_fields = [], _syntax, _struct, _oneofs, acc) do
    acc
  end

  defp encode_fields(
         [%FieldProps{name_atom: name, oneof: oneof} = prop | rest],
         syntax,
         struct,
         oneofs,
         acc
       ) do
    val =
      if oneof do
        oneofs[name]
      else
        Map.get(struct, name, nil)
      end

    acc =
      case encode_field(class_field(prop), val, syntax, prop) do
        {:ok, iodata} -> [acc | iodata]
        :skip -> acc
      end

    encode_fields(rest, syntax, struct, oneofs, acc)
  rescue
    error ->
      raise Protobuf.EncodeError,
        message:
          "Got error when encoding #{inspect(struct.__struct__)}##{prop.name_atom}: #{Exception.format(:error, error)}"
  end

  defp skip_field?(_syntax, [], _prop), do: true
  defp skip_field?(_syntax, val, _prop) when is_map(val), do: map_size(val) == 0
  defp skip_field?(:proto2, nil, %FieldProps{optional?: optional?}), do: optional?
  defp skip_field?(:proto2, value, %FieldProps{default: value}), do: true
  defp skip_field?(:proto3, nil, _prop), do: true
  defp skip_field?(:proto3, 0, %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, 0.0, %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, "", %FieldProps{oneof: nil}), do: true
  defp skip_field?(:proto3, false, %FieldProps{oneof: nil}), do: true
  defp skip_field?(_syntax, _val, _prop), do: false

  defp encode_field(
         :normal,
         val,
         syntax,
         %FieldProps{encoded_fnum: fnum, type: type, repeated?: repeated?} = prop
       ) do
    if skip_field?(syntax, val, prop) or skip_enum?(syntax, val, prop) do
      :skip
    else
      iodata = apply_or_map(val, repeated?, &[fnum | Wire.from_proto(type, &1)])
      {:ok, iodata}
    end
  end

  defp encode_field(:embedded, _val = nil, _syntax, _prop) do
    :skip
  end

  defp encode_field(
         :embedded,
         val,
         syntax,
         %FieldProps{encoded_fnum: fnum, repeated?: repeated?, map?: map?, type: type} = prop
       ) do
    result =
      apply_or_map(val, repeated? || map?, fn val ->
        val = transform_module(val, type)

        if skip_field?(syntax, val, prop) do
          ""
        else
          val = if map?, do: struct(type, %{key: elem(val, 0), value: elem(val, 1)}), else: val

          # so that oneof {:atom, val} can be encoded
          encoded = encode(type, val, iolist: true)
          byte_size = IO.iodata_length(encoded)
          [fnum | Varint.encode(byte_size)] ++ encoded
        end
      end)

    {:ok, result}
  end

  defp encode_field(:packed, val, syntax, %FieldProps{type: type, encoded_fnum: fnum} = prop) do
    if skip_field?(syntax, val, prop) or skip_enum?(syntax, val, prop) do
      :skip
    else
      encoded = Enum.map(val, &Wire.from_proto(type, &1))
      byte_size = IO.iodata_length(encoded)
      {:ok, [fnum | Varint.encode(byte_size)] ++ encoded}
    end
  end

  defp transform_module(message, module) do
    if transform_module = module.transform_module() do
      transform_module.encode(message, module)
    else
      message
    end
  end

  defp class_field(%FieldProps{wire_type: wire_delimited(), embedded?: true}), do: :embedded
  defp class_field(%FieldProps{repeated?: true, packed?: true}), do: :packed
  defp class_field(_prop), do: :normal

  @doc false
  @spec encode_fnum(integer, integer) :: binary
  def encode_fnum(fnum, wire_type) do
    fnum
    |> bsl(3)
    |> bor(wire_type)
    |> Varint.encode()
    |> IO.iodata_to_binary()
  end

  @doc false
  @spec wire_type(atom) :: integer
  def wire_type(:int32), do: wire_varint()
  def wire_type(:int64), do: wire_varint()
  def wire_type(:uint32), do: wire_varint()
  def wire_type(:uint64), do: wire_varint()
  def wire_type(:sint32), do: wire_varint()
  def wire_type(:sint64), do: wire_varint()
  def wire_type(:bool), do: wire_varint()
  def wire_type({:enum, _}), do: wire_varint()
  def wire_type(:enum), do: wire_varint()
  def wire_type(:fixed64), do: wire_64bits()
  def wire_type(:sfixed64), do: wire_64bits()
  def wire_type(:double), do: wire_64bits()
  def wire_type(:string), do: wire_delimited()
  def wire_type(:bytes), do: wire_delimited()
  def wire_type(:fixed32), do: wire_32bits()
  def wire_type(:sfixed32), do: wire_32bits()
  def wire_type(:float), do: wire_32bits()
  def wire_type(mod) when is_atom(mod), do: wire_delimited()

  defp apply_or_map(val, _repeated? = true, func), do: Enum.map(val, func)
  defp apply_or_map(val, _repeated? = false, func), do: func.(val)

  defp skip_enum?(:proto2, _value, _prop), do: false
  defp skip_enum?(_syntax, _value, %FieldProps{enum?: false}), do: false

  defp skip_enum?(_syntax, _value, %FieldProps{enum?: true, oneof: oneof}) when not is_nil(oneof),
    do: false

  defp skip_enum?(_syntax, _value, %FieldProps{required?: true}), do: false
  defp skip_enum?(_syntax, value, %FieldProps{type: type}), do: enum_default?(type, value)

  defp enum_default?({:enum, enum_mod}, val) when is_atom(val), do: enum_mod.value(val) == 0
  defp enum_default?({:enum, _enum_mod}, val) when is_integer(val), do: val == 0
  defp enum_default?({:enum, _enum_mod}, list) when is_list(list), do: false

  # Returns a map of %{field_name => field_value} from oneofs. For example, if you have:
  # oneof body {
  #   string a = 1;
  #   string b = 2
  # }
  # Then this could return: %{a: "some value"}
  defp oneof_actual_vals(
         %MessageProps{field_tags: field_tags, field_props: field_props, oneof: oneof},
         struct
       ) do
    Enum.reduce(oneof, %{}, fn {field, index}, acc ->
      case Map.fetch(struct, field) do
        {:ok, {field_name, value}} when is_atom(field_name) ->
          %FieldProps{oneof: oneof} = field_props[field_tags[field_name]]

          if oneof != index do
            raise Protobuf.EncodeError,
              message:
                "#{inspect(field_name)} doesn't belong to #{inspect(struct.__struct__)}##{field}"
          else
            Map.put(acc, field_name, value)
          end

        {:ok, nil} ->
          acc

        :error ->
          acc

        other ->
          raise Protobuf.EncodeError,
            message:
              "#{inspect(struct.__struct__)}##{field} should be {key, val}, got: #{inspect(other)}"
      end
    end)
  end

  defp encode_extensions(%mod{__pb_extensions__: pb_exts}) when is_map(pb_exts) do
    Enum.reduce(pb_exts, [], fn {{ext_mod, key}, val}, acc ->
      case Protobuf.Extension.get_extension_props(mod, ext_mod, key) do
        %{field_props: prop} ->
          case encode_field(class_field(prop), val, :proto2, prop) do
            {:ok, iodata} -> [acc | iodata]
            :skip -> acc
          end

        _ ->
          acc
      end
    end)
  end

  defp encode_extensions(_) do
    []
  end
end
