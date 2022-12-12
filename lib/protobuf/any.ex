defmodule Protobuf.Any do
  @moduledoc """
  Provides functions for working with the `google.protobuf.Any` type.

  Using the `Any` type provides the ability to send any message type in your messages, effectively
  providing a polymorphic field.

  See [Google's documentation for the `Any`a
  type](https://developers.google.com/protocol-buffers/docs/proto3#any).

  Utilizing these functions allows you to pack and unpack any fields with any Protobuf
  message.

  ## Examples

  Imagine you have this Protobuf schema:

  ```protobuf
  message ErrorStatus {
    string message = 1;
    repeated google.protobuf.Any details = 2;
  }
  ```

  You can use `pack/1` to pack any message into an `Any` message.

      details = some_list_of_protobuf_messages()

      ErrorStatus.new(%{
        message: "There was an error",
        details: Enum.map(details, &Protobuf.Any.pack/1)
      })

  """

  @type_url_prefix "type.googleapis.com/"
  @type option() :: {:prefix, module()}

  @doc """
  Packs a Protobuf message into a `Google.Protobuf.Any` message.

  This sets the correct `type_url` using the pattern:

      type.googleapis.com/<package>.<message name>

  This URL is obtained by calling the `fully_qualified_name/1` function
  on the module for the `data` struct.

  The `value` field of the `Google.Protobuf.Any` returned message is set to
  the serialized original message.

  ## Example

      # This is the arbitrary message we want to pack.
      encoded = MyPkg.MyMessage.encode(data)

      any = Google.Protobuf.Any.new(%{
        type_url: "type.googleapis.com/my_pkg.MyMessage",
        value: encoded
      })

      any == Protobuf.Any.pack(data)
      #=> true

  """
  @spec pack(struct()) :: Google.Protobuf.Any.t()
  def pack(%mod{} = data) do
    Google.Protobuf.Any.new(%{
      type_url: "#{@type_url_prefix}#{mod.fully_qualified_name()}",
      value: mod.encode(data)
    })
  end

  @doc """
  Unpacks a `Google.Protobuf.Any` message.

  Uses the `type_url` to determine the type, and deserializes the binary data into that type.

  > #### Existing modules {: .warning}
  >
  > The module for the message is determined via a **string** (the `type_url`),
  > which is arbitrary user input that maps the package message name
  > to a generated protocol buffer module.
  >
  > Because of this, this function uses `Module.safe_concat/1` is used to prevent arbitrary
  > atom creation, which _requires_ that the message type is known and compiled into the
  > application.
  > If the inferred type is unknown, this function will raise an error.

  ## Options

  If you generated the protocol buffers with a module prefix, you can use
  the `:prefix` option (a module) to unpack this correctly.

  ## Example

      any = %Google.Protobuf.Any{
        type_url: "type.googleapis.com/my_pkg.MyMessage",
        value: <<...>>
      }

      Protobuf.Any.unpack(any)
      #=> %MyPkg.MyMessage{...}

  """
  @spec unpack(Google.Protobuf.Any.t(), keyword()) :: struct()
  def unpack(
        %{__struct__: Google.Protobuf.Any, type_url: @type_url_prefix <> name, value: value},
        options \\ []
      ) do
    parts =
      name
      |> String.split(".")
      |> Enum.map(&Macro.camelize/1)

    parts =
      case Keyword.fetch(options, :prefix) do
        {:ok, prefix} -> [prefix] ++ parts
        :error -> parts
      end

    Module.safe_concat(parts).decode(value)
  end
end
