defmodule Protobuf.Decoder do
  @moduledoc false

  import Protobuf.{WireTypes, Wire.Varint}
  import Bitwise, only: [bsr: 2, band: 2]

  alias Protobuf.{DecodeError, Wire}

  require Logger

  @spec decode(binary, atom) :: any
  def decode(data, module) do
    kvs = raw_decode_key(data, [], [])
    msg_props = module.__message_props__()
    struct = build_struct(kvs, msg_props, module.new())
    reverse_repeated(struct, msg_props.repeated_fields)
  end

  defp build_struct([tag, wire, val | rest], %{field_props: f_props} = msg_props, struct) do
    case f_props do
      %{
        ^tag =>
          %{
            wire_type: ^wire,
            repeated?: is_repeated,
            map?: is_map,
            type: type,
            oneof: oneof,
            name_atom: name_atom,
            embedded?: embedded
          } = prop
      } ->
        key = if oneof, do: oneof_field(prop, msg_props), else: name_atom

        struct =
          if embedded do
            embedded_msg = decode(val, type)
            val = if is_map, do: %{embedded_msg.key => embedded_msg.value}, else: embedded_msg
            val = if oneof, do: {name_atom, val}, else: val

            val = merge_embedded_value(struct, key, val, is_repeated)

            Map.put(struct, key, val)
          else
            val = Wire.to_proto(type, val)
            val = if oneof, do: {name_atom, val}, else: val

            val =
              if is_repeated do
                merge_simple_repeated_value(struct, key, val)
              else
                val
              end

            Map.put(struct, key, val)
          end

        build_struct(rest, msg_props, struct)

      %{^tag => %{packed?: true} = f_prop} ->
        struct = put_packed_field(struct, f_prop, val)
        build_struct(rest, msg_props, struct)

      %{^tag => %{wire_type: wire2} = f_prop} ->
        raise DecodeError,
              "wrong wire_type for #{prop_display(f_prop)}: got #{wire}, want #{wire2}"

      _ ->
        struct = try_decode_extension(struct, tag, wire, val)
        build_struct(rest, msg_props, struct)
    end
  end

  defp build_struct([], _, struct) do
    struct
  end

  defp merge_embedded_value(struct, key, val, is_repeated) do
    case struct do
      %{^key => nil} ->
        if is_repeated, do: [val], else: val

      %{^key => value} ->
        if is_repeated, do: [val | value], else: Map.merge(value, val)

      _ ->
        if is_repeated, do: [val], else: val
    end
  end

  defp merge_simple_repeated_value(struct, key, val) do
    case struct do
      %{^key => nil} ->
        [val]

      %{^key => value} ->
        [val | value]

      _ ->
        [val]
    end
  end

  defp raw_decode_key(<<>>, result, []), do: Enum.reverse(result)

  decoder :defp, :raw_decode_key, [:result, :groups] do
    tag = bsr(value, 3)
    wire_type = band(value, 7)
    raw_handle_key(wire_type, tag, groups, rest, result)
  end

  defp raw_handle_key(wire_start_group(), opening, groups, <<bin::bits>>, result) do
    raw_decode_key(bin, result, [opening | groups])
  end

  defp raw_handle_key(wire_end_group(), closing, [closing | groups], <<bin::bits>>, result) do
    raw_decode_key(bin, result, groups)
  end

  defp raw_handle_key(wire_end_group(), closing, [], _bin, _result) do
    raise(Protobuf.DecodeError,
      message: "closing group #{inspect(closing)} but no groups are open"
    )
  end

  defp raw_handle_key(wire_end_group(), closing, [open | _], _bin, _result) do
    raise(Protobuf.DecodeError,
      message: "closing group #{inspect(closing)} but group #{inspect(open)} is open"
    )
  end

  defp raw_handle_key(wire_type, tag, groups, <<bin::bits>>, result) do
    case groups do
      [] -> raw_decode_value(wire_type, bin, [wire_type, tag | result], groups)
      _ -> raw_decode_value(wire_type, bin, result, groups)
    end
  end

  decoder :defp, :raw_decode_varint, [:result, :groups] do
    case groups do
      [] -> raw_decode_key(rest, [value | result], groups)
      _ -> raw_decode_key(rest, result, groups)
    end
  end

  decoder :defp, :raw_decode_delimited, [:result, :groups] do
    <<bytes::bytes-size(value), rest::bits>> = rest

    case groups do
      [] -> raw_decode_key(rest, [bytes | result], groups)
      _ -> raw_decode_key(rest, result, groups)
    end
  end

  @doc false
  def raw_decode_value(wire, bin, result, groups \\ [])

  def raw_decode_value(wire_varint(), <<bin::bits>>, result, groups) do
    raw_decode_varint(bin, result, groups)
  end

  def raw_decode_value(wire_delimited(), <<bin::bits>>, result, groups) do
    raw_decode_delimited(bin, result, groups)
  end

  def raw_decode_value(wire_32bits(), <<n::bits-32, rest::bits>>, result, []) do
    raw_decode_key(rest, [n | result], [])
  end

  def raw_decode_value(wire_32bits(), <<_n::bits-32, rest::bits>>, result, groups) do
    raw_decode_key(rest, result, groups)
  end

  def raw_decode_value(wire_64bits(), <<n::bits-64, rest::bits>>, result, []) do
    raw_decode_key(rest, [n | result], [])
  end

  def raw_decode_value(wire_64bits(), <<_n::bits-64, rest::bits>>, result, groups) do
    raw_decode_key(rest, result, groups)
  end

  def raw_decode_value(_, _, _, _) do
    raise Protobuf.DecodeError, message: "cannot decode binary data"
  end

  # packed
  defp put_packed_field(msg, %{wire_type: wire_type, type: type, name_atom: key}, bin) do
    acc =
      case msg do
        %{^key => value} when is_list(value) -> value
        %{} -> []
      end

    value =
      case wire_type do
        wire_varint() -> decode_varints(bin, acc)
        wire_32bits() -> decode_fixed32(bin, type, acc)
        wire_64bits() -> decode_fixed64(bin, type, acc)
      end

    Map.put(msg, key, value)
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

  defp prop_display(prop) do
    prop.name
  end

  defp reverse_repeated(msg, []), do: msg

  defp reverse_repeated(msg, [h | t]) do
    case msg do
      %{^h => val} when is_list(val) ->
        reverse_repeated(Map.put(msg, h, Enum.reverse(val)), t)

      _ ->
        reverse_repeated(msg, t)
    end
  end

  defp oneof_field(%{oneof: oneof}, %{oneof: oneofs}) do
    {field, ^oneof} = Enum.at(oneofs, oneof)
    field
  end

  defp try_decode_extension(%mod{} = struct, tag, wire, val) do
    case Protobuf.Extension.get_extension_props_by_tag(mod, tag) do
      {ext_mod,
       %{
         field_props: %{
           wire_type: ^wire,
           repeated?: is_repeated,
           type: type,
           name_atom: name_atom,
           embedded?: embedded
         }
       }} ->
        val =
          if embedded do
            embedded_msg = decode(val, type)
            merge_embedded_value(struct, name_atom, embedded_msg, is_repeated)
          else
            val = Wire.to_proto(type, val)

            if is_repeated do
              merge_simple_repeated_value(struct, name_atom, val)
            else
              val
            end
          end

        key = {ext_mod, name_atom}

        case struct do
          %{__pb_extensions__: pb_ext} ->
            Map.put(struct, :__pb_extensions__, Map.put(pb_ext, key, val))

          _ ->
            Map.put(struct, :__pb_extensions__, %{key => val})
        end

      _ ->
        struct
    end
  end
end
