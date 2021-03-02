defmodule Protobuf do
  @moduledoc """
  `protoc` should always be used to generate code instead of writing the code by hand.

  By `use` this module, macros defined in `Protobuf.DSL` will be injected. Most of thee macros
  are equal to definition in .proto files.

      defmodule Foo do
        use Protobuf, syntax: :proto3

        defstruct [:a, :b]

        field :a, 1, type: :int32
        field :b, 2, type: :string
      end

  Your Protobuf message(module) is just a normal Elixir struct. Some useful functions are also injected,
  see "Callbacks" for details. Examples:

      foo1 = Foo.new!(%{a: 1})
      foo1.b == ""
      bin = Foo.encode(foo1)
      foo1 == Foo.decode(bin)

  Except functions in "Callbacks", some other functions may be defined:

  * Extension functions when your Protobuf message use extensions. See `Protobuf.Extension` for details.
    * `put_extension(struct, extension_mod, field, value)`
    * `get_extension(struct, extension_mod, field, default \\ nil)`

  """
  defmacro __using__(opts) do
    quote location: :keep do
      import Protobuf.DSL, only: [field: 3, field: 2, oneof: 2, extend: 4, extensions: 1]
      Module.register_attribute(__MODULE__, :fields, accumulate: true)
      Module.register_attribute(__MODULE__, :oneofs, accumulate: true)
      Module.register_attribute(__MODULE__, :extends, accumulate: true)
      Module.register_attribute(__MODULE__, :extensions, [])

      @options unquote(opts)
      @before_compile Protobuf.DSL

      @behaviour Protobuf

      def new() do
        Protobuf.Builder.new(__MODULE__)
      end

      def new(attrs) do
        Protobuf.Builder.new(__MODULE__, attrs)
      end

      def new!(attrs) do
        Protobuf.Builder.new!(__MODULE__, attrs)
      end

      unquote(def_encode_decode())
    end
  end

  defp def_encode_decode() do
    quote do
      def decode(data), do: Protobuf.Decoder.decode(data, __MODULE__)
      def encode(struct), do: Protobuf.Encoder.encode(struct)
    end
  end

  @doc """
  Build a blank struct with default values. This and other "new" functions are
  preferred than raw building struct method like `%Foo{}`.

  In proto3, the zero values are the default values.
  """
  @callback new() :: struct

  @doc """
  Build and update the struct with passed fields.
  """
  @callback new(Enum.t()) :: struct

  @doc """
  Similar to `new/1`, but use `struct!/2` to build the struct, so
  errors will be raised if unknown keys are passed.
  """
  @callback new!(Enum.t()) :: struct

  @doc """
  Encode the struct to a protobuf binary.

  Errors may be raised if there's something wrong in the struct.
  """
  @callback encode(struct) :: binary

  @doc """
  Decode a protobuf binary to a struct.

  Errors may be raised if there's something wrong in the binary.
  """
  @callback decode(binary) :: struct

  @doc """
  It's preferable to use message's `decode` function, like:

      Foo.decode(bin)

  """
  @spec decode(binary, module) :: struct
  def decode(data, mod) do
    Protobuf.Decoder.decode(data, mod)
  end

  @doc """
  It's preferable to use message's `encode` function, like:

      Foo.encode(foo)

  """
  @spec encode(struct) :: binary
  def encode(struct) do
    Protobuf.Encoder.encode(struct)
  end
end
