defmodule Protobuf.JSON.Utils do
  @moduledoc false

  @compile {:inline, check_syntax: 1}

  @doc false
  def message_props(module) when is_atom(module), do: check_syntax(module)
  def message_props(%module{}), do: check_syntax(module)

  defp check_syntax(module) do
    case module.__message_props__() do
      %Protobuf.MessageProps{syntax: :proto3} = props -> props
      %Protobuf.MessageProps{syntax: syntax} -> throw({:unsupported_syntax, syntax})
    end
  end
end
