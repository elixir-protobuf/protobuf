{head, 0} = System.cmd("git", ["symbolic-ref", "--short", "HEAD"])
{hash, 0} = System.cmd("git", ["rev-parse", "--short", "HEAD"])

tag = "#{String.trim(head)}-#{String.trim(hash)}"

opts = fn name, inputs ->
  [
    inputs: inputs,
    save: [path: "benchmarks/#{tag}-#{name}.benchee", tag: "#{tag}-#{name}"],
    formatters: [Benchee.Formatters.Console]
  ]
end

benches =
  for path <- Path.wildcard("data/*.pb"),
      # Skipping this particular message for now because it takes too long.
      path != "data/dataset.google_message3_1.pb",
      %{payload: [payload | _], name: name, message_name: mod_name} = ProtoBench.load(path),
      module = ProtoBench.mod_name(mod_name),
      do: {name, module, payload}

decode =
  for {name, module, payload} <- benches,
      into: %{},
      do: {name, [payload, module]}

Benchee.run(%{"decode" => &apply(Protobuf.Decoder, :decode, &1)}, opts.("decode", decode))

IO.puts("\n")

encode =
  for {name, module, payload} <- benches,
      into: %{},
      do: {name, module.decode(payload)}

Benchee.run(%{"encode" => &Protobuf.Encoder.encode/1}, opts.("encode", encode))
