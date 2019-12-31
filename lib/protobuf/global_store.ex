defmodule Protobuf.GlobalStore do
  if function_exported?(:persistent_term, :get, 2) && function_exported?(:persistent_term, :put, 2) do
    def put(key, value) do
      :persistent_term.put(key, value)
    end

    def get(key, default) do
      :persistent_term.get(key, default)
    end
  end
end
