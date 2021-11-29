defmodule Protobuf.JSON.DecodeTest do
  use ExUnit.Case, async: true

  alias ProtobufTestMessages.Proto3.TestAllTypesProto3
  alias TestMsg.{Foo, Foo.Bar, Maps, OneofProto3, Parent, Parent.Child, Scalars}

  def decode(data, module) do
    Protobuf.JSON.from_decoded(data, module)
  end

  def error(msg) do
    {:error, %Protobuf.JSON.DecodeError{message: msg}}
  end

  describe "strings" do
    test "utf-8 is valid" do
      data = %{"string" => "エリクサー"}
      decoded = Scalars.new!(string: "エリクサー")
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "integer is invalid" do
      data = %{"string" => 123}
      msg = "Field 'string' has an invalid string (123)"
      assert decode(data, Scalars) == error(msg)
    end

    test "15-bit bitstring is invalid" do
      data = %{"string" => <<1::15>>}
      msg = "Field 'string' has an invalid string (<<0, 1::size(7)>>)"
      assert decode(data, Scalars) == error(msg)
    end
  end

  describe "booleans" do
    test "actual boolean is valid" do
      data = %{"bool" => true}
      decoded = Scalars.new!(bool: true)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "string is invalid" do
      data = %{"bool" => "true"}
      msg = "Field 'bool' has an invalid boolean (\"true\")"
      assert decode(data, Scalars) == error(msg)
    end

    test "number is invalid" do
      data = %{"bool" => 1}
      msg = "Field 'bool' has an invalid boolean (1)"
      assert decode(data, Scalars) == error(msg)
    end
  end

  describe "integers" do
    test "integer value is valid" do
      data = %{"int32" => 999}
      decoded = Scalars.new!(int32: 999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sint32" => 999}
      decoded = Scalars.new!(sint32: 999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"fixed64" => 999}
      decoded = Scalars.new!(fixed64: 999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sfixed64" => 999}
      decoded = Scalars.new!(sfixed64: 999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"int32" => -999}
      decoded = Scalars.new!(int32: -999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sint32" => -999}
      decoded = Scalars.new!(sint32: -999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"fixed64" => -999}
      decoded = Scalars.new!(fixed64: -999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sfixed64" => -999}
      decoded = Scalars.new!(sfixed64: -999)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "string value is valid" do
      data = %{"fixed32" => "999"}
      decoded = Scalars.new!(fixed32: 999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sfixed32" => "-999"}
      decoded = Scalars.new!(sfixed32: -999)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"int64" => "\u0031\u0032"}
      decoded = Scalars.new!(int64: 12)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"sint64" => "\u0031\u0032"}
      decoded = Scalars.new!(sint64: 12)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "string value with extra characters is invalid" do
      data = %{"uint32" => "999 "}
      msg = "Field 'uint32' has an invalid integer (\"999 \")"
      assert decode(data, Scalars) == error(msg)

      data = %{"uint64" => "999aaa"}
      msg = "Field 'uint64' has an invalid integer (\"999aaa\")"
      assert decode(data, Scalars) == error(msg)
    end

    test "float value is invalid" do
      data = %{"int32" => 9.99}
      msg = "Field 'int32' has an invalid integer (9.99)"
      assert decode(data, Scalars) == error(msg)
    end

    test "values outside upper and lower limits are invalid" do
      msg = "Field 'int32' has an invalid integer (2147483648)"
      assert decode(%{"int32" => 2_147_483_648}, Scalars) == error(msg)

      msg = "Field 'sint32' has an invalid integer (2147483648)"
      assert decode(%{"sint32" => 2_147_483_648}, Scalars) == error(msg)

      msg = "Field 'fixed32' has an invalid integer (2147483648)"
      assert decode(%{"fixed32" => 2_147_483_648}, Scalars) == error(msg)

      msg = "Field 'sfixed32' has an invalid integer (2147483648)"
      assert decode(%{"sfixed32" => 2_147_483_648}, Scalars) == error(msg)

      msg = "Field 'uint32' has an invalid integer (4294967296)"
      assert decode(%{"uint32" => 4_294_967_296}, Scalars) == error(msg)

      msg = "Field 'int32' has an invalid integer (-2147483649)"
      assert decode(%{"int32" => -2_147_483_649}, Scalars) == error(msg)

      msg = "Field 'sint32' has an invalid integer (-2147483649)"
      assert decode(%{"sint32" => -2_147_483_649}, Scalars) == error(msg)

      msg = "Field 'fixed32' has an invalid integer (-2147483649)"
      assert decode(%{"fixed32" => -2_147_483_649}, Scalars) == error(msg)

      msg = "Field 'sfixed32' has an invalid integer (-2147483649)"
      assert decode(%{"sfixed32" => -2_147_483_649}, Scalars) == error(msg)

      msg = "Field 'uint32' has an invalid integer (-1)"
      assert decode(%{"uint32" => -1}, Scalars) == error(msg)

      msg = "Field 'int64' has an invalid integer (9223372036854775808)"
      assert decode(%{"int64" => 9_223_372_036_854_775_808}, Scalars) == error(msg)

      msg = "Field 'sint64' has an invalid integer (9223372036854775808)"
      assert decode(%{"sint64" => 9_223_372_036_854_775_808}, Scalars) == error(msg)

      msg = "Field 'fixed64' has an invalid integer (9223372036854775808)"
      assert decode(%{"fixed64" => 9_223_372_036_854_775_808}, Scalars) == error(msg)

      msg = "Field 'sfixed64' has an invalid integer (9223372036854775808)"
      assert decode(%{"sfixed64" => 9_223_372_036_854_775_808}, Scalars) == error(msg)

      msg = "Field 'uint64' has an invalid integer (18446744073709551616)"
      assert decode(%{"uint64" => 18_446_744_073_709_551_616}, Scalars) == error(msg)

      msg = "Field 'int64' has an invalid integer (-9223372036854775809)"
      assert decode(%{"int64" => -9_223_372_036_854_775_809}, Scalars) == error(msg)

      msg = "Field 'sint64' has an invalid integer (-9223372036854775809)"
      assert decode(%{"sint64" => -9_223_372_036_854_775_809}, Scalars) == error(msg)

      msg = "Field 'fixed64' has an invalid integer (-9223372036854775809)"
      assert decode(%{"fixed64" => -9_223_372_036_854_775_809}, Scalars) == error(msg)

      msg = "Field 'sfixed64' has an invalid integer (-9223372036854775809)"
      assert decode(%{"sfixed64" => -9_223_372_036_854_775_809}, Scalars) == error(msg)

      msg = "Field 'uint64' has an invalid integer (-1)"
      assert decode(%{"uint64" => -1}, Scalars) == error(msg)
    end

    test "values in E notation are valid" do
      int_types = [
        :int32,
        :sint32,
        :fixed32,
        :sfixed32,
        :uint32,
        :int32,
        :sint32,
        :fixed32,
        :sfixed32,
        :uint32,
        :int64,
        :sint64,
        :fixed64,
        :sfixed64,
        :uint64,
        :int64,
        :sint64,
        :fixed64,
        :sfixed64,
        :uint64
      ]

      for int_type <- int_types do
        decoded = Scalars.new!([{int_type, 100_000}])
        assert decode(%{Atom.to_string(int_type) => 1.0e5}, Scalars) == {:ok, decoded}
      end
    end
  end

  describe "floating point" do
    test "float value is valid" do
      data = %{"float" => 1.234, "double" => 5.6789}
      decoded = Scalars.new!(float: 1.234, double: 5.6789)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => -1.234, "double" => -5.6789}
      decoded = Scalars.new!(float: -1.234, double: -5.6789)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => 1.23e3, "double" => 1.23e-2}
      decoded = Scalars.new!(float: 1230.0, double: 0.0123)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "constants are valid" do
      data = %{"float" => "NaN", "double" => "NaN"}
      decoded = Scalars.new!(float: :nan, double: :nan)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => "Infinity", "double" => "Infinity"}
      decoded = Scalars.new!(float: :infinity, double: :infinity)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => "-Infinity", "double" => "-Infinity"}
      decoded = Scalars.new!(float: :negative_infinity, double: :negative_infinity)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "string value is valid" do
      data = %{"float" => "1.234", "double" => "5.6789"}
      decoded = Scalars.new!(float: 1.234, double: 5.6789)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => "-1.234", "double" => "-5.6789"}
      decoded = Scalars.new!(float: -1.234, double: -5.6789)
      assert decode(data, Scalars) == {:ok, decoded}

      data = %{"float" => "1.23e3", "double" => "1.23e-2"}
      decoded = Scalars.new!(float: 1230.0, double: 0.0123)
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "string value with extra characters is invalid" do
      data = %{"float" => "1.234 "}
      msg = "Field 'float' has an invalid floating point (\"1.234 \")"
      assert decode(data, Scalars) == error(msg)

      data = %{"double" => "5.6789a"}
      msg = "Field 'double' has an invalid floating point (\"5.6789a\")"
      assert decode(data, Scalars) == error(msg)
    end

    test "other types are invalid" do
      data = %{"float" => 5}
      msg = "Field 'float' has an invalid floating point (5)"
      assert decode(data, Scalars) == error(msg)

      data = %{"double" => true}
      msg = "Field 'double' has an invalid floating point (true)"
      assert decode(data, Scalars) == error(msg)
    end

    # Can't really test out of bound doubles since they're out of bound for Erlang too :).
    test "values outside upper and lower limits are invalid" do
      data = %{"float" => 1.0e39}

      assert decode(data, Scalars) ==
               error("Field 'float' has an invalid floating point (1.0e39)")
    end
  end

  describe "bytes" do
    test "Base64 encoded string with padding is valid" do
      data = %{"bytes" => "dGhpcyB3b3Jrcw=="}
      decoded = Scalars.new!(bytes: "this works")
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "Base64 encoded string without padding is valid" do
      data = %{"bytes" => "dGhpcyB3b3Jrcw"}
      decoded = Scalars.new!(bytes: "this works")
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "Base64 URL-encoded string with padding is valid" do
      data = %{"bytes" => "cGx1cyBzaWduICsgc2xhc2ggLw=="}
      decoded = Scalars.new!(bytes: "plus sign + slash /")
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "Base64 URL-encoded string without padding is valid" do
      data = %{"bytes" => "cGx1cyBzaWduICsgc2xhc2ggLw"}
      decoded = Scalars.new!(bytes: "plus sign + slash /")
      assert decode(data, Scalars) == {:ok, decoded}
    end

    test "corrupt Base64 encoded string is invalid" do
      data = %{"bytes" => "dGhpcyB3b3Jrc"}
      msg = "Field 'bytes' has an invalid Base64-encoded byte sequence"
      assert decode(data, Scalars) == error(msg)
    end

    test "other types are invalid" do
      data = %{"bytes" => 5}
      msg = "Field 'bytes' has an invalid Base64-encoded byte sequence"
      assert decode(data, Scalars) == error(msg)

      data = %{"bytes" => <<3::7>>}
      msg = "Field 'bytes' has an invalid Base64-encoded byte sequence"
      assert decode(data, Scalars) == error(msg)
    end
  end

  describe "enums" do
    test "known integer value is valid" do
      data = %{"j" => 4}
      decoded = Foo.new!(j: :C)
      assert decode(data, Foo) == {:ok, decoded}
    end

    test "known string value is valid" do
      data = %{"j" => "C"}
      decoded = Foo.new!(j: :C)
      assert decode(data, Foo) == {:ok, decoded}
    end

    test "unknown integer value is valid" do
      data = %{"j" => 999}
      decoded = Foo.new!(j: 999)
      assert decode(data, Foo) == {:ok, decoded}
    end

    test "integer value out of the 32-bit range is invalid" do
      data = %{"j" => 2_147_483_648}
      msg = "Field 'j' has an invalid enum value (2147483648)"
      assert decode(data, Foo) == error(msg)

      data = %{"j" => -2_147_483_649}
      msg = "Field 'j' has an invalid enum value (-2147483649)"
      assert decode(data, Foo) == error(msg)
    end

    test "unknown string value is invalid" do
      data = %{"j" => "INVALID"}
      msg = "Field 'j' has an invalid enum value (\"INVALID\")"
      assert decode(data, Foo) == error(msg)

      data = %{"j" => "1"}
      msg = "Field 'j' has an invalid enum value (\"1\")"
      assert decode(data, Foo) == error(msg)
    end

    test "types other than string and integer are invalid" do
      data = %{"j" => true}
      msg = "Field 'j' has an invalid enum value (true)"
      assert decode(data, Foo) == error(msg)

      data = %{"j" => 4.2}
      msg = "Field 'j' has an invalid enum value (4.2)"
      assert decode(data, Foo) == error(msg)
    end
  end

  describe "maps" do
    test "matching key and value types are valid" do
      data = %{
        "mapii" => %{"-1" => -1, "0" => 0, "1" => 1, "999999999" => 999_999_999},
        "mapbi" => %{"true" => 1, "false" => 0},
        "mapsi" => %{"" => 0, "三" => 3, "meaning" => 42}
      }

      mapii = %{-1 => -1, 0 => 0, 1 => 1, 999_999_999 => 999_999_999}
      mapbi = %{true => 1, false => 0}
      mapsi = %{"" => 0, "三" => 3, "meaning" => 42}
      decoded = Maps.new!(mapii: mapii, mapbi: mapbi, mapsi: mapsi)

      assert decode(data, Maps) == {:ok, decoded}
    end

    test "incompatible key type is invalid" do
      data = %{"mapii" => %{"not a number" => 1}}
      msg = "Field 'mapii' has an invalid map key (int32: \"not a number\")"
      assert decode(data, Maps) == error(msg)

      data = %{"mapbi" => %{"not a bool" => 1}}
      msg = "Field 'mapbi' has an invalid map key (bool: \"not a bool\")"
      assert decode(data, Maps) == error(msg)
    end

    test "non-string key is invalid" do
      data = %{"mapii" => %{1 => 1}}
      msg = "Field 'mapii' has an invalid map key (int32: 1)"
      assert decode(data, Maps) == error(msg)

      data = %{"mapbi" => %{true => 1}}
      msg = "Field 'mapbi' has an invalid map key (bool: true)"
      assert decode(data, Maps) == error(msg)

      data = %{"mapsi" => %{'chars' => 1}}
      msg = "Field 'mapsi' has an invalid map key (string: 'chars')"
      assert decode(data, Maps) == error(msg)
    end

    test "non-map is invalid" do
      data = %{"mapii" => "not a map"}
      msg = "Field 'mapii' has an invalid map (\"not a map\")"
      assert decode(data, Maps) == error(msg)
    end

    test "null value is invalid" do
      data = %{"mapsi" => %{"null integer" => nil}}
      msg = "Field 'value' has an invalid integer (nil)"
      assert decode(data, Maps) == error(msg)
    end

    test "mismatching value types are invalid" do
      data = %{"mapsi" => %{"valid" => 1, "invalid" => %{}}}
      msg = "Field 'value' has an invalid integer (%{})"
      assert decode(data, Maps) == error(msg)

      data = %{"mapsi" => %{"valid" => 1, "invalid" => []}}
      msg = "Field 'value' has an invalid integer ([])"
      assert decode(data, Maps) == error(msg)
    end

    # TODO: Jason ignores duplicates https://github.com/michalmuskala/jason/issues/33
    @tag :skip
    test "duplicated keys are invalid"
  end

  describe "embedded" do
    test "decodes embedded messages" do
      data = %{"e" => %{"a" => 12, "b" => "abc"}, "f" => 2}
      decoded = Foo.new!(e: Bar.new!(a: 12, b: "abc"), f: 2)
      assert decode(data, Foo) == {:ok, decoded}
    end

    test "empty map is valid" do
      assert decode(%{}, Parent) == {:ok, Parent.new()}

      data = %{"child" => %{"parent" => %{}}}
      decoded = Parent.new!(child: Child.new!(parent: Parent.new()))
      assert decode(data, Parent) == {:ok, decoded}
    end

    test "null value is ignored" do
      data = %{"child" => nil}
      decoded = Parent.new()
      assert decode(data, Parent) == {:ok, decoded}
    end

    test "other types are invalid" do
      data = %{"child" => "invalid"}
      msg = "JSON map expected for module TestMsg.Parent.Child, got: \"invalid\""
      assert decode(data, Parent) == error(msg)

      data = %{"child" => 2}
      msg = "JSON map expected for module TestMsg.Parent.Child, got: 2"
      assert decode(data, Parent) == error(msg)

      data = %{"child" => true}
      msg = "JSON map expected for module TestMsg.Parent.Child, got: true"
      assert decode(data, Parent) == error(msg)

      data = %{"child" => []}
      msg = "JSON map expected for module TestMsg.Parent.Child, got: []"
      assert decode(data, Parent) == error(msg)
    end
  end

  describe "oneofs" do
    test "decodes oneof fields" do
      data = %{"a" => 1, "d" => "d", "other" => "other"}
      decoded = OneofProto3.new!(first: {:a, 1}, second: {:d, "d"}, other: "other")
      assert decode(data, OneofProto3) == {:ok, decoded}
    end

    test "unset" do
      data = %{}
      decoded = OneofProto3.new()
      assert decode(data, OneofProto3) == {:ok, decoded}
    end

    test "set to default value" do
      data = %{"a" => 0, "d" => ""}
      decoded = OneofProto3.new(first: {:a, 0}, second: {:d, ""})
      assert decode(data, OneofProto3) == {:ok, decoded}

      defmodule BooleanOneof do
        use Protobuf, syntax: :proto3
        oneof :zero, 0
        field :bool, 1, type: :bool, oneof: 0
      end

      data = %{"bool" => false}
      decoded = BooleanOneof.new(zero: {:bool, false})
      assert decode(data, BooleanOneof) == {:ok, decoded}
    end

    test "multiple non-null fields set in a single oneof is invalid" do
      data = %{"a" => 0, "b" => ""}
      msg = "Oneof field 'first' cannot be set twice"
      assert decode(data, OneofProto3) == error(msg)
    end

    test "multiple fields set in a single oneof, one being non-null, is valid" do
      data = %{"a" => 42, "b" => nil}
      decoded = OneofProto3.new(first: {:a, 42})
      assert decode(data, OneofProto3) == {:ok, decoded}

      data = %{"a" => nil, "b" => "valid"}
      decoded = OneofProto3.new(first: {:b, "valid"})
      assert decode(data, OneofProto3) == {:ok, decoded}
    end
  end

  describe "repeated" do
    test "decodes repeated" do
      data = %{
        "g" => [1, "2"],
        "h" => [%{"a" => 1}, %{"b" => "b"}],
        "o" => ["UNKNOWN", 1, "B", 999]
      }

      decoded =
        Foo.new!(g: [1, 2], h: [Bar.new(a: 1), Bar.new(b: "b")], o: [:UNKNOWN, :A, :B, 999])

      assert decode(data, Foo) == {:ok, decoded}
    end

    test "detects invalid values inside list" do
      data = %{"o" => [0, 1, "BAD_ENUM"]}
      msg = "Field 'o' has an invalid enum value (\"BAD_ENUM\")"
      assert decode(data, Foo) == error(msg)

      data = %{"g" => [0, 1, "A"]}
      msg = "Field 'g' has an invalid integer (\"A\")"
      assert decode(data, Foo) == error(msg)

      data = %{"h" => [%{}, "not an embed"]}
      msg = "JSON map expected for module TestMsg.Foo.Bar, got: \"not an embed\""
      assert decode(data, Foo) == error(msg)
    end

    test "non-list values are invalid" do
      data = %{"g" => "not a list"}
      msg = "Repeated field 'g' expected a list, got \"not a list\""
      assert decode(data, Foo) == error(msg)
    end
  end

  test "unknown fields are ignored" do
    data = %{"a" => 1, "unknown" => 2, false => true, "e" => %{"a" => 2, 3 => 4}}
    decoded = Foo.new!(a: 1, e: Bar.new!(a: 2))
    assert decode(data, Foo) == {:ok, decoded}
  end

  test "null values are treated as default" do
    data = %{
      "a" => nil,
      "b" => nil,
      "c" => nil,
      "d" => nil,
      "e" => %{"a" => nil, "b" => nil},
      "f" => nil,
      "g" => nil,
      "h" => nil,
      "i" => nil,
      "j" => nil,
      "k" => nil,
      "l" => nil,
      "m" => nil,
      "n" => nil,
      "non_matched" => nil,
      "o" => nil,
      "p" => nil
    }

    assert decode(data, Foo) == {:ok, Foo.new(e: Bar.new())}
  end

  test "recognizes default values" do
    data = %{
      "a" => 0,
      "b" => "0",
      "c" => "",
      "d" => 0.0,
      "e" => %{"a" => 0, "b" => ""},
      "f" => 0,
      "g" => [],
      "h" => [],
      "i" => [],
      "j" => "UNKNOWN",
      "k" => false,
      "l" => %{},
      "m" => "UNKNOWN",
      "n" => 0.0,
      "non_matched" => "",
      "o" => [],
      "p" => ""
    }

    assert decode(data, Foo) == {:ok, Foo.new(e: Bar.new())}
  end

  describe "Google types" do
    test "Google.Protobuf.BoolValue" do
      data = %{
        "optionalBoolWrapper" => true
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_bool_wrapper: Google.Protobuf.BoolValue.new!(value: true)
                )}
    end

    test "Google.Protobuf.Int32Value" do
      data = %{
        "optionalInt32Wrapper" => 100
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_int32_wrapper: Google.Protobuf.Int32Value.new!(value: 100)
                )}
    end

    test "Google.Protobuf.UInt32Value" do
      data = %{
        "optionalUint32Wrapper" => 100
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_uint32_wrapper: Google.Protobuf.UInt32Value.new!(value: 100)
                )}
    end

    test "Google.Protobuf.Int64Value" do
      data = %{
        "optionalInt64Wrapper" => 100
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_int64_wrapper: Google.Protobuf.Int64Value.new!(value: 100)
                )}
    end

    test "Google.Protobuf.UInt64Value" do
      data = %{
        "optionalUint64Wrapper" => 100
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_uint64_wrapper: Google.Protobuf.UInt64Value.new!(value: 100)
                )}
    end

    test "Google.Protobuf.StringValue" do
      data = %{
        "optionalStringWrapper" => "my string"
      }

      assert decode(data, TestAllTypesProto3) ==
               {:ok,
                TestAllTypesProto3.new(
                  optional_string_wrapper: Google.Protobuf.UInt64Value.new!(value: "my string")
                )}
    end

    test "Google.Protobuf.Duration" do
      cases = [
        %{string: "123s", seconds: 123, nanos: 0},
        %{string: "123.001s", seconds: 123, nanos: 1_000_000},
        %{string: "123.000s", seconds: 123, nanos: 0},
        %{string: "0.000000001s", seconds: 0, nanos: 1},
        %{string: "-1s", seconds: -1, nanos: 0},
        %{string: "-1.1s", seconds: -1, nanos: -100_000_000}
      ]

      for %{string: string, seconds: expected_seconds, nanos: expected_nanos} <- cases do
        data = %{"optionalDuration" => string}

        expected_duration =
          TestAllTypesProto3.new(
            optional_duration:
              Google.Protobuf.Duration.new!(seconds: expected_seconds, nanos: expected_nanos)
          )

        assert decode(data, TestAllTypesProto3) == {:ok, expected_duration}
      end

      # Errors

      max_duration = 315_576_000_000

      data = %{"optionalDuration" => "#{max_duration + 1}s"}

      assert decode(data, TestAllTypesProto3) ==
               error("bad JSON value for duration \"315576000001s\", got: {315576000001, \"s\"}")

      data = %{"optionalDuration" => "#{-max_duration - 1}s"}

      assert decode(data, TestAllTypesProto3) ==
               error(
                 "bad JSON value for duration \"-315576000001s\", got: {-315576000001, \"s\"}"
               )
    end

    test "Google.Protobuf.Timestamp" do
      # Errors

      data = %{"optionalTimestamp" => "0000-01-01T00:00:00Z"}

      assert decode(data, TestAllTypesProto3) ==
               error(
                 "bad JSON value for timestamp \"0000-01-01T00:00:00Z\", failed to parse: \"timestamp is outside of allowed range\""
               )
    end
  end
end
