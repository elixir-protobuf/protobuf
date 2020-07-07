{head, 0} = System.cmd("git", ["symbolic-ref", "--short", "HEAD"])
{hash, 0} = System.cmd("git", ["rev-parse", "--short", "HEAD"])

tag = "#{String.trim(head)}-#{String.trim(hash)}"

opts = fn name, inputs ->
  [
    inputs: inputs,
    time: 20,
    memory_time: 5,
    save: [path: "benchmarks/#{tag}-#{name}.benchee", tag: "#{tag}-#{name}"],
    formatters: [Benchee.Formatters.Console]
  ]
end

benches =
  for path <- Path.wildcard("data/*.pb"),
      bench = ProtoBench.load(path),
      payload = Enum.max_by(bench.payload, &byte_size/1),
      module = ProtoBench.mod_name(bench.message_name),
      do: {bench.name, module, payload}

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
