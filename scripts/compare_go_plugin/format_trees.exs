# Formats every .ex file under the given roots with Code.format_string!/1 so
# printer wrapping is not part of the escript-vs-Go comparison contract.
#
# Usage: elixir format_trees.exs <dir> [<dir>...]
for root <- System.argv() do
  for file <- Path.wildcard(Path.join(root, "**/*.ex")) do
    source = File.read!(file)

    formatted =
      source
      |> Code.format_string!()
      |> IO.iodata_to_binary()

    formatted =
      if String.ends_with?(formatted, "\n"), do: formatted, else: formatted <> "\n"

    File.write!(file, formatted)
  end
end
