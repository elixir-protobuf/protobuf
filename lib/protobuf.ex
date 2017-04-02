defmodule Protobuf do
  defmacro __using__(_opts) do
    quote do
      import Protobuf.DSL, only: [field: 3]
      Module.register_attribute(__MODULE__, :fields, accumulate: true)

      unquote(encode_decode())
      @before_compile Protobuf.DSL
    end
  end

  def encode_decode() do
    quote do
      def decode(data), do: Protobuf.Decoder.decode(data, __MODULE__)
      def encode(struct), do: Protobuf.Encoder.encode(struct)
    end
  end
end
