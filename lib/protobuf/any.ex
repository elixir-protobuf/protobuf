defmodule Protobuf.Any do
  @moduledoc """
  Provides functions for working with the `google.protobuf.Any` type.

  Using the `Any` type provides the ability to send any message type in your messages, effectively
  providing a polymorphic field.

  See [Google's documentation for the `Any`a
  type](https://developers.google.com/protocol-buffers/docs/proto3#any).

  ## Examples

  You can build and decode the `Any` type yourself.

      encoded_any = Google.Protobuf.Any.new!(
        type_url: "types.googleapis.com/google.protobuf.Duration",
        value: Google.Protobuf.Duration.encode(%Google.Protobuf.Duration{seconds: 1})
      )

      # Back to the original message:
      decoded_any = decoded Google.Protobuf.Any.decode(encoded_any)
      Google.Protobuf.Duration.decode(decoded_any.value)

  """

  @doc """
  Returns the module for a given `type_url`.

  `type_url` must be in the form: `types.googleapis.com/<package>.<message name>`. The
  returned module is determined by joining the package name and message name. See
  the examples.

  > #### Existing modules {: .warning}
  >
  > The module for the message is determined via an **arbitrary string**
  >
  > Because of this, this function uses `Module.safe_concat/1` is used to prevent arbitrary
  > atom creation, which _requires_ that the message type is known and compiled into the
  > application.
  > If the inferred type is unknown, this function will raise an error.

  ## Examples

      iex> Protobuf.Any.type_url_to_module("type.googleapis.com/google.protobuf.Duration")
      Google.Protobuf.Duration

      iex> Protobuf.Any.type_url_to_module("bad_type_url")
      ** (ArgumentError) type_url must be in the form: types.googleapis.com/<package>.<message name>, got: "bad_type_url"

  """
  @spec type_url_to_module(String.t()) :: module()
  def type_url_to_module(type_url) when is_binary(type_url) do
    case type_url do
      "types.googleapis.com/" <> package_and_message ->
        package_and_message
        |> String.split(".")
        |> Enum.map(&Macro.camelize/1)
        |> Module.safe_concat()

      _other ->
        raise ArgumentError,
              "type_url must be in the form: types.googleapis.com/<package>.<message name>, " <>
                "got: #{inspect(type_url)}"
    end
  end
end
