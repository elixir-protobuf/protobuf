defmodule Protobuf.JSON.EncodeTest do
  use ExUnit.Case, async: true

  alias TestMsg.{Foo, Foo.Bar, Scalars, OneofProto3, Parent, Parent.Child}

  def encode(struct, opts \\ []) do
    Protobuf.JSON.Encode.encode(struct, opts)
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

  test "skips unset onef fields" do
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
    defmodule MapIntToInt do
      use Protobuf, map: true, syntax: :proto3

      field :key, 1, type: :int32
      field :value, 2, type: :int32
    end

    defmodule MapBoolToInt do
      use Protobuf, map: true, syntax: :proto3

      field :key, 1, type: :bool
      field :value, 2, type: :int32
    end

    defmodule Maps do
      use Protobuf, syntax: :proto3

      field :mapii, 1, type: MapIntToInt, map: true
      field :mapbi, 2, type: MapBoolToInt, map: true
    end

    mapii = %{-1 => -1, 0 => 0, 1 => 1, 0b11 => 3, 0xFF => 255}
    message = Maps.new!(mapii: mapii, mapbi: %{true => 1, false => 0})

    encoded = %{
      "mapii" => %{"-1" => -1, "0" => 0, "1" => 1, "3" => 3, "255" => 255},
      "mapbi" => %{"true" => 1, "false" => 0}
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
end
