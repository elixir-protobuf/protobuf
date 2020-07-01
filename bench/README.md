# Benchmarks

This project contains benchmark tools and scripts based on the canonical protobuf messages and
datasets available [here](https://github.com/google/protobuf/tree/master/benchmarks).

## Setup

Datasets 1 and 2 are included and ready to use. If you want to run the full suite with datasets
3 and 4 too, download them with the script located at `data/download.sh` and you should have
all the required `.pb` files in the `data` folder.

## Running

First checkout the branch you want to get a baseline from, e.g. `master`, and then run the
`bench.exs` script. It will save collected results in the `benchmarks` folder.

```console
$ mix run script/bench.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.10.3
Erlang 23.0.2

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: google_message1_proto2, google_message1_proto3, google_message2, google_message3_2, google_message3_3, google_message3_4, google_message3_5, google_message4
Estimated total run time: 56 s

Benchmarking decode with input google_message1_proto2...
Benchmarking decode with input google_message1_proto3...
Benchmarking decode with input google_message2...
Benchmarking decode with input google_message3_2...
Benchmarking decode with input google_message3_3...
Benchmarking decode with input google_message3_4...
Benchmarking decode with input google_message3_5...
Benchmarking decode with input google_message4...

##### With input google_message1_proto2 #####
Name             ips        average  deviation         median         99th %
decode       52.17 K       19.17 μs   ±648.75%       13.90 μs      135.90 μs

##### With input google_message1_proto3 #####
Name             ips        average  deviation         median         99th %
decode       55.97 K       17.87 μs   ±397.87%       12.90 μs      123.90 μs

##### With input google_message2 #####
Name             ips        average  deviation         median         99th %
decode        347.81        2.88 ms    ±45.19%        2.58 ms        8.84 ms

##### With input google_message3_2 #####
Name             ips        average  deviation         median         99th %
decode        326.91        3.06 ms    ±45.20%        2.72 ms        8.90 ms

##### With input google_message3_3 #####
Name             ips        average  deviation         median         99th %
decode      193.00 K        5.18 μs   ±909.30%        3.90 μs       27.90 μs

##### With input google_message3_4 #####
Name             ips        average  deviation         median         99th %
decode      324.87 K        3.08 μs  ±1721.19%        1.90 μs       12.90 μs

##### With input google_message3_5 #####
Name             ips        average  deviation         median         99th %
decode      325.72 K        3.07 μs  ±1406.70%        1.90 μs       14.90 μs

##### With input google_message4 #####
Name             ips        average  deviation         median         99th %
decode      532.65 K        1.88 μs  ±2146.44%        0.90 μs        5.90 μs
Suite saved in external term format at benchmarks/master-92226d9-decode.benchee

Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.10.3
Erlang 23.0.2

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: google_message1_proto2, google_message1_proto3, google_message2, google_message3_2, google_message3_3, google_message3_4, google_message3_5, google_message4
Estimated total run time: 56 s

Benchmarking encode with input google_message1_proto2...
Benchmarking encode with input google_message1_proto3...
Benchmarking encode with input google_message2...
Benchmarking encode with input google_message3_2...
Benchmarking encode with input google_message3_3...
Benchmarking encode with input google_message3_4...
Benchmarking encode with input google_message3_5...
Benchmarking encode with input google_message4...

##### With input google_message1_proto2 #####
Name             ips        average  deviation         median         99th %
encode       14.67 K       68.18 μs   ±396.98%          40 μs      618.05 μs

##### With input google_message1_proto3 #####
Name             ips        average  deviation         median         99th %
encode       30.76 K       32.51 μs   ±513.01%          22 μs         270 μs

##### With input google_message2 #####
Name             ips        average  deviation         median         99th %
encode       38.99 K       25.65 μs   ±393.27%          18 μs         212 μs

##### With input google_message3_2 #####
Name             ips        average  deviation         median         99th %
encode        420.05        2.38 ms    ±42.61%        2.16 ms        6.88 ms

##### With input google_message3_3 #####
Name             ips        average  deviation         median         99th %
encode      104.10 K        9.61 μs   ±610.59%           7 μs          54 μs

##### With input google_message3_4 #####
Name             ips        average  deviation         median         99th %
encode       78.73 K       12.70 μs   ±305.85%           7 μs          82 μs

##### With input google_message3_5 #####
Name             ips        average  deviation         median         99th %
encode      193.58 K        5.17 μs   ±781.86%           3 μs          23 μs

##### With input google_message4 #####
Name             ips        average  deviation         median         99th %
encode      167.74 K        5.96 μs   ±681.35%           4 μs          24 μs
Suite saved in external term format at benchmarks/improve-benchmarks-92226d9-encode.benchee
```

After that, checkout your working branch and run the `bench.exs` script from there likewise.
Once you have both results saved you can build an HTML report with the `load.exs` script.

```console
$ mix run script/load.exs
Generated benchmarks/output/decode.html
...
Opened report using open
Generated benchmarks/output/encode.html
...
Opened report using open
```

## Protobuf standard benchmarks

Protobuf includes benchmarks for its official language implementations, such as Python, C++
and Golang. They measure average encode and decode throughput for each built-in dataset. This
is useful to check how Elixir matches up with them. You can read more about these benchmarks
[here](https://github.com/protocolbuffers/protobuf/blob/master/benchmarks/README.md).

To run the standard benchmarks for Elixir, download the datasets then run `standard_bench.exs`.

```console
$ mix run script/standard_bench.exs
Message benchmarks.proto2.GoogleMessage1 of dataset file data/dataset.google_message1_proto2.pb
Average throughput for parse_from_benchmark: 18.48 MB/s
Average throughput for serialize_to_benchmark: 6.19 MB/s

Message benchmarks.proto3.GoogleMessage1 of dataset file data/dataset.google_message1_proto3.pb
Average throughput for parse_from_benchmark: 18.4 MB/s
Average throughput for serialize_to_benchmark: 11.1 MB/s

Message benchmarks.proto2.GoogleMessage2 of dataset file data/dataset.google_message2.pb
Average throughput for parse_from_benchmark: 47.82 MB/s
Average throughput for serialize_to_benchmark: 5656.75 MB/s

Message benchmarks.google_message3.GoogleMessage3 of dataset file data/dataset.google_message3_1.pb
Average throughput for parse_from_benchmark: 19.94 MB/s
Average throughput for serialize_to_benchmark: 45.5 MB/s

Message benchmarks.google_message3.GoogleMessage3 of dataset file data/dataset.google_message3_2.pb
Average throughput for parse_from_benchmark: 110.65 MB/s
Average throughput for serialize_to_benchmark: 164.96 MB/s

Message benchmarks.google_message3.GoogleMessage3 of dataset file data/dataset.google_message3_3.pb
Average throughput for parse_from_benchmark: 9.8 MB/s
Average throughput for serialize_to_benchmark: 6.84 MB/s

Message benchmarks.google_message3.GoogleMessage3 of dataset file data/dataset.google_message3_4.pb
Average throughput for parse_from_benchmark: 5254.14 MB/s
Average throughput for serialize_to_benchmark: 737.71 MB/s

Message benchmarks.google_message3.GoogleMessage3 of dataset file data/dataset.google_message3_5.pb
Average throughput for parse_from_benchmark: 3.77 MB/s
Average throughput for serialize_to_benchmark: 3.29 MB/s

Message benchmarks.google_message4.GoogleMessage4 of dataset file data/dataset.google_message4.pb
Average throughput for parse_from_benchmark: 20.06 MB/s
Average throughput for serialize_to_benchmark: 32.46 MB/s
```

## Contributing

If you have trouble using the downloaded datasets, they might have been upgraded and their
corresponding Elixir files must be regenerated. This can be done with the `gen-bench-protos`
task. Make sure you have built the `protoc-gen-elixir` binary first with `mix escript.build`.

```console
$ cd protobuf-elixir
$ export PROTO_BENCH=<protobuf-install-root>/benchmarks
$ make gen-bench-protos
protoc -I ~/protobuf/benchmarks --elixir_out=bench/lib --plugin=./protoc-gen-elixir benchmarks.proto ... datasets/google_message4/benchmark_message4_3.proto
```
