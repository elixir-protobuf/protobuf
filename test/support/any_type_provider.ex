defmodule Protobuf.AnyTypeProviderSupport do
  @moduledoc false

  @behaviour Protobuf.Any.TypeProvider

  @mappings %{
    "type.googleapis.com/google.protobuf.Duration" => Google.Protobuf.Duration,
    "type.googleapis.com/test.Request.SomeGroup" => My.Test.Request.SomeGroup
  }

  def to_module(type_url) do
    case Map.fetch(@mappings, type_url) do
      {:ok, module} -> {:ok, module}
      :error -> {:error, "Unknown type_url"}
    end
  end
end
