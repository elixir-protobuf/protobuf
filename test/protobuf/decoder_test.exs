defmodule Protobuf.DecoderTest do
  use ExUnit.Case, async: true

  alias Protobuf.Decoder

  test "decodes one simple field" do
    struct = Decoder.decode(<<8, 42>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42)
  end

  test "decodes full fields" do
    bin = <<8, 42, 17, 100, 0, 0, 0, 0, 0, 0, 0, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66>>
    struct = Decoder.decode(bin, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42, b: 100, c: "str", d: 123.5)
  end

  test "skips a known fields" do
    bin = <<8, 42, 26, 3, 115, 116, 114, 45, 0, 0, 247, 66>>
    struct = Decoder.decode(bin, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42, c: "str", d: 123.5)
  end

  test "raises for wrong wire type" do
    assert_raise(Protobuf.DecodeError, ~r{wrong wire_type for a: got 1, want 0}, fn ->
      Decoder.decode(<<9, 42, 0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo)
    end)
  end

  test "raises for bad binaries" do
    assert_raise(Protobuf.DecodeError, ~r{cannot decode binary data}, fn ->
      Decoder.decode(<<0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo)
    end)
  end

  test "skips unknown varint fields" do
    struct = Decoder.decode(<<8, 42, 32, 100, 45, 0, 0, 247, 66>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42, d: 123.5)
  end

  test "skips unknown string fields" do
    struct = Decoder.decode(<<8, 42, 45, 0, 0, 247, 66>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42, d: 123.5)
  end

  test "decodes embedded message" do
    struct = Decoder.decode(<<8, 42, 50, 7, 8, 12, 18, 3, 97, 98, 99, 56, 13>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 42, e: %TestMsg.Foo.Bar{a: 12, b: "abc"}, f: 13)
  end

  test "merges singular embedded messages for multiple fields" do
    # %{a: 12} + %{a: 21, b: "abc"}
    bin = <<50, 2, 8, 12, 50, 7, 8, 21, 18, 3, 97, 98, 99>>
    struct = Decoder.decode(bin, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(e: %TestMsg.Foo.Bar{a: 21, b: "abc"})
  end

  test "decodes repeated varint fields" do
    struct = Decoder.decode(<<64, 12, 8, 123, 64, 13, 64, 14>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(a: 123, g: [12, 13, 14])
  end

  test "decodes repeated embedded fields" do
    bin = <<74, 7, 8, 12, 18, 3, 97, 98, 99, 74, 2, 8, 13>>
    struct = Decoder.decode(bin, TestMsg.Foo)

    assert struct ==
             TestMsg.Foo.new(h: [%TestMsg.Foo.Bar{a: 12, b: "abc"}, TestMsg.Foo.Bar.new(a: 13)])
  end

  test "decodes packed fields" do
    struct = Decoder.decode(<<82, 2, 12, 13>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(i: [12, 13])
  end

  test "concat multiple packed fields" do
    struct = Decoder.decode(<<82, 2, 12, 13, 82, 2, 14, 15>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(i: [12, 13, 14, 15])
  end

  test "decodes enum type" do
    struct = Decoder.decode(<<88, 1>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(j: :A)

    struct = Decoder.decode(<<88, 2>>, TestMsg.Foo)
    assert struct == TestMsg.Foo.new(j: :B)
  end

  test "decodes unknown enum value" do
    assert ExUnit.CaptureLog.capture_log(fn ->
             struct = Decoder.decode(<<88, 3>>, TestMsg.Foo)
             assert struct == TestMsg.Foo.new(j: 3)
           end) =~ ~r/unknown enum value 3 when decoding for TestMsg\.EnumFoo/
  end

  test "decodes map type" do
    struct =
      Decoder.decode(
        <<106, 12, 10, 7, 102, 111, 111, 95, 107, 101, 121, 16, 213, 1>>,
        TestMsg.Foo
      )

    assert struct == TestMsg.Foo.new(l: %{"foo_key" => 213})
  end

  test "decodes 0 for proto2" do
    assert Decoder.decode(<<8, 0, 17, 5, 0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo2) ==
             TestMsg.Foo2.new(a: 0)
  end

  test "decodes [] for proto2" do
    assert Decoder.decode(<<8, 0, 17, 5, 0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo2) ==
             TestMsg.Foo2.new(a: 0, g: [])
  end

  test "decodes %{} for proto2" do
    assert Decoder.decode(<<8, 0, 17, 5, 0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo2) ==
             TestMsg.Foo2.new(a: 0, l: %{})
  end

  test "decodes custom default message for proto2" do
    assert Decoder.decode(<<8, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0>>, TestMsg.Foo2) ==
             TestMsg.Foo2.new(a: 0, b: 0)

    assert Decoder.decode(<<8, 0>>, TestMsg.Foo2) == TestMsg.Foo2.new(a: 0, b: 5)
  end

  test "oneof only sets oneof fields" do
    assert Decoder.decode(
             <<42, 5, 111, 116, 104, 101, 114, 8, 42, 34, 3, 97, 98, 99>>,
             TestMsg.Oneof
           ) == %TestMsg.Oneof{first: {:a, 42}, second: {:d, "abc"}, other: "other"}

    assert Decoder.decode(
             <<42, 5, 111, 116, 104, 101, 114, 18, 3, 97, 98, 99, 24, 123>>,
             TestMsg.Oneof
           ) == %TestMsg.Oneof{first: {:b, "abc"}, second: {:c, 123}, other: "other"}
  end

  test "oneof only sets oneof fields for zero values" do
    assert Decoder.decode(<<8, 0, 34, 0>>, TestMsg.Oneof) ==
             TestMsg.Oneof.new(first: {:a, 0}, second: {:d, ""})

    assert Decoder.decode(<<18, 0, 24, 0>>, TestMsg.Oneof) ==
             TestMsg.Oneof.new(first: {:b, ""}, second: {:c, 0})
  end

  describe "groups" do
    test "skips all groups and their fields" do
      a = <<8, 42>>
      b = <<17, 100, 0, 0, 0, 0, 0, 0, 0>>
      c = <<26, 3, 115, 116, 114>>
      d = <<45, 0, 0, 247, 66>>
      # field number 2, wire type 3
      group_start = <<19>>
      # field number 2, wire type 4
      group_end = <<20>>
      # field number 5, wire type 0, value 42
      skipped = <<40, 42>>
      group = group_start <> skipped <> group_end

      bin = a <> b <> group <> group <> c <> d
      struct = Decoder.decode(bin, TestMsg.Foo)
      assert struct == TestMsg.Foo.new(a: 42, b: 100, c: "str", d: 123.5)
    end

    test "skips repeated and nested groups" do
      # field number 1, wire type 3
      group1_start = <<11>>
      # field number 1, wire type 4
      group1_end = <<12>>

      bin = group1_start <> group1_start <> group1_end <> group1_end
      struct = Decoder.decode(bin, TestMsg.Foo)
      assert struct == TestMsg.Foo.new()

      a = <<8, 42>>
      b = <<17, 100, 0, 0, 0, 0, 0, 0, 0>>
      skipped = <<40, 42>>
      # field number 2, wire type 3
      group2_start = <<19>>
      # field number 2, wire type 4
      group2_end = <<20>>
      group2 = group2_start <> skipped <> group2_end
      group1 = group1_start <> skipped <> group2 <> group2 <> group1_end

      bin = a <> group1 <> group1 <> b
      struct = Decoder.decode(bin, TestMsg.Foo)
      assert struct == TestMsg.Foo.new(a: 42, b: 100)
    end

    test "raises when closing a group before opening" do
      assert_raise Protobuf.DecodeError, "closing group 2 but no groups are open", fn ->
        Decoder.decode(<<20>>, TestMsg.Foo)
      end
    end

    test "raises when opening one group and trying to close another" do
      assert_raise Protobuf.DecodeError, "closing group 2 but group 3 is open", fn ->
        Decoder.decode(<<27, 20>>, TestMsg.Foo)
      end
    end

    test "raises when finishes with a group still open" do
      assert_raise Protobuf.DecodeError, "cannot decode binary data", fn ->
        Decoder.decode(<<19>>, TestMsg.Foo)
      end
    end
  end
end
