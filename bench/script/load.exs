Benchee.run(
  %{},
  load: "benchmarks/*-decode.benchee",
  print: [configuration: false],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "benchmarks/output/decode.html"}
  ]
)

Benchee.run(
  %{},
  load: "benchmarks/*-encode.benchee",
  print: [configuration: false],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "benchmarks/output/encode.html"}
  ]
)
