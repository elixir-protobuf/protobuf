defmodule Protobuf.Decoder do
  @moduledoc false
  import Protobuf.WireTypes
  import Bitwise, only: [bsl: 2, bsr: 2, band: 2]
  require Logger

  @max_bits 64
  @mask64 bsl(1, @max_bits) - 1

  alias Protobuf.DecodeError

  @spec decode(binary, atom) :: any
  def decode(data, module) do
    kvs = raw_decode_key(data, [], [])
    msg_props = module.__message_props__()
    struct = build_struct(kvs, msg_props, module.new())
    reverse_repeated(struct, msg_props.repeated_fields)
  end

  @doc false
  def decode_raw(data) do
    raw_decode_key(data, [], [])
  end

  @doc false
  # For performance
  defmacro decode_type_m(type, key, val) do
    quote do
      case unquote(type) do
        :int32 ->
          <<n::signed-integer-32>> = <<unquote(val)::32>>
          n

        :string ->
          unquote(val)

        :bytes ->
          unquote(val)

        :int64 ->
          <<n::signed-integer-64>> = <<unquote(val)::64>>
          n

        :uint32 ->
          <<n::unsigned-integer-32>> = <<unquote(val)::32>>
          n

        :uint64 ->
          <<n::unsigned-integer-64>> = <<unquote(val)::64>>
          n

        :bool ->
          unquote(val) != 0

        :sint32 ->
          decode_zigzag(unquote(val))

        :sint64 ->
          decode_zigzag(unquote(val))

        :fixed64 ->
          <<n::little-64>> = unquote(val)
          n

        :sfixed64 ->
          <<n::little-signed-64>> = unquote(val)
          n

        :double ->
          case unquote(val) do
            <<n::little-float-64>> ->
              n

            # little endianness
            # should be 0b0_11111111111_000000000...
            # should be 0b1_11111111111_000000000...
            <<0, 0, 0, 0, 0, 0, 0b1111::4, 0::4, 0b01111111::8>> ->
              :infinity

            <<0, 0, 0, 0, 0, 0, 0b1111::4, 0::4, 0b11111111::8>> ->
              :negative_infinity

            <<a::48, 0b1111::4, b::4, _::1, 0b1111111::7>> when a != 0 or b != 0 ->
              :nan
          end

        :fixed32 ->
          <<n::little-32>> = unquote(val)
          n

        :sfixed32 ->
          <<n::little-signed-32>> = unquote(val)
          n

        :float ->
          case unquote(val) do
            <<n::little-float-32>> ->
              n

            # little endianness
            # should be 0b0_11111111_000000000...
            <<0, 0, 0b1000_0000::8, 0b01111111::8>> ->
              :infinity

            # little endianness
            # should be 0b1_11111111_000000000...
            <<0, 0, 0b1000_0000::8, 0b11111111::8>> ->
              :negative_infinity

            # should be 0b*_11111111_not_zero...
            <<a::16, 1::1, b::7, _::1, 0b1111111::7>> when a != 0 or b != 0 ->
              :nan
          end

        {:enum, enum_type} ->
          try do
            enum_type.key(unquote(val))
          rescue
            FunctionClauseError ->
              Logger.warn(
                "unknown enum value #{unquote(val)} when decoding for #{inspect(unquote(type))}"
              )

              unquote(val)
          end

        _ ->
          raise DecodeError,
            message: "can't decode type #{unquote(type)} for field #{unquote(key)}"
      end
    end
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
            val = decode_type_m(type, key, val)
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

  @doc false
  def decode_varint(bin, type \\ :key) do
    raw_decode_varint(bin, [], type, [])
  end

  defp raw_decode_key(<<>>, result, []), do: Enum.reverse(result)

  defp raw_decode_key(<<bin::bits>>, result, groups) do
    raw_decode_varint(bin, result, :key, groups)
  end

  defp raw_decode_varint(<<0::1, x::7, rest::bits>>, result, type, groups) do
    raw_handle_varint(type, rest, result, x, groups)
  end

  defp raw_decode_varint(<<1::1, x0::7, 0::1, x1::7, rest::bits>>, result, type, groups) do
    val = bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 0::1, x2::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val = bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 0::1, x3::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val = bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 0::1, x4::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val = bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 1::1, x4::7, 0::1, x5::7,
           rest::bits>>,
         result,
         type,
         groups
       ) do
    val = bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 1::1, x4::7, 1::1, x5::7, 0::1,
           x6::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val = bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 1::1, x4::7, 1::1, x5::7, 1::1,
           x6::7, 0::1, x7::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val =
      bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) + bsl(x2, 14) +
        bsl(x1, 7) + x0

    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 1::1, x4::7, 1::1, x5::7, 1::1,
           x6::7, 1::1, x7::7, 0::1, x8::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val =
      bsl(x8, 56) + bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) + bsl(x3, 21) +
        bsl(x2, 14) + bsl(x1, 7) + x0

    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(
         <<1::1, x0::7, 1::1, x1::7, 1::1, x2::7, 1::1, x3::7, 1::1, x4::7, 1::1, x5::7, 1::1,
           x6::7, 1::1, x7::7, 1::1, x8::7, 0::1, x9::7, rest::bits>>,
         result,
         type,
         groups
       ) do
    val =
      bsl(x9, 63) + bsl(x8, 56) + bsl(x7, 49) + bsl(x6, 42) + bsl(x5, 35) + bsl(x4, 28) +
        bsl(x3, 21) + bsl(x2, 14) + bsl(x1, 7) + x0

    val = band(val, @mask64)
    raw_handle_varint(type, rest, result, val, groups)
  end

  defp raw_decode_varint(_, _, _, _) do
    raise Protobuf.DecodeError, message: "cannot decode binary data"
  end

  defp raw_handle_varint(:key, <<bin::bits>>, result, key, groups) do
    tag = bsr(key, 3)
    wire_type = band(key, 7)
    raw_handle_key(wire_type, tag, groups, bin, result)
  end

  defp raw_handle_varint(:value, <<>>, result, val, []), do: Enum.reverse([val | result])

  defp raw_handle_varint(:value, <<bin::bits>>, result, val, []) do
    raw_decode_varint(bin, [val | result], :key, [])
  end

  defp raw_handle_varint(:value, <<bin::bits>>, result, _val, groups) do
    raw_decode_varint(bin, result, :key, groups)
  end

  defp raw_handle_varint(:bytes_len, <<bin::bits>>, result, len, []) do
    <<bytes::bytes-size(len), rest::bits>> = bin
    raw_decode_key(rest, [bytes | result], [])
  end

  defp raw_handle_varint(:bytes_len, <<bin::bits>>, result, len, groups) do
    <<_bytes::bytes-size(len), rest::bits>> = bin
    raw_decode_key(rest, result, groups)
  end

  defp raw_handle_varint(:packed, <<>>, result, val, _groups), do: [val | result]

  defp raw_handle_varint(:packed, <<bin::bits>>, result, val, groups) do
    raw_decode_varint(bin, [val | result], :packed, groups)
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

  defp raw_handle_key(wire_type, tag, [], <<bin::bits>>, result) do
    raw_decode_value(wire_type, bin, [wire_type, tag | result], [])
  end

  defp raw_handle_key(wire_type, _tag, groups, <<bin::bits>>, result) do
    raw_decode_value(wire_type, bin, result, groups)
  end

  @doc false
  def raw_decode_value(wire, bin, result, groups \\ [])

  def raw_decode_value(wire_varint(), <<bin::bits>>, result, groups) do
    raw_decode_varint(bin, result, :value, groups)
  end

  def raw_decode_value(wire_delimited(), <<bin::bits>>, result, groups) do
    raw_decode_varint(bin, result, :bytes_len, groups)
  end

  def raw_decode_value(wire_32bits(), <<n::32, rest::bits>>, result, []) do
    raw_decode_key(rest, [<<n::32>> | result], [])
  end

  def raw_decode_value(wire_32bits(), <<_n::32, rest::bits>>, result, groups) do
    raw_decode_key(rest, result, groups)
  end

  def raw_decode_value(wire_64bits(), <<n::64, rest::bits>>, result, []) do
    raw_decode_key(rest, [<<n::64>> | result], [])
  end

  def raw_decode_value(wire_64bits(), <<_n::64, rest::bits>>, result, groups) do
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
        wire_varint() -> raw_decode_varint(bin, acc, :packed, [])
        wire_32bits() -> decode_fixed32(bin, type, key, acc)
        wire_64bits() -> decode_fixed64(bin, type, key, acc)
      end

    Map.put(msg, key, value)
  end

  @dialyzer {:nowarn_function, decode_fixed32: 4}
  defp decode_fixed32(<<n::bits-32, bin::bits>>, type, key, acc) do
    decode_fixed32(bin, type, key, [decode_type_m(type, key, n) | acc])
  end

  defp decode_fixed32(<<>>, _, _, acc), do: acc

  @dialyzer {:nowarn_function, decode_fixed64: 4}
  defp decode_fixed64(<<n::bits-64, bin::bits>>, type, key, acc) do
    decode_fixed64(bin, type, key, [decode_type_m(type, key, n) | acc])
  end

  defp decode_fixed64(<<>>, _, _, acc), do: acc

  @doc false
  @spec decode_zigzag(integer) :: integer
  def decode_zigzag(n) when band(n, 1) == 0, do: bsr(n, 1)
  def decode_zigzag(n) when band(n, 1) == 1, do: -bsr(n + 1, 1)

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
            val = decode_type_m(type, name_atom, val)

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
