defmodule Protobuf do
  defmacro __using__(opts) do
    quote do
      import Protobuf.DSL, only: [field: 3, field: 2]
      Module.register_attribute(__MODULE__, :fields, accumulate: true)

      @options unquote(opts)
      unquote(encode_decode())
      @before_compile Protobuf.DSL
    end
  end

  defp encode_decode() do
    quote do
      def decode(data), do: Protobuf.Decoder.decode(data, __MODULE__)
      def encode(struct), do: Protobuf.Encoder.encode(struct)
    end
  end

  def decode(%{__struct__: mod} = data) do
    Protobuf.Decoder.decode(data, mod)
  end

  def encode(struct) do
    Protobuf.Encoder.encode(struct)
  end
end
