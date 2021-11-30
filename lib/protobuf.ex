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

      @impl unquote(__MODULE__)
      def new() do
        Protobuf.Builder.new(__MODULE__)
      end

      @impl unquote(__MODULE__)
      def new(attrs) do
        Protobuf.Builder.new(__MODULE__, attrs)
      end

      @impl unquote(__MODULE__)
      def new!(attrs) do
        Protobuf.Builder.new!(__MODULE__, attrs)
      end

      @impl unquote(__MODULE__)
      def transform_module() do
        nil
      end

      defoverridable transform_module: 0

      @impl unquote(__MODULE__)
      def decode(data), do: Protobuf.Decoder.decode(data, __MODULE__)

      @impl unquote(__MODULE__)
      def encode(struct), do: Protobuf.Encoder.encode(struct, _options = [])

      @impl unquote(__MODULE__)
      def encode(struct, options), do: Protobuf.Encoder.encode(struct, options)
    end
  end

  @doc """
  Builds a blank struct with default values. This and other "new" functions are
  preferred than raw building struct method like `%Foo{}`.

  In proto3, the zero values are the default values.
  """
  @callback new() :: struct()

  @doc """
  Builds and updates the struct with passed fields.

  ## Examples

      MyMessage.new(field1: "foo")
      #=> %MyMessage{field1: "foo", ...}

  """
  @callback new(Enum.t()) :: struct

  @doc """
  Similar to `c:new/1`, but use `struct!/2` to build the struct, so
  errors will be raised if unknown keys are passed.
  """
  @callback new!(Enum.t()) :: struct()

  @doc """
  Same as `c:encode/2` but with empty options.
  """
  @callback encode(struct()) :: iodata()

  @doc """
  Encodes the given struct into to a Protobuf binary.

  Errors may be raised if there's something wrong in the struct.

  ## Options

    * `:iolist` - Boolean. If `true`, the returned value is iodata. If `false`, it's a binary.
      Defaults to `false`.

  """
  @callback encode(struct(), options :: [encode_option]) :: iodata()
            when encode_option: {:iolist, boolean()}

  @doc """
  Decodes a Protobuf binary into a struct.

  Errors may be raised if there's something wrong in the binary.
  """
  @callback decode(binary()) :: struct()

  @doc """
  Returns `nil` or a transformer module that implements the `Protobuf.TransformModule`
  behaviour.

  This function is overridable in your module.
  """
  @callback transform_module() :: module() | nil

  @doc """
  Decodes the given binary data interpreting it as the Protobuf message `module`.

  It's preferrable to use the message's `c:decode/1` function. For a message `MyMessage`:

      MyMessage.decode(<<...>>)
      #=> %MyMessage{...}

  This function raises an error if anything goes wrong with decoding.

  ## Examples

      Protobuf.decode(<<...>>, MyMessage)
      #=> %MyMessage{...}

      Protobuf.decode(<<"bad data">>, MyMessage)
      #=> ** (Protobuf.DecodeError) ...

  """
  @spec decode(binary(), message) :: %{required(:__struct__) => message} when message: module()
  defdelegate decode(data, module), to: Protobuf.Decoder

  @doc """
  Encodes the given Protobuf struct into a binary.

  It's preferrable to use the message's `c:encode/1` or `c:encode/2` functions. For a message
  `MyMessage`:

      MyMessage.encode(MyMessage.new())

  See `c:encode/2` for the supported options.

  ## Examples

      struct = MyMessage.new()
      Protobuf.encode(struct)
      #=> <<...>>

  """
  @spec encode(struct()) :: binary()
  def encode(%_{} = struct, options \\ []) when is_list(options) do
    Protobuf.Encoder.encode(struct, options)
  end

  @doc """
  Loads extensions modules.

  This function should be called in your application's `c:Application.start/2` callback,
  as seen in the example below, if you wish to use extensions.

  ## Example

      @impl Application
      def start(_type, _args) do
        Protobuf.load_extensions()
        Supervisor.start_link([], strategy: :one_for_one)
      end

  """
  @spec load_extensions() :: :ok
  def load_extensions() do
    Protobuf.Extension.__cal_extensions__()
    :ok
  end
end
