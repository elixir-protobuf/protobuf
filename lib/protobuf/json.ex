defmodule Protobuf.JSON do
  @moduledoc """
  JSON encoding and decoding utilities for Protobuf structs.

  It follows Google's [specs](https://developers.google.com/protocol-buffers/docs/proto3#json)
  and reference implementation. Only `proto3` syntax is supported at the moment. Some features
  such as [well-known](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf)
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

  And go the other way around with `decode/1`:

      iex> json = ~S|{"color":"RED","topSpeed":125.3}|
      iex> Protobuf.JSON.decode(json, Car)
      {:ok, %Car{color: :RED, top_speed: 125.3}}

  JSON keys are encoded as camelCase strings by default, specified by the `json_name` field
  option. So make sure to *recompile the `.proto` files in your project* before working with
  JSON encoding, the compiler will generate all the required `json_name` options. You can set
  your own `json_name` for a particular field too:

      message GeoCoordinate {
        double latitude = 1 [ json_name = "lat" ];
        double longitude = 2 [ json_name = "long" ];
      }

  ## Known issues and limitations

  Currently, the `protoc` compiler won't check for field name collisions, this library either.
  So make sure your field names will be unique when serialized to JSON. For instance, this
  message definition will not encode correctly, it will emit just one of the two fields, and
  the problem might go unnoticed:

      message CollidingFields {
        int32 f1 = 1 [json_name = "sameName"];
        float f2 = 2 [json_name = "sameName"];
      }

  According to the specification, when duplicated JSON keys are found in maps, the library
  should raise a decoding error. It currently ignores duplicates and keeps the last occurrence.
  """

  alias Protobuf.JSON.{Encode, EncodeError, Decode, DecodeError}

  @type encode_opt ::
          {:use_proto_names, boolean}
          | {:use_enum_numbers, boolean}
          | {:emit_unpopulated, boolean}

  @type json_data :: %{optional(binary) => any}

  @doc """
  Generates a JSON representation of the given protobuf `struct`.

  Similar to `encode/2` except it will unwrap the error tuple and raise in case of errors.

  ## Examples

      iex> Car.new(top_speed: 80.0) |> Protobuf.JSON.encode!()
      ~S|{"topSpeed":80.0}|

      iex> TestMsg.Foo2.new() |> Protobuf.JSON.encode!()
      ** (Protobuf.JSON.EncodeError) JSON encoding of 'proto2' syntax is unsupported, try proto3
  """
  @spec encode!(struct, [encode_opt]) :: String.t() | no_return
  def encode!(struct, opts \\ []) do
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

      syntax = "proto3";

      message Car {
        enum Color {
          GREEN = 0;
          RED = 1;
        }

        Color color = 1;
        float top_speed = 2;
      }

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
  def encode(struct, opts \\ []) do
    if jason = load_jason() do
      with {:ok, map} <- to_encodable(struct, opts), do: jason.encode(map)
    else
      {:error, EncodeError.new(:no_json_lib)}
    end
  end

  @doc """
  Generates a JSON-encodable map for the given protobuf `struct`.

  Similar to `encode/2` except it will return an intermediate `map` representation.

  ## Examples

      iex> Car.new(color: :RED, top_speed: 125.3) |> Protobuf.JSON.to_encodable()
      {:ok, %{"color" => :RED, "topSpeed" => 125.3}}

      iex> Car.new(color: :GREEN) |> Protobuf.JSON.to_encodable()
      {:ok, %{}}

      iex> Car.new() |> Protobuf.JSON.to_encodable(emit_unpopulated: true)
      {:ok, %{"color" => :GREEN, "topSpeed" => 0.0}}
  """
  @spec to_encodable(struct, [encode_opt]) :: {:ok, json_data} | {:error, EncodeError.t()}
  def to_encodable(struct, opts \\ []) do
    {:ok, Encode.to_encodable(struct, opts)}
  catch
    error -> {:error, EncodeError.new(error)}
  end

  @doc """
  Decodes a JSON `iodata` into a `module` Protobuf struct.

  Similar to `decode!/2` except it will unwrap the error tuple and raise in case of errors.

  ## Examples

      iex> Protobuf.JSON.decode!("{}", Car)
      %Car{color: :GREEN, top_speed: 0.0}

      iex> ~S|{"color":"RED"}| |> Protobuf.JSON.decode!(Car)
      %Car{color: :RED, top_speed: 0.0}

      iex> ~S|{"color":"GREEN","topSpeed":80.0}| |> Protobuf.JSON.decode!(Car)
      %Car{color: :GREEN, top_speed: 80.0}

  """
  @spec decode!(iodata, module) :: struct | no_return
  def decode!(iodata, module) do
    case decode(iodata, module) do
      {:ok, json} -> json
      {:error, error} -> raise error
    end
  end

  @doc """
  Decodes a JSON `iodata` into a `module` Protobuf struct.

  ## Examples

  Given these proto modules:

      syntax = "proto3";

      message Car {
        enum Color {
          GREEN = 0;
          RED = 1;
        }

        Color color = 1;
        float top_speed = 2;
      }

  You can build their structs from JSON like so:

      iex> Protobuf.JSON.decode("{}", Car)
      {:ok, %Car{color: :GREEN, top_speed: 0.0}}

      iex> ~S|{"color":"RED"}| |> Protobuf.JSON.decode(Car)
      {:ok, %Car{color: :RED, top_speed: 0.0}}

      iex> ~S|{"color":"GREEN","topSpeed":80.0}| |> Protobuf.JSON.decode(Car)
      {:ok, %Car{color: :GREEN, top_speed: 80.0}}
  """
  @spec decode(iodata, module) :: {:ok, struct} | {:error, DecodeError.t() | Exception.t()}
  def decode(iodata, module) do
    if jason = load_jason() do
      with {:ok, json_data} <- jason.decode(iodata),
           do: from_decoded(json_data, module)
    else
      {:error, DecodeError.new(:no_json_lib)}
    end
  end

  @doc """
  Decodes a `json_data` map into a `module` Protobuf struct.

  Similar to `decode/2` except it takes a JSON `map` representation of the data.

  ## Examples

      iex> Protobuf.JSON.from_decoded(%{}, Car)
      {:ok, %Car{color: :GREEN, top_speed: 0.0}}

      iex> Protobuf.JSON.from_decoded(%{"color" => "RED"}, Car)
      {:ok, %Car{color: :RED, top_speed: 0.0}}

      iex> Protobuf.JSON.from_decoded(%{"color" => "GREEN","topSpeed" => 80.0}, Car)
      {:ok, %Car{color: :GREEN, top_speed: 80.0}}

  """
  @spec from_decoded(json_data, module) :: {:ok, struct} | {:error, DecodeError.t()}
  def from_decoded(json_data, module) do
    {:ok, Decode.from_json_data(json_data, module)}
  catch
    error -> {:error, DecodeError.new(error)}
  end

  defp load_jason, do: Code.ensure_loaded?(Jason) and Jason
end
