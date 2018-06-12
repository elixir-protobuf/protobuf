# TODO: group of proto2 is not supported
sets =
  Path.wildcard("**/dataset.google_message1*.pb")
  |> Enum.map(&ProtoBench.load(&1))
  |> Enum.reduce(%{}, fn %{payload: [payload]} = s, acc ->
    mod = ProtoBench.mod_name(s.message_name)
    msg = mod.decode(payload)
    # IO.inspect(msg)
    acc
    |> Map.put(s.name <> " Decode", fn -> mod.decode(payload) end)
    |> Map.put(s.name <> " Encode", fn -> mod.encode(msg) end)
  end)

Benchee.run(
  sets,
  time: 10,
  formatters: [
    Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)
