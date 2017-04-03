# protobuf-elixir

A pure Elixir implementation of [Google Protobuf](https://developers.google.com/protocol-buffers/)

## Why this instead of gpb or exprotobuf?

It will have some must-have and other cool features like:

1. A protoc [plugin](https://developers.google.com/protocol-buffers/docs/reference/other)
  to generate Elixir code like what other official libs do.
2. Use **structs** for messages instead Erlang records.
3. Generate **simple and explicit** code with the power of Macro. (see
  [test/protobuf/dsl_test.exs](https://github.com/tony612/protobuf-elixir/blob/master/test/protobuf/decoder_test.exs))
4. Support Typespec in generated code.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `protobuf` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:protobuf, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/protobuf](https://hexdocs.pm/protobuf).

## TODO

* [x] Define messages with DSL
* [x] Decode basic messages
* [x] Skip unknown fields
* [ ] Decode embedded messages
* [ ] Decode packed and repeated fields
* [ ] Encode messages
* [ ] protoc plugin

## Acknowledgements

Many thanks to [gpb](https://github.com/tomas-abrahamsson/gpb) and
[golang/protobuf](https://github.com/golang/protobuf) as good examples of
writing Protobuf decoder/encoder.
