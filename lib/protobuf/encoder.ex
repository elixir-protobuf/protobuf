defmodule Protobuf.Encoder do
  import Bitwise, only: [bsr: 2, band: 2, bsl: 2, bor: 2]
  alias Protobuf.{MessageProps, FieldProps}

  @wire_varint       0
  @wire_64bits       1
  @wire_delimited    2
  # @wire_start_group  3
  # @wire_end_group    4
  @wire_32bits       5

  @spec encode(struct, keyword) :: iodata
  def encode(%{__struct__: mod} = struct, opts \\ []) do
    Protobuf.Validator.validate!(struct)
    res = encode(struct, mod.__message_props__(), [])
    res = Enum.reverse(res)
    case Keyword.fetch(opts, :iolist) do
      {:ok, true} -> res
      _           -> IO.iodata_to_binary(res)
    end
  end

  @spec encode(struct, MessageProps.t, iodata) :: iodata
  def encode(struct, props, acc0) do
    Enum.reduce props.ordered_tags, acc0, fn(tag, acc) ->
      prop = props.field_props[tag]
      val = Map.get(struct, prop.name_atom)
      if empty_val?(val) do
        acc
      else
        [encode_field(val, prop)|acc]
      end
    end
  end

  @spec encode_field(any, FieldProps.t) :: iodata
  def encode_field(val, %{type: type, fnum: fnum} = prop) do
    case class_field(prop) do
      :normal ->
        repeated_or_not(val, prop.repeated?, fn(v) ->
          [encode_fnum(fnum, type), encode_type(type, v)]
        end)
      :embedded ->
        repeated_or_not(val, prop.repeated? || prop.map?, fn(v) ->
          v = if prop.map?, do: struct(prop.type, %{key: elem(v, 0), value: elem(v, 1)}), else: v
          encoded = encode(v)
          byte_size = byte_size(encoded)
          if byte_size == 0, do: "", else: [encode_fnum(fnum, type), [encode_varint(byte_size), encoded]]
        end)
      :packed ->
        encoded = Enum.map(val, fn(v) -> encode_type(type, v) end)
        encoded = IO.iodata_to_binary(encoded)
        byte_size = byte_size(encoded)
        if byte_size == 0, do: "", else: [encode_fnum(fnum, :bytes), [encode_varint(byte_size), encoded]]
    end
  end

  @spec class_field(map) :: atom
  def class_field(%{wire_type: @wire_delimited, embedded?: true}) do
    :embedded
  end
  def class_field(%{repeated?: true, packed?: true}) do
    :packed
  end
  def class_field(_) do
    :normal
  end

  @spec encode_fnum(integer, atom) :: iodata
  def encode_fnum(fnum, type) do
    fnum
    |> bsl(3)
    |> bor(wire_type(type))
    |> encode_varint
  end

  @spec encode_type(atom, any) :: iodata
  def encode_type(:int32, n), do: encode_varint(n)
  def encode_type(:int64, n), do: encode_varint(n)
  def encode_type(:uint32, n), do: encode_varint(n)
  def encode_type(:uint64, n), do: encode_varint(n)
  def encode_type(:sint32, n), do: n |> encode_zigzag |> encode_varint
  def encode_type(:sint64, n), do: n |> encode_zigzag |> encode_varint
  def encode_type(:bool, n) when n == true, do: encode_varint(1)
  def encode_type(:bool, n) when n == false, do: encode_varint(0)
  def encode_type(:enum, n), do: encode_type(:int32, n)
  def encode_type(:fixed64, n), do: <<n::64-little>>
  def encode_type(:sfixed64, n), do: <<n::64-signed-little>>
  def encode_type(:double, n), do: <<n::64-float-little>>
  def encode_type(:bytes, n) do
    bin = IO.iodata_to_binary(n)
    len = bin |> byte_size |> encode_varint
    <<len::binary, bin::binary>>
  end
  def encode_type(:string, n), do: encode_type(:bytes, n)
  def encode_type(:fixed32, n), do: <<n::32-little>>
  def encode_type(:sfixed32, n), do: <<n::32-signed-little>>
  def encode_type(:float, n), do: <<n::32-float-little>>

  @spec encode_zigzag(integer) :: integer
  def encode_zigzag(val) when val >= 0, do: val * 2
  def encode_zigzag(val) when val < 0,  do: val * -2 - 1

  @spec encode_varint(integer) :: iodata
  def encode_varint(n) when n < 0 do
    <<n::64-unsigned-native>> = <<n::64-signed-native>>
    encode_varint(n)
  end
  def encode_varint(n) when n <= 127, do: <<n>>
  def encode_varint(n) when n > 127, do: <<1::1, band(n, 127)::7, encode_varint(bsr(n, 7))::binary>>

  @spec wire_type(atom) :: integer
  def wire_type(:int32),     do: @wire_varint
  def wire_type(:int64),     do: @wire_varint
  def wire_type(:uint32),    do: @wire_varint
  def wire_type(:uint64),    do: @wire_varint
  def wire_type(:sint32),    do: @wire_varint
  def wire_type(:sint64),    do: @wire_varint
  def wire_type(:bool),      do: @wire_varint
  def wire_type(:enum),      do: @wire_varint
  def wire_type(:fixed64),   do: @wire_64bits
  def wire_type(:sfixed64),  do: @wire_64bits
  def wire_type(:double),    do: @wire_64bits
  def wire_type(:string),    do: @wire_delimited
  def wire_type(:bytes),     do: @wire_delimited
  def wire_type(:fixed32),   do: @wire_32bits
  def wire_type(:sfixed32),  do: @wire_32bits
  def wire_type(:float),     do: @wire_32bits
  def wire_type(mod) when is_atom(mod), do: @wire_delimited

  defp repeated_or_not(val, repeated, func) do
    if repeated do
      Enum.map(val, func)
    else
      func.(val)
    end
  end

  defp empty_val?(v) do
    !v || v == 0 || v == ""
  end
end
