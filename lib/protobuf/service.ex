defmodule Protobuf.Service do
  @moduledoc """
  Module to be used in Service definitions.
  """

  defmodule DSL do
    defmacro rpc(name, request, response, opts \\ [])  do
      quote do
        @rpcs {unquote(name), unquote(request), unquote(response), unquote(opts)}
      end
    end

    defmacro stream(name) do
      quote do
        {:stream, unquote(name)}
      end
    end

    defmacro __before_compile__(env) do
      rpcs_value = Module.get_attribute(env.module, :rpcs) |> Enum.reverse

      quote do
        def rpcs do
          unquote(Macro.escape(rpcs_value))
        end
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Protobuf.Service.DSL, only: [rpc: 3, rpc: 4, stream: 1]

      Module.register_attribute __MODULE__, :rpcs, accumulate: true

      @before_compile Protobuf.Service.DSL
    end
  end
end