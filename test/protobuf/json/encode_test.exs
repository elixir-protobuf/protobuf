defmodule Protobuf.JSON.EncodeTest do
  use ExUnit.Case, async: true

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3

  alias TestMsg.{
    ContainsTransformModule,
    Foo,
    Foo.Bar,
    Maps,
    OneofProto3,
    Parent,
    Parent.Child,
    Scalars
  }

  test "encodes strings and booleans as they are" do
    message = %Scalars{string: "エリクサー", bool: true}
    assert encode(message) == %{"string" => "エリクサー", "bool" => true}
  end

  test "encodes 32-bit integers as they are" do
    message = %Scalars{int32: 42, uint32: 42, sint32: 42, fixed32: 42, sfixed32: 42}

    encoded = %{
      "int32" => 42,
      "uint32" => 42,
      "sint32" => 42,
      "fixed32" => 42,
      "sfixed32" => 42
    }

    assert encode(message) == encoded

    message = %Scalars{int32: -42, uint32: -42, sint32: -42, fixed32: -42, sfixed32: -42}

    encoded = %{
      "int32" => -42,
      "uint32" => -42,
      "sint32" => -42,
      "fixed32" => -42,
      "sfixed32" => -42
    }

    assert encode(message) == encoded
  end

  test "encodes 64-bit integers as strings" do
    message = %Scalars{int64: 42, uint64: 42, sint64: 42, fixed64: 42, sfixed64: 42}

    encoded = %{
      "int64" => "42",
      "uint64" => "42",
      "sint64" => "42",
      "fixed64" => "42",
      "sfixed64" => "42"
    }

    assert encode(message) == encoded

    message = %Scalars{int64: -42, uint64: -42, sint64: -42, fixed64: -42, sfixed64: -42}

    encoded = %{
      "int64" => "-42",
      "uint64" => "-42",
      "sint64" => "-42",
      "fixed64" => "-42",
      "sfixed64" => "-42"
    }

    assert encode(message) == encoded
  end

  test "encodes floats and doubles as JSON numbers" do
    message = %Scalars{float: 1.234, double: 1.23456789}
    assert encode(message) == %{"float" => 1.234, "double" => 1.23456789}

    message = %Scalars{float: 1.23e3, double: 1.23e-300}
    assert encode(message) == %{"float" => 1230.0, "double" => 1.23e-300}
  end

  test "encodes non-numeric floats and doubles" do
    message = %Scalars{float: :nan, double: :nan}
    assert encode(message) == %{"float" => "NaN", "double" => "NaN"}

    message = %Scalars{float: :infinity, double: :infinity}
    assert encode(message) == %{"float" => "Infinity", "double" => "Infinity"}

    message = %Scalars{float: :negative_infinity, double: :negative_infinity}
    assert encode(message) == %{"float" => "-Infinity", "double" => "-Infinity"}
  end

  test "encodes bytes in Base64 with padding" do
    message = %Scalars{bytes: "abcde"}
    assert encode(message) == %{"bytes" => "YWJjZGU="}

    message = %Scalars{bytes: <<0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF>>}
    assert encode(message) == %{"bytes" => "/////////w=="}
  end

  test "encodes enums" do
    message = %Foo{j: 2, m: :C}
    assert encode(message) == %{"j" => :B, "m" => :C}

    message = %Foo{j: 0, m: :UNKNOWN}
    assert encode(message) == %{}

    # proto3 accepts numeric unknown values
    message = %Foo{j: -999}
    assert encode(message) == %{"j" => -999}
  end

  test "encodes all enums as numbers when use_enum_numbers is on" do
    message = %Foo{j: 2, m: :C}
    assert encode(message, use_enum_numbers: true) == %{"j" => 2, "m" => 4}
  end

  test "encodes oneof fields" do
    message = %OneofProto3{first: {:a, 1}, second: {:d, "d"}, other: "other"}
    assert encode(message) == %{"a" => 1, "d" => "d", "other" => "other"}
  end

  test "skips unset oneof fields" do
    message = %OneofProto3{first: {:a, 1}, other: "other"}
    assert encode(message) == %{"a" => 1, "other" => "other"}
  end

  test "always emits set oneof fields, even if to their default values" do
    message = %OneofProto3{first: {:a, 0}, second: {:d, ""}}

    assert encode(message) == %{"a" => 0, "d" => ""}
    assert encode(message, emit_unpopulated: true) == %{"a" => 0, "d" => "", "other" => ""}
  end

  test "encodes embedded" do
    message = %Foo{e: %Bar{a: 12, b: "abc"}, f: 2}
    assert encode(message) == %{"e" => %{"a" => 12, "b" => "abc"}, "f" => 2}

    message = %Parent{child: %Child{parent: %Parent{}}}
    assert encode(message) == %{"child" => %{"parent" => %{}}}

    message = %Parent{child: nil}
    assert encode(message) == %{}
  end

  test "encodes repeated" do
    message = %Foo{g: [1, 2], h: [%Bar{a: 1}, %Bar{b: "b"}], o: [:UNKNOWN, 1, :B]}

    encoded = %{
      "g" => [1, 2],
      "h" => [%{"a" => 1}, %{"b" => "b"}],
      "o" => [:UNKNOWN, :A, :B]
    }

    assert encode(message) == encoded
  end

  test "encodes maps" do
    message = %Foo{l: %{"foo" => 123, "bar" => 456}}
    assert encode(message) == %{"l" => %{"foo" => 123, "bar" => 456}}
  end

  test "skips empty maps" do
    message = %Foo{l: %{}}
    assert encode(message) == %{}
  end

  test "map values are always emitted, even when equal to their default" do
    message = %Foo{l: %{"foo" => 123, "bar" => 0}}
    assert encode(message) == %{"l" => %{"foo" => 123, "bar" => 0}}
  end

  test "map keys are encoded according to their type and then converted to string" do
    mapii = %{-1 => -1, 0 => 0, 1 => 1, 0b11 => 3, 0xFF => 255}
    mapbi = %{true => 1, false => 0}
    mapsi = %{"" => 0, "ok" => 999_999_999}
    message = %Maps{mapii: mapii, mapbi: mapbi, mapsi: mapsi}

    encoded = %{
      "mapii" => %{"-1" => -1, "0" => 0, "1" => 1, "3" => 3, "255" => 255},
      "mapbi" => %{"true" => 1, "false" => 0},
      "mapsi" => %{"" => 0, "ok" => 999_999_999}
    }

    assert encode(message) == encoded
  end

  test "nil map values remain nil" do
    message = %Foo{l: %{"foo" => nil}}
    assert encode(message) == %{"l" => %{"foo" => nil}}
  end

  describe "field names" do
    defmodule Naming do
      use Protobuf, syntax: :proto3

      field :simple, 1, type: :int32
      field :camel_case, 2, type: :int32, json_name: "camelCase"
      field :custom, 3, type: :int32, json_name: "customName"
    end

    test "use :json_name or fall back to :name by default" do
      message = %Naming{simple: 1, camel_case: 2, custom: 3}
      assert encode(message) == %{"simple" => 1, "camelCase" => 2, "customName" => 3}
    end

    test "are :name when :use_proto_names is on" do
      message = %Naming{simple: 1, camel_case: 2, custom: 3}
      encoded = %{"simple" => 1, "camel_case" => 2, "custom" => 3}
      assert encode(message, use_proto_names: true) == encoded
    end
  end

  test "always emits all fields when emit_unpopulated is on" do
    decoded = %{
      "a" => 0,
      "b" => "0",
      "c" => "",
      "d" => 0.0,
      "e" => nil,
      "f" => 0,
      "g" => [],
      "h" => [],
      "i" => [],
      "j" => :UNKNOWN,
      "k" => false,
      "l" => %{},
      "m" => :UNKNOWN,
      "n" => 0.0,
      "non_matched" => "",
      "o" => [],
      "p" => ""
    }

    bar = %{"a" => 0, "b" => ""}

    message = %Foo{}
    assert encode(message, emit_unpopulated: true) == decoded

    message = %Foo{e: %Bar{}}
    assert encode(message, emit_unpopulated: true) == %{decoded | "e" => bar}

    message = %Foo{h: [%Bar{}, %Bar{}]}
    assert encode(message, emit_unpopulated: true) == %{decoded | "h" => [bar, bar]}
  end

  test "encodes with transformer module" do
    assert Protobuf.JSON.encode!(%ContainsTransformModule{field: 123}) ==
             ~S|{"field":{"field":123}}|

    assert Protobuf.JSON.encode!(%ContainsTransformModule{field: 0}) == ~S|{}|
    assert Protobuf.JSON.encode!(%ContainsTransformModule{field: nil}) == ~S|{}|
  end

  describe "Google.Protobuf.* value wrappers" do
    test "Google.Protobuf.BoolValue" do
      message = %TestAllTypesProto3{
        optional_bool_wrapper: %Google.Protobuf.BoolValue{value: true}
      }

      assert encode(message) == %{"optionalBoolWrapper" => true}
    end

    test "Google.Protobuf.StringValue" do
      message = %TestAllTypesProto3{
        optional_string_wrapper: %Google.Protobuf.StringValue{value: "foo"}
      }

      assert encode(message) == %{"optionalStringWrapper" => "foo"}
    end

    test "Google.Protobuf.FloatValue" do
      message = %TestAllTypesProto3{
        optional_float_wrapper: %Google.Protobuf.FloatValue{value: 3.14}
      }

      assert encode(message) == %{"optionalFloatWrapper" => 3.14}
    end

    test "Google.Protobuf.DoubleValue" do
      message = %TestAllTypesProto3{
        optional_double_wrapper: %Google.Protobuf.DoubleValue{value: 3.14}
      }

      assert encode(message) == %{"optionalDoubleWrapper" => 3.14}
    end

    test "Google.Protobuf.Int32Value" do
      message = %TestAllTypesProto3{
        optional_int32_wrapper: %Google.Protobuf.Int32Value{value: -3}
      }

      assert encode(message) == %{"optionalInt32Wrapper" => -3}
    end

    test "Google.Protobuf.UInt32Value" do
      message = %TestAllTypesProto3{
        optional_uint32_wrapper: %Google.Protobuf.UInt32Value{value: 3}
      }

      assert encode(message) == %{"optionalUint32Wrapper" => 3}
    end

    test "Google.Protobuf.Int64Value" do
      message = %TestAllTypesProto3{
        optional_int64_wrapper: %Google.Protobuf.Int64Value{value: -3}
      }

      assert encode(message) == %{"optionalInt64Wrapper" => -3}
    end

    test "Google.Protobuf.UInt64Value" do
      message = %TestAllTypesProto3{
        optional_uint64_wrapper: %Google.Protobuf.UInt64Value{value: 3}
      }

      assert encode(message) == %{"optionalUint64Wrapper" => 3}
    end
  end

  describe "Google.Protobuf.BytesValue" do
    test "encodes with base 64" do
      message = %TestAllTypesProto3{
        optional_bytes_wrapper: %Google.Protobuf.BytesValue{value: <<1, 2, 3>>}
      }

      assert encode(message) == %{"optionalBytesWrapper" => Base.url_encode64(<<1, 2, 3>>)}
    end
  end

  describe "Google.Protobuf.FieldMask" do
    test "encodes with base 64" do
      message = %TestAllTypesProto3{
        optional_field_mask: %Google.Protobuf.FieldMask{paths: ["foo_bar", "baz_bong"]}
      }

      assert encode(message) == %{"optionalFieldMask" => "fooBar,bazBong"}
    end

    test "encodes with a period in the path" do
      message = %TestAllTypesProto3{
        optional_field_mask: %Google.Protobuf.FieldMask{paths: ["foo.bar", "foo_bar.baz_bong"]}
      }

      assert encode(message) == %{"optionalFieldMask" => "foo.bar,fooBar.bazBong"}
    end
  end

  describe "Google.Protobuf.Duration" do
    test "encodes as a string" do
      cases = [
        %{string: "123s", seconds: 123, nanos: 0},
        %{string: "123.001s", seconds: 123, nanos: 1_000_000},
        %{string: "0.000000001s", seconds: 0, nanos: 1},
        %{string: "-1s", seconds: -1, nanos: 0},
        %{string: "-1.100s", seconds: -1, nanos: -100_000_000},
        %{string: "-0.500s", seconds: 0, nanos: -500_000_000}
      ]

      for %{string: expected_string, seconds: seconds, nanos: nanos} <- cases do
        message = %TestAllTypesProto3{
          optional_duration: %Google.Protobuf.Duration{seconds: seconds, nanos: nanos}
        }

        assert encode(message) == %{"optionalDuration" => expected_string}
      end
    end

    test "returns an error if the seconds of the duration are too big" do
      max_duration = 315_576_000_000

      message = %TestAllTypesProto3{
        optional_duration: %Google.Protobuf.Duration{seconds: max_duration + 1, nanos: 0}
      }

      assert catch_throw(encode(message)) ==
               {:bad_duration, :seconds_outside_of_range, max_duration + 1}
    end

    test "returns an error if the seconds of the duration are too small" do
      max_duration = 315_576_000_000

      message = %TestAllTypesProto3{
        optional_duration: %Google.Protobuf.Duration{seconds: -max_duration - 1, nanos: 0}
      }

      assert catch_throw(encode(message)) ==
               {:bad_duration, :seconds_outside_of_range, -max_duration - 1}
    end
  end

  describe "Google.Protobuf.Timestamp" do
    test "encodes the timestamp as a string" do
      {:ok, datetime, _offset = 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      unix_seconds = DateTime.to_unix(datetime, :second)

      timestamp = %Google.Protobuf.Timestamp{seconds: unix_seconds, nanos: 0}
      message = %TestAllTypesProto3{optional_timestamp: timestamp}

      assert encode(message) == %{"optionalTimestamp" => "2000-01-01T00:00:00Z"}
    end

    test "returns an error if the timestamp is outside of the allowed range" do
      {:ok, datetime, _offset = 0} = DateTime.from_iso8601("0000-01-01T00:00:00Z")
      unix_seconds = DateTime.to_unix(datetime, :second)

      timestamp = %Google.Protobuf.Timestamp{seconds: unix_seconds, nanos: 0}
      message = %TestAllTypesProto3{optional_timestamp: timestamp}

      assert catch_throw(encode(message)) ==
               {:invalid_timestamp, timestamp, "timestamp is outside of allowed range"}
    end
  end

  describe "Google.Protobuf.Value" do
    test "encodes correctly" do
      cases = [
        {{:string_value, "foo"}, "foo"},
        {{:bool_value, true}, true},
        {{:number_value, 3.14}, 3.14},
        {{:number_value, 1}, 1},
        {{:null_value, :NULL_VALUE}, nil}
      ]

      for {kind, json} <- cases do
        value = %Google.Protobuf.Value{kind: kind}
        message = %TestAllTypesProto3{optional_value: value}
        assert encode(message) == %{"optionalValue" => json}
      end
    end
  end

  describe "Google.Protobuf.ListValue" do
    test "encodes correctly" do
      value = %Google.Protobuf.ListValue{values: []}
      message = %TestAllTypesProto3{repeated_list_value: [value]}
      assert encode(message) == %{"repeatedListValue" => [[]]}
    end
  end

  describe "Google.Protobuf.Struct" do
    test "encodes correctly" do
      value = %Google.Protobuf.Struct{fields: %{"foo" => %Google.Protobuf.Empty{}}}
      message = %TestAllTypesProto3{optional_struct: value}
      assert encode(message) == %{"optionalStruct" => %{"foo" => %{}}}
    end
  end

  describe "encoding performs validation" do
    test "with scalar types" do
      cases = [
        %{key: :int32_map, wrong_value: "not int32", expected_type: :int32},
        %{key: :sint32_map, wrong_value: "not sint32", expected_type: :sint32},
        %{key: :sfixed32_map, wrong_value: "not sfixed32", expected_type: :sfixed32},
        %{key: :fixed32_map, wrong_value: "not fixed32", expected_type: :fixed32},
        %{key: :uint32_map, wrong_value: "not uint32", expected_type: :uint32},
        %{key: :int64_map, wrong_value: "not int64", expected_type: :int64},
        %{key: :sint64_map, wrong_value: "not sint64", expected_type: :sint64},
        %{key: :sfixed64_map, wrong_value: "not sfixed64", expected_type: :sfixed64},
        %{key: :fixed64_map, wrong_value: "not fixed64", expected_type: :fixed64},
        %{key: :uint64_map, wrong_value: "not uint64", expected_type: :uint64},
        %{key: :float_map, wrong_value: "not float", expected_type: :float},
        %{key: :double_map, wrong_value: "not double", expected_type: :double},
        %{key: :string_map, wrong_value: %{levels: %{level_1: 0.4}}, expected_type: :string},
        %{key: :bool_map, wrong_value: "not bool", expected_type: :bool},
        %{key: :bytes_map, wrong_value: 42, expected_type: :bytes},
        %{key: :enum_map, wrong_value: "not an map enum value", expected_type: :enum}
      ]

      for %{key: key, wrong_value: wrong_value, expected_type: expected_type} <- cases do
        message = struct!(My.Test.MapInput, %{key => %{value: wrong_value}})

        assert {:invalid_type, ^expected_type, ^wrong_value} = catch_throw(encode(message))
      end
    end

    test "with enums" do
      message = %My.Test.MapInput{enum_map: %{value: :NOT_VALID}}

      assert {:unknown_enum_value, :NOT_VALID, My.Test.MapEnum} =
               catch_throw(encode(message, use_enum_numbers: false))

      assert {:unknown_enum_value, :NOT_VALID, My.Test.MapEnum} =
               catch_throw(encode(message, use_enum_numbers: true))
    end
  end

  defp encode(struct, opts \\ []) do
    Protobuf.JSON.Encode.to_encodable(struct, opts)
  end
end
