defmodule Protobuf do
  @moduledoc """
  `protoc` should always be used to generate code instead of writing the code by hand.

  ## Usage

  By `use`'ing this module, macros defined in `Protobuf.DSL` will be injected. Most of these
  macros are equal to definition in `.proto` schemas.

      defmodule Foo do
        use Protobuf, syntax: :proto3

        field :a, 1, type: :int32
        field :b, 2, type: :string
      end

  Your Protobuf message (module) is just a normal Elixir struct. The default values in the
  struct match the correct ones for the Protobuf schema definition. You can construct
  new messages by hand:

      foo = %Foo{a: 1}
      Protobuf.encode(foo)
      #=> <<...>>

  Except functions in "Callbacks", some other functions may be defined:

  * Extension functions when your Protobuf message use extensions. See `Protobuf.Extension` for details.
    * `put_extension(struct, extension_mod, field, value)`
    * `get_extension(struct, extension_mod, field, default \\ nil)`

  ## Options

  These are the options that you can pass to `use Protobuf`:

    * `:syntax` - The syntax of the schema. Can be `:proto2` or `:proto3`. Defaults to `:proto2`.
    * `:enum` - A boolean that tells whether this message is an enum. Defaults to `false`.
    * `:map` - A boolean that tells whether this message is a map. Defaults to `false`.

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

      #@deprecated "Build the struct by hand with %MyMessage{...} or use struct/1"
      @impl unquote(__MODULE__)
      def new() do
        Protobuf.Builder.new(__MODULE__)
      end

      #@deprecated "Build the struct by hand with %MyMessage{...} or use struct/2"
      @impl unquote(__MODULE__)
      def new(attrs) do
        Protobuf.Builder.new(__MODULE__, attrs)
      end

      #@deprecated "Build the struct by hand with %MyMessage{...} or use struct!/2"
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
      def encode(struct), do: Protobuf.Encoder.encode(struct)
    end
  end

  @doc """
  Builds a blank struct with default values.

  > #### Deprecated {: .warning}
  >
  > This is deprecated in favor of building the struct with `%MyMessage{...}` or using
  > `struct/1`.

  """
  @callback new() :: struct()

  @doc """
  Builds and updates the struct with passed fields.

  This function will:

    * Recursively call `c:new/1` for embedded fields
    * Create structs using `struct/2` for keyword lists and maps
    * Create the correct struct if passed the wrong struct
    * Call `c:new/1` for each element in the list for repeated fields

  > #### Deprecated {: .warning}
  > This is deprecated in favor of building the struct with `%MyMessage{...}` or using
  > `struct/2`.

  ## Examples

      MyMessage.new(field1: "foo")
      #=> %MyMessage{field1: "foo", ...}

      MyMessage.new(field1: [field2: "foo"])
      #=> %MyMessage{field1: %MySubMessage{field2: "foo"}}

      MyMessage.new(field1: %WrongStruct{field2: "foo"})
      #=> %MyMessage{field1: %MySubMessage{field2: "foo"}}

      MyMessage.new(repeated: [%{field1: "foo"}, %{field1: "bar"}])
      #=> %MyMessage{repeated: [%MyRepeated{field1: "foo"}, %MyRepeated{field1: "bar"}]}

  """
  @callback new(attributes :: Enum.t()) :: struct

  @doc """
  Similar to `c:new/1`, but use `struct!/2` to build the struct, so
  errors will be raised if unknown keys are passed.

  > #### Deprecated {: .warning}
  > This is deprecated in favor of building the struct with `%MyMessage{...}` or using
  > `struct!/2` directly.

  """
  @callback new!(attributes :: Enum.t()) :: struct()

  @doc """
  Encodes the given struct into to a Protobuf binary.

  Errors may be raised if there's something wrong in the struct.

  If you want to encode to iodata instead of to a binary, use `encode_to_iodata/1`.
  """
  @callback encode(struct()) :: binary()

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

  If you want to encode to iodata instead, see `encode_to_iodata/1`.

  ## Examples

      Protobuf.encode(%MyMessage{...})
      #=> <<...>>

  """
  @spec encode(struct()) :: binary()
  defdelegate encode(struct), to: Protobuf.Encoder

  @doc """
  Encodes the given Protobuf struct into iodata.

  ## Examples

      Protobuf.encode_to_iodata(%MyMessage{...})
      #=> [...]

  """
  @spec encode_to_iodata(struct()) :: iodata()
  defdelegate encode_to_iodata(struct), to: Protobuf.Encoder

  @doc """
  Returns the unknown fields that were decoded but were not understood from the schema.

  In Protobuf, you can decode a payload (for the same message) encoded with a different version of
  the schema for that message. This can result in, for example, the payload containing fields that
  cannot be decoded correctly because they're not present in the schema used for decoding. These
  fields are skipped, but in some cases you might wish to preserve them in order to re-encode
  them, log them, or other. A common case is having to do "round-trips" with messages: you decode
  a payload, update the resulting message somehow, and re-encode it for future use. In these
  cases, you would probably want to re-encode the unknown fields to maintain symmetry.

  The returned value of this function is a list of `{field_number, field_value}` tuples where
  `field_number` is the number of the unknown field in the schema used for its encoding and
  `field_value` is its value. The library does not make any assumptions on the value of the
  field since it can't know for sure. This means that, for example, it can't properly decode
  an integer as signed or unsigned. The only guarantee is that the unknown fields are re-encoded
  correctly.

  The reason why these fields need to be accessed through this function is that the way they
  are stored in the struct is private.

  ## Examples

  Imagine you have this Protobuf schema:

      message User {
        string email = 1;
      }

  You encode this:

      payload = Protobuf.encode(User.new!(email: "user@example.com))
      #=> <<...>>

  Now, you try to decode this payload using this schema instead:

      message User {
        string full_name = 2;
      }

  In this case, this function will return the decoded unknown field:

      message = User.decode(<<...>>)
      Protobuf.get_unknown_fields(message)
      #=> [{_field_number = 1, _wire_type = 3, "user@example.com}]

  """
  @doc since: "0.10.0"
  @spec get_unknown_fields(struct()) :: [unknown_field]
        when unknown_field:
               {field_number :: integer(), Protobuf.Wire.Types.wire_type(), value :: any()}
  def get_unknown_fields(message)

  def get_unknown_fields(%_{__unknown_fields__: unknown_fields}) do
    unknown_fields
  end

  if Protobuf.Compat.is_compat?() do
    def get_unknown_fields(%mod{}) do
      []
    end
  else
    def get_unknown_fields(%mod{}) do
      raise ArgumentError,
            "can't retrieve unknown fields for struct #{inspect(mod)}, which " <>
              "likely means that its definition was not compiled with :protobuf 0.10.0+, which is the " <>
              "version that introduced implicit struct generation"
    end
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
    for mod <- get_all_modules(),
        String.ends_with?(Atom.to_string(mod), ".PbExtension"),
        Code.ensure_loaded?(mod),
        function_exported?(mod, :__protobuf_info__, 1),
        %{extensions: extensions} = mod.__protobuf_info__(:extension_props) do
      Enum.each(extensions, fn {_, ext} ->
        fnum = ext.field_props.fnum
        fnum_key = {Protobuf.Extension, ext.extendee, fnum}
        :persistent_term.put(fnum_key, mod)
      end)
    end

    :ok
  end

  defp get_all_modules do
    Enum.flat_map(Application.loaded_applications(), fn {app, _desc, _vsn} ->
      {:ok, modules} = :application.get_key(app, :modules)
      modules
    end)
  end
end
