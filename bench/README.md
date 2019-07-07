# ProtoBench

Datasets: https://github.com/google/protobuf/tree/master/benchmarks

## Run

```
$ mix run script/bench.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-8850H CPU @ 2.60GHz
Number of Available Cores: 12
Available memory: 16 GB
Elixir 1.7.4
Erlang 21.2.4
Benchmark suite executing with the following configuration:
warmup: 2 s
time: 10 s
parallel: 1
inputs: none specified
Estimated total run time: 48 s

Name                                    ips        average  deviation         median         99th %
google_message1_proto2 Decode      175.78 K        5.69 μs   ±929.55%           5 μs           9 μs
google_message1_proto3 Decode      167.17 K        5.98 μs   ±623.84%           5 μs          11 μs
google_message1_proto3 Encode       75.33 K       13.27 μs   ±313.73%          11 μs          32 μs
google_message1_proto2 Encode       45.02 K       22.21 μs   ±166.35%          18 μs          63 μs

# at git 45b7e72
Name                                    ips        average  deviation         median         99th %
google_message1_proto3 Decode       75.91 K       13.17 μs   ±218.50%          12 μs          31 μs
google_message1_proto3 Encode       68.66 K       14.56 μs   ±252.77%          12 μs          35 μs
google_message1_proto2 Decode       68.36 K       14.63 μs   ±298.50%          12 μs          40 μs
google_message1_proto2 Encode       44.71 K       22.37 μs   ±172.38%          19 μs          69 μs
```
