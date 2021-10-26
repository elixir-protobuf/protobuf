defmodule Protobuf.ProtobufTest do
  use ExUnit.Case, async: false

  test "load_extensions/0 is a noop" do
    num_modules = loaded_extensions()
    Protobuf.load_extensions()
    assert loaded_extensions() == num_modules
  end

  defp loaded_extensions do
    Enum.count(:persistent_term.get(), &match?({{Protobuf.Extension, _, _}, _}, &1))
  end
end
