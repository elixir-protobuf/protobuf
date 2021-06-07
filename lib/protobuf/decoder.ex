defmodule Protobuf.Decoder do
  @moduledoc false

  import Protobuf.{Wire.Types, Wire.Varint}
  import Bitwise, only: [bsr: 2, band: 2]

  alias Protobuf.{DecodeError, Wire}

  require Logger

  @compile {:inline,
            decode_field: 3, skip_varint: 4, skip_delimited: 4, reverse_repeated: 2, field_key: 2}

  @spec decode(binary, atom) :: any
  def decode(bin, module) do
    props = module.__message_props__()

    bin
    |> build_message(module.new(), props)
    |> reverse_repeated(props.repeated_fields)
  end

  defp build_message(<<>>, message, _props), do: message

  defp build_message(<<bin::bits>>, message, props) do
    decode_field(bin, message, props)
  end

  decoder :defp, :decode_field, [:message, :props] do
    field_number = bsr(value, 3)
    wire_type = band(value, 7)
    handle_field(rest, field_number, wire_type, message, props)
  end

  defp handle_field(<<bin::bits>>, field_number, wire_start_group(), message, props) do
    skip_field(bin, message, props, [field_number])
  end

  defp handle_field(<<_bin::bits>>, closing, wire_end_group(), _message, _props) do
    msg = "closing group #{inspect(closing)} but no groups are open"
    raise Protobuf.DecodeError, message: msg
  end

  defp handle_field(<<bin::bits>>, field_number, wire_varint(), message, props) do
    decode_varint(bin, field_number, message, props)
  end

  defp handle_field(<<bin::bits>>, field_number, wire_delimited(), message, props) do
    decode_delimited(bin, field_number, message, props)
  end

  defp handle_field(<<bin::bits>>, field_number, wire_32bits(), message, props) do
    <<value::bits-32, rest::bits>> = bin
    handle_value(rest, field_number, wire_32bits(), value, message, props)
  end

  defp handle_field(<<bin::bits>>, field_number, wire_64bits(), message, props) do
    <<value::bits-64, rest::bits>> = bin
    handle_value(rest, field_number, wire_64bits(), value, message, props)
  end

  defp handle_field(_bin, _field_number, _wire_type, _message, _props) do
    raise Protobuf.DecodeError, message: "cannot decode binary data"
  end

  decoder :defp, :skip_field, [:message, :props, :groups] do
    field_number = bsr(value, 3)
    wire_type = band(value, 7)

    case wire_type do
      wire_start_group() ->
        skip_field(rest, message, props, [field_number | groups])

      wire_end_group() ->
        case groups do
          [^field_number] ->
            build_message(rest, message, props)

          [^field_number | groups] ->
            skip_field(rest, message, props, groups)

          [group | _] ->
            msg = "closing group #{inspect(field_number)} but group #{inspect(group)} is open"
            raise Protobuf.DecodeError, message: msg
        end

      wire_varint() ->
        skip_varint(rest, message, props, groups)

      wire_delimited() ->
        skip_delimited(rest, message, props, groups)

      wire_32bits() ->
        <<_skip::bits-32, rest::bits>> = rest
        skip_field(rest, message, props, groups)

      wire_64bits() ->
        <<_skip::bits-64, rest::bits>> = rest
        skip_field(rest, message, props, groups)
    end
  end

  decoder :defp, :skip_varint, [:message, :props, :groups] do
    _ = value
    skip_field(rest, message, props, groups)
  end

  decoder :defp, :skip_delimited, [:message, :props, :groups] do
    <<_skip::bytes-size(value), rest::bits>> = rest
    skip_field(rest, message, props, groups)
  end

  decoder :defp, :decode_varint, [:field_number, :message, :props] do
    handle_value(rest, field_number, wire_varint(), value, message, props)
  end

  decoder :defp, :decode_delimited, [:field_number, :message, :props] do
    <<bytes::bytes-size(value), rest::bits>> = rest
    handle_value(rest, field_number, wire_delimited(), bytes, message, props)
  end

  defp handle_value(<<bin::bits>>, field_number, wire_type, value, message, props) do
    case props.field_props do
      %{^field_number => %{packed?: true} = prop} ->
        key = prop.name_atom
        current_value = Map.get(message, key)
        new_value = value_for_packed(value, current_value, prop)
        new_message = Map.put(message, key, new_value)
        build_message(bin, new_message, props)

      %{^field_number => %{wire_type: ^wire_type} = prop} ->
        key = field_key(prop, props)
        current_value = Map.get(message, key)
        new_value = value_for_field(value, current_value, prop)
        new_message = Map.put(message, key, new_value)
        build_message(bin, new_message, props)

      %{^field_number => %{wire_type: wanted, name: field}} ->
        message = "wrong wire_type for #{field}: got #{wire_type}, want #{wanted}"
        raise DecodeError, message: message

      %{} ->
        %mod{} = message

        new_message =
          case Protobuf.Extension.get_extension_props_by_tag(mod, field_number) do
            {ext_mod, %{field_props: prop}} ->
              current_value = Protobuf.Extension.get(message, ext_mod, prop.name_atom, nil)
              new_value = value_for_field(value, current_value, prop)
              Protobuf.Extension.put(mod, message, ext_mod, prop.name_atom, new_value)

            _ ->
              message
          end

        build_message(bin, new_message, props)
    end
  end

  defp value_for_field(value, current, %{embedded?: false} = prop) do
    val = Wire.to_proto(prop.type, value)
    val = if prop.oneof, do: {prop.name_atom, val}, else: val

    case {current, prop.repeated?} do
      {nil, true} -> [val]
      {current, true} -> [val | current]
      _ -> val
    end
  end

  defp value_for_field(bin, current, %{embedded?: true} = prop) do
    embedded_msg = decode(bin, prop.type)
    val = if prop.map?, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
    val = if prop.oneof, do: {prop.name_atom, val}, else: val

    case {current, prop.repeated?} do
      {nil, true} -> [val]
      {nil, false} -> val
      {current, true} -> [val | current]
      {current, false} -> Map.merge(current, val)
    end
  end

  defp value_for_packed(bin, current, prop) do
    acc = current || []

    case prop.wire_type do
      wire_varint() -> decode_varints(bin, acc)
      wire_32bits() -> decode_fixed32(bin, prop.type, acc)
      wire_64bits() -> decode_fixed64(bin, prop.type, acc)
    end
  end

  defp decode_varints(<<>>, acc), do: acc

  decoder :defp, :decode_varints, [:acc] do
    decode_varints(rest, [value | acc])
  end

  defp decode_fixed32(<<n::bits-32, bin::bits>>, type, acc) do
    decode_fixed32(bin, type, [Wire.to_proto(type, n) | acc])
  end

  defp decode_fixed32(<<>>, _, acc), do: acc

  defp decode_fixed64(<<n::bits-64, bin::bits>>, type, acc) do
    decode_fixed64(bin, type, [Wire.to_proto(type, n) | acc])
  end

  defp decode_fixed64(<<>>, _, acc), do: acc

  defp reverse_repeated(msg, [h | t]) do
    case msg do
      %{^h => val} when is_list(val) ->
        reverse_repeated(Map.put(msg, h, Enum.reverse(val)), t)

      _ ->
        reverse_repeated(msg, t)
    end
  end

  defp reverse_repeated(msg, []), do: msg

  defp field_key(%{oneof: nil, name_atom: field_key}, _message_props), do: field_key

  defp field_key(%{oneof: oneof_number}, %{oneof: oneofs}) do
    {field_key, ^oneof_number} = Enum.at(oneofs, oneof_number)
    field_key
  end
end
