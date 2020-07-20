# Standard benchmark. Its output is compatible with the built-in benchmarks from
# protobuf for official language implementations, including encoding and decoding
# throughput on each dataset.
#
# Based on Python's implementation:
# https://github.com/protocolbuffers/protobuf/blob/master/benchmarks/python/py_benchmark.py

single = fn fun, inputs ->
  Enum.reduce(inputs, 0, fn input, total ->
    {time, _result} = :timer.tc(fun, [input])
    total + time
  end)
end

repeat = fn fun, inputs, reps ->
  Enum.reduce(1..reps, 0, fn _, total ->
    total + single.(fun, inputs)
  end)
end

run = fn fun, inputs ->
  target_run_time = 3_000_000
  single_run_time = single.(fun, inputs)

  with true <- single_run_time < target_run_time,
       reps when reps > 1 <- trunc(ceil(target_run_time / single_run_time)) do
    repeat.(fun, inputs, reps) / reps
  else
    _ -> single_run_time
  end
end

throughput = fn bytes, microseconds ->
  megabytes = bytes / 1_048_576
  seconds = microseconds / 1_000_000
  Float.round(megabytes / seconds, 2)
end

for file <- Path.wildcard("data/*.pb") do
  %{payload: payloads, message_name: mod_name} = ProtoBench.load(file)
  module = ProtoBench.mod_name(mod_name)

  IO.puts("Message #{mod_name} of dataset file #{file}")

  bytes = Enum.reduce(payloads, 0, &(byte_size(&1) + &2))
  messages = Enum.map(payloads, &module.decode/1)

  parse = throughput.(bytes, run.(&module.decode/1, payloads))

  IO.puts("Average throughput for parse_from_benchmark: #{parse} MB/s")

  serialize = throughput.(bytes, run.(&module.encode/1, messages))

  IO.puts("Average throughput for serialize_to_benchmark: #{serialize} MB/s")
  IO.puts("")
end
