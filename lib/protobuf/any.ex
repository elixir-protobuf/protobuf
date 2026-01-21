defmodule Protobuf.Any do
  @moduledoc """
  Provides functions for working with the `google.protobuf.Any` type.
  """
  @moduledoc since: "0.16.0"

  @type_url_prefix "type.googleapis.com/"

  @doc """
  Packs a Protobuf message into a `Google.Protobuf.Any` message.

  ## Example

      message = MyPkg.MyMessage.new(%{field: "value"})
      any = Protobuf.Any.pack(message)
      #=> %Google.Protobuf.Any{
      #=>   type_url: "type.googleapis.com/my_pkg.MyMessage",
      #=>   value: <<...>>
      #=> }

  """
  @spec pack(struct()) :: Google.Protobuf.Any.t()
  def pack(%mod{} = data) do
    %Google.Protobuf.Any{
      type_url: "#{@type_url_prefix}#{mod.full_name()}",
      value: mod.encode(data)
    }
  end

  @doc """
  Unpacks a `Google.Protobuf.Any` message using a custom type provider.

  The type provider module must implement the `Protobuf.Any.TypeProvider` behaviour,
  which defines how to convert type URLs to their corresponding message modules.

  ## Example

      defmodule MyApp.AnyTypeProvider do
        @behaviour Protobuf.Any.TypeProvider

        def to_module("type.googleapis.com/google.protobuf.Duration"), do: {:ok, Google.Protobuf.Duration}
        def to_module("type.googleapis.com/myapp.events.UserCreated"), do: {:ok, MyApp.Events.UserCreated}
        def to_module("myapp.internal/myapp.events.OrderPlaced"), do: {:ok, MyApp.Events.OrderPlaced}
        def to_module(_), do: {:error, "Unknown type_url"}
      end

      any = %Google.Protobuf.Any{
        type_url: "type.googleapis.com/myapp.events.UserCreated",
        value: <<...>>
      }
      Protobuf.Any.unpack(any, MyApp.AnyTypeProvider)
      #=> {:ok, %MyApp.Events.UserCreated{...}}
  """
  @spec unpack(Google.Protobuf.Any.t(), module()) ::
          {:ok, struct()} | {:error, reason :: any()}
  def unpack(%Google.Protobuf.Any{type_url: type_url, value: value}, type_provider) do
    with {:ok, module} <- type_provider.to_module(type_url) do
      {:ok, module.decode(value)}
    end
  end

  @doc false
  @spec type_url_to_module(String.t()) :: module()
  def type_url_to_module(type_url) when is_binary(type_url) do
    case type_url do
      @type_url_prefix <> package_and_message ->
        package_and_message
        |> String.split(".")
        |> Enum.map(&Macro.camelize/1)
        |> Module.safe_concat()

      _other ->
        raise ArgumentError,
              "type_url must be in the form: type.googleapis.com/<package>.<message name>, " <>
                "got: #{inspect(type_url)}"
    end
  end
end
