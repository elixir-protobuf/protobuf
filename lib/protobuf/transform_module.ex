defmodule Protobuf.TransformModule do
  @moduledoc """
  Behaviour for transformer modules.

  By defining a `transform_module/0` function on your protobuf message module
  you can add custom encoding and decoding logic for your message.

  The `c:Protobuf.new/1` function will not be called for structs that have a transform module, if
  you still want to emulate this behavior you can use `Protobuf.TransformModule.InferFieldsFromEnum`.

  As an example we can use this to implement a message that will be decoded as a string value:

      defmodule StringMessage do
        use Protobuf, syntax: :proto3

        defstruct [:value]

        field :value, 1, type: :string

        def transform_module(), do: MyTransformModule
      end

  The transformer behaviour implementation:

      defmodule MyTransformModule do
        @behaviour Protobuf.TransformModule

        @impl true
        def encode(string, StringMessage) when is_binary(string), do: %StringMessage{value: string}

        @impl true
        def decode(%StringMessage{value: string}, StringMessage), do: string
      end
  """

  @type value() :: term()
  @type type() :: module()
  @type message() :: struct()

  @doc """
  Takes any Elixir term and the protobuf message type and encodes it into
  that type.

  Called before a message is encoded.
  """
  @callback encode(value(), type()) :: message()

  @doc """
  Takes any protobuf message and the message type and encodes it into arbitrary
  Elixir term.

  Called after a message is decoded.
  """
  @callback decode(message(), type()) :: value()
end
