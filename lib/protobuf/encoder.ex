defmodule Protobuf.Encoder do
  @moduledoc false

  import Bitwise, only: [bsl: 2, bor: 2]
  import Protobuf.Wire.Types

  alias Protobuf.{FieldProps, MessageProps, Wire, Wire.Varint}

  @spec encode_to_iodata(struct()) :: iodata()
  def encode_to_iodata(%mod{} = struct) do
    case mod.__encode_sized__(struct) do
      {iodata, _size} -> iodata
      :skip -> []
    end
  end

  @spec encode(struct()) :: binary()
  def encode(%_{} = struct) do
    struct
    |> encode_to_iodata()
    |> IO.iodata_to_binary()
  end

  # Returns the encoded iodata together with its byte size, so that callers
  # can write a length prefix without walking the iodata again.
  @doc false
  @spec encode_child_sized(term(), module()) :: {iodata(), non_neg_integer()} | :skip
  def encode_child_sized(value, mod) do
    case mod.transform_module() do
      nil ->
        sized(encode_rejected(mod, value))

      transform_module ->
        case transform_module.encode(value, mod) do
          nil -> :skip
          transformed -> sized(encode_from_type(mod, transformed))
        end
    end
  end

  # Only values the generated encoder rejected get here. One of them, a
  # struct-tagged map with missing keys, still carries the module's struct tag,
  # so encode_from_type/2 would hand it right back to the generated encoder,
  # forever. The interpreter reads fields with Map.get/3 and encodes it fine.
  defp encode_rejected(mod, %{__struct__: mod} = value) do
    encode_with_message_props(value, mod.__message_props__())
  end

  defp encode_rejected(mod, value), do: encode_from_type(mod, value)

  # A value that isn't a message but looks like a proto3 default is only present
  # when the child message transforms it into one, see Protobuf.DSL.Encoder.
  @doc false
  @spec encode_child_default_sized(term(), module()) :: {iodata(), non_neg_integer()} | :skip
  def encode_child_default_sized(value, mod) do
    if mod.transform_module() do
      encode_child_sized(value, mod)
    else
      :skip
    end
  end

  # Indirection over __encode_entry_sized__/2: only entry modules with a
  # transform module can return :skip, but whether the entry module has one is
  # unknown where the call is compiled, and calling it directly makes Dialyzer
  # flag the :skip clause as unreachable whenever it doesn't.
  @doc false
  @spec encode_entry_sized(module(), term(), term()) :: {iodata(), non_neg_integer()} | :skip
  def encode_entry_sized(mod, key, value), do: mod.__encode_entry_sized__(key, value)

  # Fallback __encode_entry_sized__/2 for map entry modules that define a
  # transform module; the generated entry encoders handle everything else.
  @doc false
  @spec encode_map_entry_sized({term(), term()}, module()) ::
          {iodata(), non_neg_integer()} | :skip
  def encode_map_entry_sized({_key, _value} = pair, mod) do
    case transform_module(pair, mod) do
      nil ->
        :skip

      {key, value} ->
        entry = struct(mod, %{key: key, value: value})
        sized(encode_with_message_props(entry, mod.__message_props__()))
    end
  end

  # The generated encoders don't wrap every field in a try/rescue like the
  # interpreter does, so on failure the message is replayed through the
  # interpreter, which raises the error naming the field that failed. If the
  # interpreter is happy with the message, the generated encoder itself is at
  # fault and the original error is re-raised.
  @doc false
  @spec reraise_generated_error(struct(), module(), Exception.t(), Exception.stacktrace()) ::
          no_return()
  def reraise_generated_error(struct, mod, error, stacktrace) do
    _ = encode_with_message_props(struct, mod.__message_props__())
    reraise error, stacktrace
  end

  @doc false
  @spec reraise_generated_entry_error(
          {term(), term()},
          module(),
          Exception.t(),
          Exception.stacktrace()
        ) :: no_return()
  def reraise_generated_entry_error({key, value}, mod, error, stacktrace) do
    _ = encode_with_message_props(struct(mod, %{key: key, value: value}), mod.__message_props__())
    reraise error, stacktrace
  end

  defp sized(iodata), do: {iodata, IO.iodata_length(iodata)}

  # Reached from the interpreted path, whose callers have already applied the
  # transform module (if any) for this message.
  defp do_encode_to_iodata(%mod{} = struct) do
    if mod.transform_module() do
      encode_with_message_props(struct, mod.__message_props__())
    else
      case mod.__encode_sized__(struct) do
        {iodata, _size} -> iodata
        :skip -> []
      end
    end
  end

  defp encode_with_message_props(
         struct,
         %MessageProps{syntax: syntax, field_props: field_props, ordered_tags: ordered_tags} =
           props
       ) do
    oneofs = oneof_actual_vals(props, struct)

    # We encode the fields in order since some recommended conformance tests expect us to do so.
    encoded =
      for fnum <- ordered_tags,
          prop = Map.fetch!(field_props, fnum),
          encoded = encode_field(prop, struct, oneofs, syntax),
          encoded != :skip do
        encoded
      end

    encoded = [encoded | encode_unknown_fields(struct)]

    if syntax == :proto2 do
      [encoded | encode_extensions(struct)]
    else
      encoded
    end
  end

  defp encode_field(%FieldProps{name_atom: name, oneof: oneof} = prop, struct, oneofs, syntax) do
    val =
      if oneof do
        oneofs[name]
      else
        Map.get(struct, name, nil)
      end

    do_encode_field(class_field(prop), val, syntax, prop)
  rescue
    error ->
      struct_mod = struct.__struct__

      raise Protobuf.EncodeError,
        message:
          "Got error when encoding #{inspect(struct_mod)}##{prop.name_atom}: #{Exception.format(:error, error)}"
  end

  defp skip_field?(syntax, value, field_prop) do
    case Protobuf.Presence.get_field_presence(syntax, value, field_prop) do
      :present -> false
      :maybe -> not (syntax == :proto2 and field_prop.required?)
      :not_present -> not (syntax == :proto2 and field_prop.required?)
    end
  end

  defp do_encode_field(
         :normal,
         val,
         syntax,
         %FieldProps{encoded_fnum: fnum, type: type, repeated?: repeated?} = prop
       ) do
    if skip_field?(syntax, val, prop) do
      :skip
    else
      apply_or_map(val, repeated?, &[fnum | Wire.encode(type, &1)])
    end
  end

  defp do_encode_field(:embedded, _val = nil, _syntax, _prop) do
    :skip
  end

  defp do_encode_field(
         :embedded,
         val,
         syntax,
         %FieldProps{encoded_fnum: fnum, repeated?: repeated?, map?: map?, type: type} = prop
       ) do
    apply_or_map(val, repeated? || map?, fn val ->
      val = transform_module(val, type)

      if skip_field?(syntax, val, prop) do
        ""
      else
        val = if map?, do: struct(type, %{key: elem(val, 0), value: elem(val, 1)}), else: val

        # so that oneof {:atom, val} can be encoded
        encoded = encode_from_type(type, val)
        byte_size = IO.iodata_length(encoded)
        [fnum, Varint.encode(byte_size) | encoded]
      end
    end)
  end

  defp do_encode_field(:packed, val, syntax, %FieldProps{type: type, encoded_fnum: fnum} = prop) do
    if skip_field?(syntax, val, prop) do
      :skip
    else
      encoded = Enum.map(val, &Wire.encode(type, &1))
      byte_size = IO.iodata_length(encoded)
      [fnum, Varint.encode(byte_size) | encoded]
    end
  end

  # Slow path of the generated encoders, for types not worth specializing for
  # (which may not even be supported by Protobuf.Wire).
  @doc false
  @spec encode_wire(Wire.proto_type(), term()) :: iodata()
  def encode_wire(type, value), do: Wire.encode(type, value)

  # Packed elements are appended to the field's payload binary, so the
  # generated encoders need each one as a binary rather than as iodata.
  @doc false
  @spec encode_wire_binary(Wire.proto_type(), term()) :: binary()
  def encode_wire_binary(type, value), do: type |> Wire.encode(value) |> IO.iodata_to_binary()

  defp encode_from_type(mod, msg) do
    case msg do
      %{__struct__: ^mod} ->
        do_encode_to_iodata(msg)

      %other_mod{} = struct ->
        raise Protobuf.EncodeError,
          message:
            "struct #{inspect(other_mod)} can't be encoded as #{inspect(mod)}: #{inspect(struct)}"

      enumerable when is_map(enumerable) or is_list(enumerable) ->
        IO.warn("""
        Implicitly casting a non-struct to a #{inspect(mod)} message:

        #{inspect(enumerable, pretty: true)}

        This automatic coercion is deprecated in Protobuf 0.15 and will raise an error in future versions.

        Instead of:
          %Parent{child: %{name: ""}}

        Build child structs explicitly:
          %Parent{child: %Child{name: ""}}
        """)

        do_encode_to_iodata(struct(mod, msg))

      other ->
        raise Protobuf.EncodeError,
          message: "invalid value for type #{inspect(mod)}: #{inspect(other)}"
    end
  end

  defp encode_unknown_fields(%_{__unknown_fields__: unknown_fields} = _message) do
    encode_unknown_fields_iodata(unknown_fields)
  end

  @doc false
  @spec encode_unknown_fields_iodata([Protobuf.unknown_field()]) :: iodata()
  def encode_unknown_fields_iodata(unknown_fields) do
    Enum.map(unknown_fields, fn {fnum, wire_type, value} ->
      [encode_fnum(fnum, wire_type), Wire.encode_from_wire_type(wire_type, value)]
    end)
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

  defp apply_or_map(val, _repeated? = true, func), do: Enum.map(val, func)
  defp apply_or_map(val, _repeated? = false, func), do: func.(val)

  # Returns a map of %{field_name => field_value} from oneofs. For example, if you have:
  # oneof body {
  #   string a = 1;
  #   string b = 2
  # }
  # Then this could return: %{a: "some value"}
  @doc false
  @spec oneof_actual_vals(MessageProps.t(), struct()) :: %{optional(atom()) => term()}
  def oneof_actual_vals(
        %MessageProps{field_tags: field_tags, field_props: field_props, oneof: oneof},
        struct
      ) do
    Enum.reduce(oneof, %{}, fn {field, index}, acc ->
      case Map.fetch(struct, field) do
        {:ok, {field_name, value}} when is_atom(field_name) ->
          oneof =
            case field_props[field_tags[field_name]] do
              %FieldProps{oneof: oneof} ->
                oneof

              nil ->
                raise Protobuf.EncodeError,
                  message:
                    "#{inspect(field_name)} wasn't found in #{inspect(struct.__struct__)}##{field}"
            end

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
    encode_extensions_iodata(mod, pb_exts)
  end

  defp encode_extensions(_) do
    []
  end

  @doc false
  @spec encode_extensions_iodata(module(), map()) :: iodata()
  def encode_extensions_iodata(mod, pb_exts) do
    Enum.reduce(pb_exts, [], fn {{ext_mod, key}, val}, acc ->
      case Protobuf.Extension.get_extension_props(mod, ext_mod, key) do
        %{field_props: prop} ->
          case do_encode_field(class_field(prop), val, :proto2, prop) do
            :skip -> acc
            iodata -> [acc | iodata]
          end

        _ ->
          acc
      end
    end)
  end
end
