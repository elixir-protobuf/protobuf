defmodule Protobuf.JSON do
  @moduledoc """
  JSON encoding and decoding utilities for Protobuf structs.

  It follows Google's [specs](https://developers.google.com/protocol-buffers/docs/proto3#json)
  and reference implementation. Only `proto3` syntax is supported at the moment. Some features
  as [well-known](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf)
  types are not fully supported yet.

  ## Types

  Protobuf messages and embedded messages are encoded as objects, _repeated_ fields as arrays,
  _bytes_ as Base64 strings, _bool_ as booleans, _map_ as objects and so on.

  | proto3                   | JSON                  | Supported |
  |--------------------------|-----------------------|-----------|
  | `message`                | `object`              | Yes       |
  | `enum`                   | `string`              | Yes       |
  | `map<K,V>`               | `object`              | Yes       |
  | `repeated V`             | `array [v, …]`        | Yes       |
  | `bool`                   | `true, false`         | Yes       |
  | `string`                 | `string`              | Yes       |
  | `bytes`                  | `base64 string`       | Yes       |
  | `int32, fixed32, uint32` | `number`              | Yes       |
  | `int64, fixed64, uint64` | `string`              | Yes       |
  | `float, double`          | `number`              | Yes       |
  | `Any`                    | `object`              | No        |
  | `Timestamp`              | `string`              | No        |
  | `Duration`               | `string`              | No        |
  | `Struct`                 | `object`              | No        |
  | `Wrapper types`          | `various types`       | No        |
  | `FieldMask`              | `string`              | No        |
  | `ListValue`              | `array [foo, bar, …]` | No        |
  | `Value`                  | `value`               | No        |
  | `NullValue`              | `null`                | No        |
  | `Empty`                  | `object`              | No        |

  ## Usage

  `Protobuf.JSON` requires a JSON library to work, so first make sure you have `:jason` added
  to your dependencies:

      defp deps do
        [
          {:jason, "~> 1.2"},
          # ...
        ]
      end

  With `encode/1` you can turn any `Protobuf` message struct into a JSON string:

      iex> message = Car.new(color: :RED, top_speed: 125.3)
      iex> Protobuf.JSON.encode(message)
      {:ok, "{\\"color\\":\\"RED\\",\\"topSpeed\\":125.3}"}

  JSON keys are encoded as camelCase strings, specified by the `json_name` field options. So
  make sure to recompile the `.proto` files in your project before working with JSON encoding.
  You can set your own `json_name` too:

      message GeoCoordinate {
        double latitude = 1 [ json_name = "lat" ];
        double longitude = 2 [ json_name = "long" ];
      }

  """

  alias Protobuf.JSON.{Encode, EncodeError}

  @type encode_opt :: {:json_library, module} | Encode.encode_opt()

  @doc """
  Generates a JSON representation of the given protobuf `struct`.

  Similar to `encode/1` except it will unwrap the error tuple and raise in case of errors.

  ## Examples

      iex> Car.new(top_speed: 80.0) |> Protobuf.JSON.encode!()
      ~S|{"topSpeed":80.0}|

      iex> TestMsg.Foo2.new() |> Protobuf.JSON.encode!()
      ** (Protobuf.JSON.EncodeError) JSON encoding of 'proto2' syntax is unsupported, try proto3
  """
  @spec encode!(struct, [encode_opt]) :: String.t() | no_return
  def encode!(%_{} = struct, opts \\ []) do
    case encode(struct, opts) do
      {:ok, json} -> json
      {:error, error} -> raise error
    end
  end

  @doc """
  Generates a JSON representation of the given protobuf `struct`.

  ## Options

    * `:use_proto_names` - use original field `name` instead of the camelCase `json_name` for
      JSON keys (default is `false`).
    * `:use_enum_numbers` - encode `enum` field values as numbers instead of their labels
      (default is `false`).
    * `:emit_unpopulated` - emit all fields, even when they are blank, empty or set to their
      default value (default is `false`).

  ## Examples

  Suppose these are you proto modules:

      defmodule Color do
        use Protobuf, syntax: :proto3, enum: true
        field :GREEN, 0
        field :RED, 1
      end

      defmodule Car do
        use Protobuf, syntax: :proto3
        field :color, 1, type: Color, enum: true
        field :top_speed, 2, type: :float, json_name: "topSpeed"
      end

  Encoding should be as simple as:

      iex> Car.new(color: :RED, top_speed: 125.3) |> Protobuf.JSON.encode()
      {:ok, ~S|{"color":"RED","topSpeed":125.3}|}

      iex> Car.new(color: :GREEN) |> Protobuf.JSON.encode()
      {:ok, "{}"}

      iex> Car.new() |> Protobuf.JSON.encode(emit_unpopulated: true)
      {:ok, ~S|{"color":"GREEN","topSpeed":0.0}|}
  """
  @spec encode(struct, [encode_opt]) ::
          {:ok, String.t()} | {:error, EncodeError.t() | Exception.t()}
  def encode(%module{} = struct, opts \\ []) do
    with {:ok, props} <- get_props(module),
         {:ok, json_library} <- get_json_library(opts) do
      struct
      |> Encode.encode(props, opts)
      |> json_library.encode()
    end
  end

  defp get_props(module) do
    case module.__message_props__() do
      %{syntax: :proto3} = props ->
        {:ok, props}

      %{syntax: syntax} ->
        {:error, EncodeError.new({:unsupported_syntax, syntax})}
    end
  end

  defp get_json_library(opts) do
    json_library = Keyword.get(opts, :json_library, Jason)

    if Code.ensure_loaded?(json_library) do
      {:ok, json_library}
    else
      {:error, EncodeError.new(:no_json_lib)}
    end
  end
end
