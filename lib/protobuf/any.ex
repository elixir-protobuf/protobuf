defmodule Protobuf.Any do
  @moduledoc """
  Provides functions for working with the `google.protobuf.Any` well known type.

  Using the Any type provides the ability to send any message type in your messages (a polymorphic field).

  See: [Documentation for the Any type](https://developers.google.com/protocol-buffers/docs/proto3#any)

  Utilizing these functions allows you to pack and unpack any fields with any protocol buffer message.any()

  Given a message type of

      ```protobuf
      message ErrorStatus {
        string message = 1;
        repeated google.protobuf.Any details = 2;
      }
      ```

  Use the `Protobuf.Any.pack` function to set the information.

      ```elixir
      details = some_list_of_protobuf_messages()
      ErrorStatus.new(%{
        message: "There was an error",
        details: Enum.map(details, &Protobuf.Any.pack/1)
      })
      ```

  """
  @type_url_prefix "type.googleapis.com/"
  @type option :: {:prefix, module()}

  @doc """
  Pack a protocol buffer message into a `Google.Protobuf.Any` message.

  This sets the correct `type_url` of the pattern: `type.googleapis.com/<package>.<message name>`
  and the `value` of the `Any` as the serialized original message.

  ## Example

      ```elixir
      Google.Protobuf.Any.new(%{
        type_url: "type.googleapis.com/some.package.My.Message",
        value: Some.Pacakge.My.Message.encode(data)
      }) = Protobuf.Any.pack(data)
  """
  @spec pack(struct()) :: Google.Protobuf.Any.t()
  def pack(%mod{} = data) do
    Google.Protobuf.Any.new(%{
      type_url: "#{@type_url_prefix}#{mod.full_name()}",
      value: mod.encode(data)
    })
  end

  @doc """
  Unpack a `Google.Protobuf.Any` message.

  Utilizes the `type_url` to determine the type, and deserializes the binary data into that type.

  ## Example

      any = %Google.Protobuf.Any{type_url: "type.googleapis.com/some.package.My.Message", value: <binary_data>}
      %Some.Package.My.Message{} = Protobuf.Any.unpack(any)

  Note: Since the module for the message is determined via a string (type_url) that is user input that maps the package message name
  to a generated protocol buffer module. `Module.safe_concat` is used to prevent arbitrary atom creation, which _requires_ that the message type is known and compiled into the application.
  If the inferred type is unknown there will be an Argument error raised.

  If you generated the protocol buffers with a module prefix, you can use the `prefix` option to unpack this correctly.

  ## Example
      any = %Google.Protobuf.Any{type_url: "type.googleapis.com/some.package.My.Message", value: <binary_data>}
      %Prefixed.Some.Package.My.Message{} = Protobuf.Any.unpack(any, prefix: Prefixed)

  """
  @spec unpack(Google.Protobuf.Any.t()) :: struct()
  @spec unpack(Google.Protobuf.Any.t(), [option()]) :: struct()
  def unpack(
        %{__struct__: Google.Protobuf.Any, type_url: @type_url_prefix <> name, value: value},
        options \\ []
      ) do
    prefix = Keyword.get(options, :prefix, nil)

    parts =
      name
      |> String.split(".")
      |> Enum.map(&Macro.camelize/1)

    mod =
      if prefix do
        Module.safe_concat([prefix] ++ parts)
      else
        Module.safe_concat(parts)
      end

    mod.decode(value)
  end
end
