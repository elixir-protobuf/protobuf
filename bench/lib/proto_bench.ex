defmodule ProtoBench do
  def load(pb_path) do
    pb_path
    |> File.read!()
    |> Benchmarks.BenchmarkDataset.decode()
  end

  def mod_name(name) do
    name
    |> String.split(".")
    |> Enum.map(&Macro.camelize/1)
    |> Module.safe_concat()
  end
end
