defmodule Protobuf.PresenceTest do
  use ExUnit.Case, async: true

  alias Protobuf.Presence
  alias TestMsg.{Foo, Foo2, Proto3Optional, Oneof, OneofProto3, ContainsTransformModule}

  describe "field_presence/2 for proto3" do
    test "singular non-optional fields have implicit presence" do
      msg = %Foo{}
      assert Presence.field_presence(msg, :a) == :maybe
      assert Presence.field_presence(msg, :c) == :maybe
      assert Presence.field_presence(msg, :k) == :maybe

      msg = %Foo{a: 42, c: "hello", k: true, j: :A}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :c) == :present
      assert Presence.field_presence(msg, :k) == :present
      assert Presence.field_presence(msg, :j) == :present

      msg = %Foo{a: 0, c: "", k: false, j: :UNKNOWN}
      assert Presence.field_presence(msg, :a) == :maybe
      assert Presence.field_presence(msg, :c) == :maybe
      assert Presence.field_presence(msg, :k) == :maybe
      assert Presence.field_presence(msg, :j) == :maybe
    end

    test "optional fields have explicit presence" do
      msg = %Proto3Optional{}
      assert Presence.field_presence(msg, :a) == :not_present
      assert Presence.field_presence(msg, :c) == :not_present

      msg = %Proto3Optional{a: 50, c: "hello"}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :c) == :present

      msg = %Proto3Optional{a: 0, c: ""}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :c) == :present
    end

    test "oneof fields have explicit presence" do
      msg = %OneofProto3{}
      assert Presence.field_presence(msg, :a) == :not_present
      assert Presence.field_presence(msg, :b) == :not_present

      msg = %OneofProto3{first: {:a, 42}}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :b) == :not_present

      msg = %OneofProto3{first: {:a, 0}}
      assert Presence.field_presence(msg, :a) == :present

      msg = %OneofProto3{first: {:e, :UNKNOWN}}
      assert Presence.field_presence(msg, :e) == :present
    end
  end

  describe "field_presence/2 for proto2" do
    test "singular fields have explicit presence" do
      msg = %Foo2{}
      assert Presence.field_presence(msg, :a) == :not_present
      assert Presence.field_presence(msg, :c) == :not_present
      assert Presence.field_presence(msg, :k) == :not_present

      msg = %Foo2{a: 42, c: "hello", k: true, j: :A}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :c) == :present
      assert Presence.field_presence(msg, :k) == :present
      assert Presence.field_presence(msg, :j) == :present

      msg = %Foo2{a: 0, c: "", k: false, j: :UNKNOWN}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :c) == :present
      assert Presence.field_presence(msg, :k) == :present
      assert Presence.field_presence(msg, :j) == :present
    end

    test "singular fields with default have implicit presence" do
      msg = %Foo2{}
      assert Presence.field_presence(msg, :b) == :maybe

      msg = %Foo2{b: 5} # 5 is the default value for :b
      assert Presence.field_presence(msg, :b) == :maybe

      msg = %Foo2{b: 6}
      assert Presence.field_presence(msg, :b) == :present
    end

    test "oneof fields have explicit presence" do
      msg = %Oneof{}
      assert Presence.field_presence(msg, :a) == :not_present
      assert Presence.field_presence(msg, :b) == :not_present

      msg = %Oneof{first: {:a, 42}}
      assert Presence.field_presence(msg, :a) == :present
      assert Presence.field_presence(msg, :b) == :not_present

      # Even if the value is default, it is present
      msg = %Oneof{first: {:a, 0}}
      assert Presence.field_presence(msg, :a) == :present

      msg = %Oneof{first: {:e, :UNKNOWN}}
      assert Presence.field_presence(msg, :e) == :present
    end
  end

  describe "field_presence/2" do
    test "repeated fields have implicit presence" do
      msg = %Foo{g: []}
      assert Presence.field_presence(msg, :g) == :maybe

      msg = %Foo{g: [1, 2, 3]}
      assert Presence.field_presence(msg, :g) == :present
    end

    test "maps have implicit presence" do
      msg = %Foo{l: %{}}
      assert Presence.field_presence(msg, :l) == :maybe

      msg = %Foo{l: %{"key" => 123}}
      assert Presence.field_presence(msg, :l) == :present
    end

    # Transform module tests
    test "field_presence works with transform modules" do
      msg = %ContainsTransformModule{field: 42}
      assert Presence.field_presence(msg, :field) == :present
    end
  end
end
