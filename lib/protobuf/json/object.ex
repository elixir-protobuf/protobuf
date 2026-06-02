defmodule Protobuf.JSON.Object do
  @moduledoc false

  # This is an internal structure that we use to avoid building maps right away
  # when decoding JSON; with maps, we cannot detect duplicate keys (by definition).

  defstruct [:members]

  @type t() :: %__MODULE__{members: [{binary(), term()}]}

  @spec new([{binary(), term()}]) :: t()
  def new(members) when is_list(members) do
    %__MODULE__{members: members}
  end

  @spec to_map!(t()) :: %{optional(binary()) => term()}
  def to_map!(%__MODULE__{members: members}) do
    Enum.reduce(members, %{}, fn {key, value}, acc ->
      if Map.has_key?(acc, key) do
        throw({:duplicated_json_key, key})
      else
        Map.put(acc, key, value)
      end
    end)
  end
end
