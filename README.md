# protobuf-elixir

[![Hex.pm](https://img.shields.io/hexpm/v/protobuf.svg)]()

A pure Elixir implementation of [Google Protobuf](https://developers.google.com/protocol-buffers/)

## Why this instead of exprotobuf(gpb)?

It have some must-have and other cool features like:

1. A protoc [plugin](https://developers.google.com/protocol-buffers/docs/cpptutorial#compiling-your-protocol-buffers) to generate Elixir code just like what other official libs do, which is powerful and reliable.
2. Generate **simple and explicit** code with the power of Macro. (see [test/support/test_msg.ex](https://github.com/tony612/protobuf-elixir/blob/master/test/support/test_msg.ex))
3. Plugins support. Only [grpc](https://github.com/tony612/grpc-elixir) is supported now.
4. Use **structs** for messages instead of Erlang records.
5. Support Typespec in generated code.

## Installation

The package can be installed
by adding `protobuf` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:protobuf, "~> 0.3.1"}]
end
```

## Features

* [x] Define messages with DSL
* [x] Decode basic messages
* [x] Skip unknown fields
* [x] Decode embedded messages
* [x] Decode packed and repeated fields
* [x] Encode messages
* [x] protoc plugin
* [x] map
* [x] Support default values
* [x] Validate values
* [ ] Generate typespecs
* [ ] oneof

## Usage

### Generate Elixir code

1. Install `protoc` [here](https://developers.google.com/protocol-buffers/docs/downloads)
2. Install protoc plugin `protoc-gen-elixir` for Elixir . NOTE: You have to make sure `protoc-gen-elixir`(this name is important) is in your PATH.
```
$ mix escript.install hex protobuf
```
3. Generate Elixir code using protoc
```
$ protoc --elixir_out=./lib foo.proto
```
4. Files `foo.pb.ex` will be generated, like:

```elixir
defmodule Foo.Bar do
  use Protobuf

  defstruct [:a, :b]

  field :a, 1, optional: true, type: :int32
  field :b, 2, optional: true, type: :string
end

defmodule Foo do
  use Protobuf

  defstruct [:a, :b, :c]

  field :a, 1, required: true, type: :float
  field :b, 2, optional: true, type: :fixed64, default: 5
  field :e, 3, optional: true, type: Foo.Bar
end
```

### Encode and decode in your code

```elixir
struct = Foo.new(a: 3.2, c: Foo.Bar.new())
encoded = Foo.encode(struct)
struct = Foo.decode(encoded)
```

Note:
- You should use `YourModule.new` instead of using the struct directly because default values will be set for all fields.
- Default values will be set by default in `decode`, which can be changed by `:use_default` option.
- Validation is done in `encode`. An error will be raised if the struct is invalid(like type is not matched).

### gRPC Support

If you write [services](https://developers.google.com/protocol-buffers/docs/proto#services) in protobuf, you can generate [gRPC](https://github.com/tony612/grpc-elixir) code by passing `plugins=grpc` in --go_out:
```
$ protoc --elixir_out=plugins=grpc:./lib/ *.proto
```

### Tips for protoc

- Custom protoc-gen-elixir name or path using `--plugin`
```
$ protoc --elixir_out=./lib --plugin=./protoc-gen-elixir *.proto
```
- Pass `-I` argument if you import other protobuf files
```
$ protoc -I protos --elixir_out=./lib protos/hello.proto
```

## Acknowledgements

Many thanks to [gpb](https://github.com/tomas-abrahamsson/gpb) and
[golang/protobuf](https://github.com/golang/protobuf) as good examples of
writing Protobuf decoder/encoder.
