defmodule Protobuf.JSON.EncodeTest do
  use ExUnit.Case, async: true

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3
  alias TestMsg.{Foo, Foo.Bar, Maps, OneofProto3, Parent, Parent.Child, Scalars}

  def encode(struct, opts \\ []) do
    Protobuf.JSON.Encode.to_encodable(struct, opts)
  end

  test "encodes strings and booleans as they are" do
    message = Scalars.new!(string: "エリクサー", bool: true)
    assert encode(message) == %{"string" => "エリクサー", "bool" => true}
  end

  test "encodes 32-bit integers as they are" do
    message = Scalars.new!(int32: 42, uint32: 42, sint32: 42, fixed32: 42, sfixed32: 42)

    encoded = %{
      "int32" => 42,
      "uint32" => 42,
      "sint32" => 42,
      "fixed32" => 42,
      "sfixed32" => 42
    }

    assert encode(message) == encoded

    message = Scalars.new!(int32: -42, uint32: -42, sint32: -42, fixed32: -42, sfixed32: -42)

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
    message = Scalars.new!(int64: 42, uint64: 42, sint64: 42, fixed64: 42, sfixed64: 42)

    encoded = %{
      "int64" => "42",
      "uint64" => "42",
      "sint64" => "42",
      "fixed64" => "42",
      "sfixed64" => "42"
    }

    assert encode(message) == encoded

    message = Scalars.new!(int64: -42, uint64: -42, sint64: -42, fixed64: -42, sfixed64: -42)

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
    message = Scalars.new!(float: 1.234, double: 1.23456789)
    assert encode(message) == %{"float" => 1.234, "double" => 1.23456789}

    message = Scalars.new!(float: 1.23e3, double: 1.23e-300)
    assert encode(message) == %{"float" => 1230.0, "double" => 1.23e-300}
  end

  test "encodes non-numeric floats and doubles" do
    message = Scalars.new!(float: :nan, double: :nan)
    assert encode(message) == %{"float" => "NaN", "double" => "NaN"}

    message = Scalars.new!(float: :infinity, double: :infinity)
    assert encode(message) == %{"float" => "Infinity", "double" => "Infinity"}

    message = Scalars.new!(float: :negative_infinity, double: :negative_infinity)
    assert encode(message) == %{"float" => "-Infinity", "double" => "-Infinity"}
  end

  test "encodes bytes in Base64 with padding" do
    message = Scalars.new!(bytes: "abcde")
    assert encode(message) == %{"bytes" => "YWJjZGU="}

    message = Scalars.new!(bytes: <<0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF>>)
    assert encode(message) == %{"bytes" => "/////////w=="}
  end

  test "encodes enums" do
    message = Foo.new!(j: 2, m: :C)
    assert encode(message) == %{"j" => :B, "m" => :C}

    message = Foo.new!(j: 0, m: :UNKNOWN)
    assert encode(message) == %{}

    # proto3 accepts numeric unknown values
    message = Foo.new!(j: -999)
    assert encode(message) == %{"j" => -999}
  end

  test "encodes all enums as numbers when use_enum_numbers is on" do
    message = Foo.new!(j: 2, m: :C)
    assert encode(message, use_enum_numbers: true) == %{"j" => 2, "m" => 4}
  end

  test "encodes oneof fields" do
    message = OneofProto3.new!(first: {:a, 1}, second: {:d, "d"}, other: "other")
    assert encode(message) == %{"a" => 1, "d" => "d", "other" => "other"}
  end

  test "skips unset oneof fields" do
    message = OneofProto3.new!(first: {:a, 1}, other: "other")
    assert encode(message) == %{"a" => 1, "other" => "other"}
  end

  test "always emits set oneof fields, even if to their default values" do
    message = OneofProto3.new!(first: {:a, 0}, second: {:d, ""})

    assert encode(message) == %{"a" => 0, "d" => ""}
    assert encode(message, emit_unpopulated: true) == %{"a" => 0, "d" => "", "other" => ""}
  end

  test "encodes embedded" do
    message = Foo.new!(e: Bar.new!(a: 12, b: "abc"), f: 2)
    assert encode(message) == %{"e" => %{"a" => 12, "b" => "abc"}, "f" => 2}

    message = Parent.new!(child: Child.new!(parent: Parent.new()))
    assert encode(message) == %{"child" => %{"parent" => %{}}}

    message = Parent.new!(child: nil)
    assert encode(message) == %{}
  end

  test "encodes repeated" do
    message = Foo.new!(g: [1, 2], h: [Bar.new(a: 1), Bar.new(b: "b")], o: [:UNKNOWN, 1, :B])

    encoded = %{
      "g" => [1, 2],
      "h" => [%{"a" => 1}, %{"b" => "b"}],
      "o" => [:UNKNOWN, :A, :B]
    }

    assert encode(message) == encoded
  end

  test "encodes maps" do
    message = Foo.new!(l: %{"foo" => 123, "bar" => 456})
    assert encode(message) == %{"l" => %{"foo" => 123, "bar" => 456}}
  end

  test "skips empty maps" do
    message = Foo.new!(l: %{})
    assert encode(message) == %{}
  end

  test "map values are always emitted, even when equal to their default" do
    message = Foo.new!(l: %{"foo" => 123, "bar" => 0})
    assert encode(message) == %{"l" => %{"foo" => 123, "bar" => 0}}
  end

  test "map keys are encoded according to their type and then converted to string" do
    mapii = %{-1 => -1, 0 => 0, 1 => 1, 0b11 => 3, 0xFF => 255}
    mapbi = %{true => 1, false => 0}
    mapsi = %{"" => 0, "ok" => 999_999_999}
    message = Maps.new!(mapii: mapii, mapbi: mapbi, mapsi: mapsi)

    encoded = %{
      "mapii" => %{"-1" => -1, "0" => 0, "1" => 1, "3" => 3, "255" => 255},
      "mapbi" => %{"true" => 1, "false" => 0},
      "mapsi" => %{"" => 0, "ok" => 999_999_999}
    }

    assert encode(message) == encoded
  end

  test "nil map values remain nil" do
    message = Foo.new!(l: %{"foo" => nil})
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
      message = Naming.new!(simple: 1, camel_case: 2, custom: 3)
      assert encode(message) == %{"simple" => 1, "camelCase" => 2, "customName" => 3}
    end

    test "are :name when :use_proto_names is on" do
      message = Naming.new!(simple: 1, camel_case: 2, custom: 3)
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

    message = Foo.new()
    assert encode(message, emit_unpopulated: true) == decoded

    message = Foo.new(e: Bar.new())
    assert encode(message, emit_unpopulated: true) == %{decoded | "e" => bar}

    message = Foo.new(h: [Bar.new(), Bar.new()])
    assert encode(message, emit_unpopulated: true) == %{decoded | "h" => [bar, bar]}
  end

  describe "Google.Protobuf.* value wrappers" do
    test "Google.Protobuf.BoolValue" do
      message =
        TestAllTypesProto3.new!(
          optional_bool_wrapper: Google.Protobuf.BoolValue.new!(value: true)
        )

      assert encode(message) == %{"optionalBoolWrapper" => true}
    end

    test "Google.Protobuf.StringValue" do
      message =
        TestAllTypesProto3.new!(
          optional_string_wrapper: Google.Protobuf.StringValue.new!(value: "foo")
        )

      assert encode(message) == %{"optionalStringWrapper" => "foo"}
    end

    test "Google.Protobuf.FloatValue" do
      message =
        TestAllTypesProto3.new!(
          optional_float_wrapper: Google.Protobuf.FloatValue.new!(value: 3.14)
        )

      assert encode(message) == %{"optionalFloatWrapper" => 3.14}
    end

    test "Google.Protobuf.DoubleValue" do
      message =
        TestAllTypesProto3.new!(
          optional_double_wrapper: Google.Protobuf.DoubleValue.new!(value: 3.14)
        )

      assert encode(message) == %{"optionalDoubleWrapper" => 3.14}
    end

    test "Google.Protobuf.Int32Value" do
      message =
        TestAllTypesProto3.new!(
          optional_int32_wrapper: Google.Protobuf.Int32Value.new!(value: -3)
        )

      assert encode(message) == %{"optionalInt32Wrapper" => -3}
    end

    test "Google.Protobuf.UInt32Value" do
      message =
        TestAllTypesProto3.new!(
          optional_uint32_wrapper: Google.Protobuf.UInt32Value.new!(value: 3)
        )

      assert encode(message) == %{"optionalUint32Wrapper" => 3}
    end

    test "Google.Protobuf.Int64Value" do
      message =
        TestAllTypesProto3.new!(
          optional_int64_wrapper: Google.Protobuf.Int64Value.new!(value: -3)
        )

      assert encode(message) == %{"optionalInt64Wrapper" => -3}
    end

    test "Google.Protobuf.UInt64Value" do
      message =
        TestAllTypesProto3.new!(
          optional_uint64_wrapper: Google.Protobuf.UInt64Value.new!(value: 3)
        )

      assert encode(message) == %{"optionalUint64Wrapper" => 3}
    end
  end

  describe "Google.Protobuf.BytesValue" do
    test "encodes with base 64" do
      message =
        TestAllTypesProto3.new!(
          optional_bytes_wrapper: Google.Protobuf.BytesValue.new!(value: <<1, 2, 3>>)
        )

      assert encode(message) == %{"optionalBytesWrapper" => Base.url_encode64(<<1, 2, 3>>)}
    end
  end

  describe "Google.Protobuf.FieldMask" do
    test "encodes with base 64" do
      message =
        TestAllTypesProto3.new!(
          optional_field_mask: Google.Protobuf.FieldMask.new!(paths: ["foo_bar", "baz_bong"])
        )

      assert encode(message) == %{"optionalFieldMask" => "fooBar,bazBong"}
    end
  end

  describe "Google.Protobuf.Duration" do
    test "encodes as a string" do
      cases = [
        %{string: "123s", seconds: 123, nanos: 0},
        %{string: "123.001s", seconds: 123, nanos: 1_000_000},
        %{string: "0.000000001s", seconds: 0, nanos: 1},
        %{string: "-1s", seconds: -1, nanos: 0},
        %{string: "-1.100s", seconds: -1, nanos: -100_000_000}
      ]

      for %{string: expected_string, seconds: seconds, nanos: nanos} <- cases do
        message =
          TestAllTypesProto3.new!(
            optional_duration: Google.Protobuf.Duration.new!(seconds: seconds, nanos: nanos)
          )

        assert encode(message) == %{"optionalDuration" => expected_string}
      end
    end

    test "returns an error if the seconds of the duration are too big" do
      max_duration = 315_576_000_000

      message =
        TestAllTypesProto3.new!(
          optional_duration: Google.Protobuf.Duration.new!(seconds: max_duration + 1, nanos: 0)
        )

      assert catch_throw(encode(message)) ==
               {:bad_duration, :seconds_outside_of_range, max_duration + 1}
    end

    test "returns an error if the seconds of the duration are too small" do
      max_duration = 315_576_000_000

      message =
        TestAllTypesProto3.new!(
          optional_duration: Google.Protobuf.Duration.new!(seconds: -max_duration - 1, nanos: 0)
        )

      assert catch_throw(encode(message)) ==
               {:bad_duration, :seconds_outside_of_range, -max_duration - 1}
    end
  end

  describe "Google.Protobuf.Timestamp" do
    test "encodes the timestamp as a string" do
      {:ok, datetime, _offset = 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      unix_seconds = DateTime.to_unix(datetime, :second)

      timestamp = Google.Protobuf.Timestamp.new!(seconds: unix_seconds, nanos: 0)
      message = TestAllTypesProto3.new!(optional_timestamp: timestamp)

      assert encode(message) == %{"optionalTimestamp" => "2000-01-01T00:00:00Z"}
    end

    test "returns an error if the timestamp is outside of the allowed range" do
      {:ok, datetime, _offset = 0} = DateTime.from_iso8601("0000-01-01T00:00:00Z")
      unix_seconds = DateTime.to_unix(datetime, :second)

      timestamp = Google.Protobuf.Timestamp.new!(seconds: unix_seconds, nanos: 0)
      message = TestAllTypesProto3.new!(optional_timestamp: timestamp)

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
        value = Google.Protobuf.Value.new!(kind: kind)
        message = TestAllTypesProto3.new!(optional_value: value)
        assert encode(message) == %{"optionalValue" => json}
      end
    end
  end

  describe "Google.Protobuf.ListValue" do
    test "encodes correctly" do
      value = Google.Protobuf.ListValue.new!(values: [])
      message = TestAllTypesProto3.new!(repeated_list_value: [value])
      assert encode(message) == %{"repeatedListValue" => [[]]}
    end
  end

  describe "Google.Protobuf.Struct" do
    test "encodes correctly" do
      value = Google.Protobuf.Struct.new!(fields: %{"foo" => Google.Protobuf.Empty.new!([])})
      message = TestAllTypesProto3.new!(optional_struct: value)
      assert encode(message) == %{"optionalStruct" => %{"foo" => %{}}}
    end
  end
end
