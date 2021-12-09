# Modules mentioned in doctests

defmodule Color do
  @moduledoc false
  use Protobuf, syntax: :proto3, enum: true

  field :GREEN, 0
  field :RED, 1
end

defmodule Car do
  @moduledoc false
  use Protobuf, syntax: :proto3

  field :color, 1, type: Color, enum: true
  field :top_speed, 2, type: :float, json_name: "topSpeed"
end

defmodule VarintDecoders do
  import Protobuf.Wire.Varint

  def decode_and_sum(bin, plus) do
    decoder_decode_and_sum(bin, plus)
  end

  defdecoderp decoder_decode_and_sum(plus) do
    {:ok, value + plus, rest}
  end

  def decode_all(<<bin::bits>>), do: decode_all(bin, [])

  defp decode_all(<<>>, acc), do: acc

  defdecoderp decode_all(acc) do
    decode_all(rest, [value | acc])
  end
end
