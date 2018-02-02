
[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [field: 2, field: 3, oneof: 2],
  export: [
    locals_without_parens: [field: 2, field: 3, oneof: 2]
  ]
]
