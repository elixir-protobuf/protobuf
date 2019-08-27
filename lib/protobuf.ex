defmodule Protobuf do
  defmacro __using__(opts) do
    type_path = __CALLER__.module
      |> Module.split()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn
        {item, index} when index > 0 -> String.downcase(item)
        {item, _} -> item
      end)
      |> Enum.reverse()
      |> Enum.join(".")

    quote do
      import Protobuf.DSL, only: [field: 3, field: 2, oneof: 2]
      Module.register_attribute(__MODULE__, :fields, accumulate: true)
      Module.register_attribute(__MODULE__, :oneofs, accumulate: true)

      @options unquote(opts)
      unquote(encode_decode())
      @before_compile Protobuf.DSL

      def new() do
        Protobuf.Builder.new(__MODULE__)
      end

      def new(attrs) do
        Protobuf.Builder.new(__MODULE__, attrs)
      end

      def type_url() do
        Path.join(type_fqdn(), unquote(type_path))
      end

      def type_fqdn() do
        "type.googleapis.com"
      end

      defoverridable(type_fqdn: 0)
    end
  end

  defp encode_decode() do
    quote do
      def decode(data), do: Protobuf.Decoder.decode(data, __MODULE__)
      def encode(struct), do: Protobuf.Encoder.encode(struct)
    end
  end

  def decode(%mod{} = data) do
    Protobuf.Decoder.decode(data, mod)
  end

  def encode(struct) do
    Protobuf.Encoder.encode(struct)
  end
end
