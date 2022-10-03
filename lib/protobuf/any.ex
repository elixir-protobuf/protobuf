defmodule Protobuf.Any do
  @type_url_prefix "type.googleapis.com/"

  def pack(%mod{} = data) do
    Google.Protobuf.Any.new(%{
      type_url: "#{@type_url_prefix}#{mod.full_name()}",
      value: mod.encode(data)
    })
  end

  def unpack(
        %{__struct__: Google.Protobuf.Any, type_url: @type_url_prefix <> name, value: value},
        options \\ []
      ) do
    prefix = Keyword.get(options, :prefix, nil)

    parts =
      name
      |> String.split(".")
      |> Enum.map(fn x ->
        if String.match?(x, ~r/A-Z/) do
          x
        else
          Macro.camelize(x)
        end
      end)

    mod =
      if prefix do
        Module.concat([prefix] ++ parts)
      else
        Module.concat(parts)
      end

    mod.decode(value)
  end
end
