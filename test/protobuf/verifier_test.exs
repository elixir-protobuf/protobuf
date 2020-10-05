defmodule Protobuf.VerifierTest do
  use ExUnit.Case, async: true

  alias Protobuf.Verifier

  def has_single_message_matching(errs, target_msg) when is_list(errs) do
    length(errs) == 1 and Enum.at(errs, 0) =~ target_msg
  end

  test "verifies int32s" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: 42))
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: nil))
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: -42))
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: 0))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(a: "candle"))
    assert has_single_message_matching(errs, ~s(invalid value for type int32))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(a: 111_111_111_111))
    assert has_single_message_matching(errs, ~s(invalid value for type int32))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(a: 3.14))
    assert has_single_message_matching(errs, ~s(invalid value for type int32))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(a: false))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(a: :enum_value))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(a: TestMsg.Foo))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(a: TestMsg.Foo.new()))
  end

  test "verifies repeated int32s" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(i: nil))
    assert :ok == Verifier.verify(TestMsg.Foo.new(i: []))
    assert :ok == Verifier.verify(TestMsg.Foo.new(i: [5]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(i: [5, 111_111_111_111]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(i: ["hey", 5]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(i: ["okay", 5, TestMsg.Foo.new()]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(i: 123))
  end

  # TestMsg.Scalars has a bunch of fields with the same name as their types
  test "verifies int64s" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(int64: -200))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(int64: 140))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(int64: 0))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(int64: 9_223_372_036_854_775_807))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(int64: nil))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(int64: :test))
    assert has_single_message_matching(errs, ~s(invalid value for type int64))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(int64: "broom"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(int64: TestMsg.Foo.Bar.new()))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(int64: ["chair"]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(int64: {:pillow}))
  end

  test "verifies uint32s" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(uint32: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(uint32: 4_294_967_295))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(uint32: 0))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(uint32: -11))
    assert has_single_message_matching(errs, ~s(invalid value for type uint32))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(uint32: 4_294_967_296))
    assert has_single_message_matching(errs, ~s(invalid value for type uint32))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(uint32: 0.5))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(uint32: "shoe"))
  end

  test "verifies uint64s" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(uint64: 11))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(uint64: -11))
    assert has_single_message_matching(errs, ~s(invalid value for type uint64))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(uint64: 1.5))
    assert has_single_message_matching(errs, ~s(invalid value for type uint64))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(uint64: :blah))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(uint64: "book"))
  end

  test "verifies floats and doubles" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(float: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(double: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(float: 11.333))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(double: 11.333))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(float: :infinity))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(double: :infinity))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(float: :negative_infinity))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(double: :negative_infinity))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(float: :nan))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(double: :nan))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(float: "rug"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(double: "table"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(float: true))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(double: false))
  end

  test "verifies other numeric types" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(sint32: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(sint64: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(fixed32: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(sfixed32: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(fixed64: 11))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(sfixed64: 11))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed32: -11))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed64: -11))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(sint32: 1.5))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(sint64: 1.5))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed32: 1.5))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed64: 1.5))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed32: 111_111_111_111))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(sint32: 111_111_111_111))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(sint32: "jack"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(sint64: :jill))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed32: <<117, 112>>))
    assert {:error, _errs} = Verifier.verify(TestMsg.Scalars.new(fixed64: %{"the" => "hill"}))
  end

  test "verifies bools" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(bool: true))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(bool: false))
    assert :ok == Verifier.verify(TestMsg.Scalars.new(bool: nil))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(bool: -11))
    assert has_single_message_matching(errs, ~s(invalid value for type bool))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(bool: "vase"))
    assert has_single_message_matching(errs, ~s(invalid value for type bool))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(bool: :yarrrr))
    assert has_single_message_matching(errs, ~s(invalid value for type bool))
  end

  test "verifies strings" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: 42, b: 100, c: "", d: 123.5))
    assert :ok == Verifier.verify(TestMsg.Foo.new(a: 42, b: 100, c: "str", d: 123.5))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(a: 42, b: 100, c: false, d: 123.5))
    assert has_single_message_matching(errs, ~s(invalid value for type string))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(a: 42, b: 100, c: 555, d: 123.5))
    assert has_single_message_matching(errs, ~s(invalid value for type string))
  end

  test "verifies bytes" do
    assert :ok == Verifier.verify(TestMsg.Scalars.new(bytes: "foo"))
    assert {:error, errs} = Verifier.verify(TestMsg.Scalars.new(bytes: 5.5))
    assert has_single_message_matching(errs, ~s(invalid value for type bytes))
  end

  test "verifies enums" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(j: 2))
    assert :ok == Verifier.verify(TestMsg.Foo.new(j: :A))
    assert :ok == Verifier.verify(TestMsg.Foo.new(j: :B))

    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(j: :HELLO))

    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )

    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(j: false))

    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )

    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(j: Non.Existent.Module))

    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )

    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(j: "test"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(j: 200))
  end

  test "verifies repeated enums" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: nil))
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: []))
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: [:A]))
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: [:B, :A, :UNKNOWN, :C]))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(o: [:B, :A, :banana, :C]))
    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(o: [:B, :A, :D, "lalaland"]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(o: [:B, :A, :D, 555, :E]))
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(o: :A))
    assert has_single_message_matching(
             errs,
             ~s(Got value for repeated or map field that wasn't a list, tuple, or map)
           )
  end

  test "verifies enum with lowercase atoms" do
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(a: :unknown))
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(a: :A))
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(a: :a))
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(b: :B))
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(b: :b))
    assert :ok == Verifier.verify(TestMsg.Atom.Bar2.new(a: nil, b: nil))
    assert {:error, errs} = Verifier.verify(TestMsg.Atom.Bar2.new(a: :abcdef))

    # This error message isn't ideal, but I'm not sure it's worth threading through the uncapitalized value
    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )

    assert {:error, errs} = Verifier.verify(TestMsg.Atom.Bar2.new(b: :abcdef))

    assert has_single_message_matching(
             errs,
             ~s(invalid value for enum Elixir.TestMsg.EnumFoo)
           )
  end

  test "verifies repeated enum fields" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: [:A, :B]))
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: []))
    assert :ok == Verifier.verify(TestMsg.Foo.new(o: nil))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(o: [:bob, :B]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(o: [:A, :bob]))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(o: [:bob, :bob]))
  end

  test "verifies map types" do
    assert :ok == Verifier.verify(TestMsg.Foo.new(l: %{"foo_key" => 213}))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(l: "boo"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(l: ["hoo"]))
    # the field "l" is a map from string to int32
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(l: %{"foo_key" => "blah"}))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(l: %{123 => "blah"}))
    assert {:error, _errs} = Verifier.verify(TestMsg.Foo.new(l: %{"foo_key" => 111_111_111_111}))
  end

  test "verifies oneof fields" do
    assert :ok ==
             Verifier.verify(
               TestMsg.Oneof.new(%{first: {:a, 42}, second: {:d, "abc"}, other: "other"})
             )

    assert :ok ==
             Verifier.verify(
               TestMsg.Oneof.new(%{first: {:b, "abc"}, second: {:c, 123}, other: "other"})
             )

    assert {:error, errs} =
             Verifier.verify(
               TestMsg.Oneof.new(%{first: "not-in-a-tuple", second: {:c, 123}, other: "other"})
             )

    assert has_single_message_matching(
             errs,
             "TestMsg.Oneof#first has the wrong structure: the value of a oneof field should be nil or {key, val} where key = atom of a field name inside the oneof and val = its value"
           )

    assert {:error, _errs} =
             Verifier.verify(
               TestMsg.Oneof.new(%{first: {:b, "abc"}, second: false, other: "other"})
             )
  end

  test "verifies map with oneof" do
    assert :ok ==
             Verifier.verify(
               Google.Protobuf.Struct.new(
                 fields: %{"valid" => Google.Protobuf.Value.new(kind: {:bool_value, true})}
               )
             )

    assert {:error, _errs} =
             Verifier.verify(
               Google.Protobuf.Struct.new(
                 fields: %{"valid" => Google.Protobuf.Value.new(kind: 555)}
               )
             )
  end

  test "supports map syntax for submessages" do
    assert :ok ==
             Verifier.verify(
               Google.Protobuf.Struct.new(fields: %{"valid" => %{kind: {:bool_value, true}}})
             )

    assert {:error, errs} =
             Verifier.verify(Google.Protobuf.Struct.new(fields: %{"valid" => %{kind: "foobar"}}))

    assert has_single_message_matching(errs, "value of a oneof field should be nil or {key, val}")
  end

  test "verifies submessages" do
    assert :ok ==
             Verifier.verify(TestMsg.Foo.new(a: 42, e: %TestMsg.Foo.Bar{a: 12, b: "abc"}, f: 13))

    assert {:error, errs} =
             Verifier.verify(
               TestMsg.Foo.new(a: 42, e: %TestMsg.Foo.Bar{a: true, b: "abc"}, f: 13)
             )

    assert has_single_message_matching(errs, ~s(invalid value for type int32))

    assert {:error, errs} =
             Verifier.verify(TestMsg.Foo.new(a: 42, e: %TestMsg.Foo.Bar{a: 12, b: 55.5}, f: 13))

    assert has_single_message_matching(errs, ~s(invalid value for type string))

    # wrong type of embedded message
    assert {:error, errs} = Verifier.verify(TestMsg.Foo.new(e: TestMsg.Foo2.new()))

    assert has_single_message_matching(
             errs,
             ~s(got Elixir.TestMsg.Foo2 but expected Elixir.TestMsg.Foo.Bar)
           )
  end

  test "verifies repeated submessages" do
    assert :ok ==
             Verifier.verify(
               TestMsg.Foo.new(h: [%TestMsg.Foo.Bar{a: 12, b: "abc"}, TestMsg.Foo.Bar.new(a: 13)])
             )

    assert :ok ==
             Verifier.verify(TestMsg.Foo.new(h: [TestMsg.Foo.Bar.new(), TestMsg.Foo.Bar.new()]))

    # wrong type of embedded message
    assert {:error, _errs} =
             Verifier.verify(TestMsg.Foo.new(h: [TestMsg.Foo2.new(), TestMsg.Foo.Bar.new()]))

    assert {:error, _errs} =
             Verifier.verify(TestMsg.Foo.new(h: [TestMsg.Foo.Bar.new(), TestMsg.Foo2.new()]))

    # wrong field inside one of the embedded messages
    assert {:error, _errs} =
             Verifier.verify(
               TestMsg.Foo.new(h: [TestMsg.Foo.Bar.new(a: "bob"), TestMsg.Foo.Bar.new()])
             )

    assert {:error, _errs} =
             Verifier.verify(
               TestMsg.Foo.new(h: [TestMsg.Foo.Bar.new(), TestMsg.Foo.Bar.new(b: 555)])
             )
  end

  test "verifies fields with extype annotation" do
    assert :ok == Verifier.verify(TestMsg.Ext.DualUseCase.new(a: "s1"))

    assert :ok ==
             Verifier.verify(
               TestMsg.Ext.DualUseCase.new(
                 a: "s1",
                 b: Google.Protobuf.StringValue.new(value: "s2")
               )
             )

    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.DualUseCase.new(a: false))
    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.DualUseCase.new(a: 123))

    # NOTE: maybe we can phase out the "When extype option is present, new
    # expects unwrapped value, not struct" warning now that we have new_and_verify!
    assert_raise RuntimeError, fn ->
      Verifier.verify(
        TestMsg.Ext.DualUseCase.new(a: Google.Protobuf.StringValue.new(value: "s1"))
      )
    end
  end

  test "verifies timestamp fields with extype option" do
    assert :ok == Verifier.verify(TestMsg.Ext.Timestamps.new(a: nil))
    assert :ok == Verifier.verify(TestMsg.Ext.Timestamps.new(b: nil))
    assert :ok == Verifier.verify(TestMsg.Ext.Timestamps.new(a: DateTime.utc_now()))
    assert :ok == Verifier.verify(TestMsg.Ext.Timestamps.new(b: NaiveDateTime.utc_now()))

    assert {:error, errs} =
             Verifier.verify(TestMsg.Ext.Timestamps.new(a: NaiveDateTime.utc_now()))

    assert has_single_message_matching(
             errs,
             "non-DateTime value for a timestamp field with extype DateTime.t()"
           )

    assert {:error, errs} = Verifier.verify(TestMsg.Ext.Timestamps.new(b: DateTime.utc_now()))

    assert has_single_message_matching(
             errs,
             "non-NaiveDateTime value for a timestamp field with extype NaiveDateTime.t()"
           )

    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.Timestamps.new(a: "lenny"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.Timestamps.new(b: "carl"))
    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.Timestamps.new(a: 123))
    assert {:error, _errs} = Verifier.verify(TestMsg.Ext.Timestamps.new(b: 321))
  end

  describe "new_and_verify!/1" do
    test "new_and_verify!/1 builds struct" do
      result = TestMsg.Foo.Bar.new_and_verify!(a: 20, b: "test")
      assert result.a == 20
      assert result.b == "test"
    end

    test "raises on invalid value" do
      assert_raise Protobuf.VerificationError, fn ->
        TestMsg.Foo.new_and_verify!(j: :invalid_value)
      end
    end
  end
end
