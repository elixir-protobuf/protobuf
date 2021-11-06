ExUnit.configure(exclude: [integration: true])
ExUnit.start()

Protobuf.load_extensions()

defmodule Protobuf.TestHelpers do
  def purge_modules(modules) when is_list(modules) do
    Enum.each(modules, fn mod ->
      :code.delete(mod)
      :code.purge(mod)
    end)
  end
end
