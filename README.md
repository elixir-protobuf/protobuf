# protobuf-elixir

[![CI](https://github.com/elixir-protobuf/protobuf/actions/workflows/main.yml/badge.svg)](https://github.com/elixir-protobuf/protobuf/actions/workflows/main.yml)

A pure Elixir implementation of [Google Protobuf](https://developers.google.com/protocol-buffers/).

## Why this instead of exprotobuf(gpb)?

It has some must-have and other cool features like:

1. A protoc [plugin](https://developers.google.com/protocol-buffers/docs/cpptutorial#compiling-your-protocol-buffers) to generate Elixir code just like what other official libs do, which is powerful and reliable.
2. Generate **simple and explicit** code with the power of Macro. See [test/support/test_msg.ex](https://github.com/tony612/protobuf-elixir/blob/master/test/support/test_msg.ex).
3. Plugins support. Only [grpc](https://github.com/tony612/grpc-elixir) is supported now.
4. Use **structs** for messages instead of Erlang records.
5. Support Typespec in generated code.

## Installation

The package can be installed by adding `:protobuf` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:protobuf, "~> 0.7.1"},
    # Only for files generated from Google's protos.
    # Can be ignored if you don't use Google's protos.
    # Or you can generate the code by yourself.
    {:google_protos, "~> 0.1"}
  ]
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
* [x] Generate typespecs
* [x] oneof
* [x] (proto2) Extension (Experiment, see `Protobuf.Extension`)

## Usage

### Generate Elixir code

1. Install `protoc`(cpp) [here](https://github.com/google/protobuf/blob/master/src/README.md) or
   `brew install protobuf` on MacOS.

2.  Install protoc plugin `protoc-gen-elixir` for Elixir . NOTE: You have to
    make sure `protoc-gen-elixir`(this name is important) is in your PATH.

    ```bash
    $ mix escript.install hex protobuf
    ```

3.  Generate Elixir code using protoc

    ```bash
    $ protoc --elixir_out=./lib helloworld.proto
    ```

4.  Files `helloworld.pb.ex` will be generated, like:

    ```elixir
    defmodule Helloworld.HelloRequest do
      use Protobuf, syntax: :proto3

      @type t :: %__MODULE__{
        name: String.t
      }
      defstruct [:name]

      field :name, 1, type: :string
    end

    defmodule Helloworld.HelloReply do
      use Protobuf, syntax: :proto3

      @type t :: %__MODULE__{
        message: String.t
      }
      defstruct [:message]

      field :message, 1, type: :string
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
- Validation is done in `encode`. An error will be raised if the struct is invalid(like type is not matched).

### Descriptor support

If you use any custom options in your protobufs then to gain access to them you'll need to include the raw descriptors in the generated modules. You can generate the descriptors by passing `gen_descriptors=true` in `--elixir_out`.

The descriptors will be available on each module from the `descriptor/0` function.

```
$ protoc --elixir_out=gen_descriptors=true:./lib/ *.proto
$ protoc --elixir_out=gen_descriptors=true,plugins=grpc:./lib/ *.proto
```

### gRPC Support

If you write [services](https://developers.google.com/protocol-buffers/docs/proto#services) in protobuf, you can generate [gRPC](https://github.com/tony612/grpc-elixir) code by passing `plugins=grpc` in `--elixir_out`:
```
$ protoc --elixir_out=plugins=grpc:./lib/ *.proto
```

### Tips for protoc

Custom protoc-gen-elixir name or path using `--plugin`:

```bash
$ protoc --elixir_out=./lib --plugin=./protoc-gen-elixir *.proto
```

Pass `-I` argument if you import other protobuf files:

```bash
$ protoc -I protos --elixir_out=./lib protos/hello.proto
```

### Custom options

Since extensions(`Protobuf.Extension`) is supported now, some options are
defined, like custom module_prefix.

1.  Copy `src/elixirpb.proto` to your protos path.

2.  Import `elixirpb.proto` and use the options.

    ```proto
    syntax = "proto2";

    package your.pkg;

    import "elixirpb.proto";

    option (elixirpb.file).module_prefix = "Foo.Bar";
    ```

3.  Generate code as before

More options will be added in the future, see elixirpb.proto comments for details.

## Tests

```bash
mix test
```

## Sponsors

* [Tubi](https://tubitv.com/)

<img src="https://user-images.githubusercontent.com/1253659/37473536-4db44048-28a9-11e8-90d5-f8a2f5a8d53c.jpg" height="80">

* [Community](https://www.community.com)

<img src="https://user-images.githubusercontent.com/1253659/84641850-3f163d80-af2e-11ea-98a2-cfb854180222.png" height="80">

## Acknowledgements

Many thanks to [gpb](https://github.com/tomas-abrahamsson/gpb) and
[golang/protobuf](https://github.com/golang/protobuf) as good examples of
writing Protobuf decoder/encoder.
