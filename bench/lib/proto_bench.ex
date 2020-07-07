defmodule ProtoBench do
  def load(pb_path) do
    bin = File.read!(pb_path)
    Benchmarks.BenchmarkDataset.decode(bin)
  end

  def mod_name("benchmarks.proto2.GoogleMessage1"), do: Benchmarks.Proto2.GoogleMessage1
  def mod_name("benchmarks.proto3.GoogleMessage1"), do: Benchmarks.Proto3.GoogleMessage1
  def mod_name("benchmarks.proto2.GoogleMessage2"), do: Benchmarks.Proto2.GoogleMessage2
end
