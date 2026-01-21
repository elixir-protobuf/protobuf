defmodule Protobuf.Any.TypeProvider do
  @moduledoc """
  Behaviour for resolving type URLs to Protobuf message modules for `Google.Protobuf.Any`.

  Implementations of this behaviour define how to convert a type URL to its corresponding module,
  allowing customization of prefix handling and message routing.

  ## Example

      defmodule MyApp.AnyTypeProvider do
        @behaviour Protobuf.Any.TypeProvider

        def to_module("type.googleapis.com/google.protobuf.Duration"), do: {:ok, Google.Protobuf.Duration}
        def to_module("type.googleapis.com/myapp.events.UserCreated"), do: {:ok, MyApp.Events.UserCreated}
        def to_module("myapp.internal/myapp.events.OrderPlaced"), do: {:ok, MyApp.Events.OrderPlaced}
        def to_module(_), do: {:error, "Unknown type_url"}
      end

  Then use it with `Protobuf.Any.unpack/2`:

      Protobuf.Any.unpack(any_message, MyApp.AnyTypeProvider)
      #=> {:ok, decoded_struct}
  """

  @doc """
  Convert a type URL to its corresponding Protobuf message module.

  Should return `{:ok, module}` if the type URL is recognized, or
  `{:error, reason}` if it cannot be resolved.
  """
  @callback to_module(type_url :: String.t()) :: {:ok, module()} | {:error, reason :: any()}
end
