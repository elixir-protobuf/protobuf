defmodule Protobuf.DSL.EncoderTest do
  use ExUnit.Case, async: true

  alias TestMsg.{
    EnumRepeatedUnpacked,
    Ext,
    FloatZeroDefault,
    Foo,
    Foo2,
    Link,
    MapFoo,
    Maps,
    Oneof,
    OneofProto3,
    Proto3Optional,
    Scalars,
    WithTransformModule
  }

  # Encoding of every field kind is covered by Protobuf.EncoderTest. What is
  # specific to the generated encoders is the {iodata, byte_size} pair they
  # return: parents write their length prefix from that size instead of walking
  # the iodata again, so a size that disagrees with the iodata would silently
  # corrupt every enclosing message.
  describe "__encode_sized__/1" do
    test "returns the encoded message together with its byte size" do
      for message <- sample_messages() do
        %module{} = message

        assert {iodata, size} = module.__encode_sized__(message)
        assert size == IO.iodata_length(iodata), "wrong size for #{inspect(message)}"
        assert IO.iodata_to_binary(iodata) == Protobuf.encode(message)
      end
    end

    # A repeated field is absent only when it is empty: presence is never checked
    # per element, so a zero enum value inside the list stays on the wire.
    test "keeps the zero value of an element of an unpacked repeated enum" do
      assert {iodata, size} =
               EnumRepeatedUnpacked.__encode_sized__(%EnumRepeatedUnpacked{a: [:UNKNOWN, :A]})

      assert IO.iodata_to_binary(iodata) == <<8, 0, 8, 1>>
      assert size == IO.iodata_length(iodata)
    end

    test "encodes a message with a transform module from its transformed value" do
      assert {iodata, size} = WithTransformModule.__encode_sized__(42)
      assert size == IO.iodata_length(iodata)
      assert IO.iodata_to_binary(iodata) == <<8, 42>>
    end

    # The generated struct clause can't match a struct-tagged map with missing
    # keys, so it must fall back to the interpreter (which reads fields with
    # Map.get/3) instead of bouncing between the two encoders forever.
    test "encodes a struct with missing keys like the interpreter does" do
      malformed = Map.delete(%Foo{a: 42}, :c)

      assert Protobuf.encode(malformed) == Protobuf.encode(%Foo{a: 42})
    end

    test "skips a proto2 float field holding its declared 0.0 default" do
      assert Protobuf.encode(%FloatZeroDefault{a: 0.0}) == <<>>
      assert Protobuf.encode(%FloatZeroDefault{a: 1.0}) == <<9, 0, 0, 0, 0, 0, 0, 240, 63>>
    end
  end

  describe "__encode_entry_sized__/2" do
    test "encodes a map entry exactly like the entry message itself" do
      for {key, value} <- [{"", 0}, {"key", 1}, {"key", -1}] do
        assert {iodata, size} = MapFoo.__encode_entry_sized__(key, value)
        assert size == IO.iodata_length(iodata)
        assert IO.iodata_to_binary(iodata) == Protobuf.encode(%MapFoo{key: key, value: value})
      end
    end
  end

  defp sample_messages do
    [
      %Foo{},
      %Foo{a: 0, c: "", k: false, n: 0.0, j: :UNKNOWN},
      %Foo{
        a: -1,
        b: 1234,
        c: "foo",
        d: 1.5,
        e: %Foo.Bar{a: 1, b: "bar"},
        g: [1, 2, 3],
        h: [%Foo.Bar{}, %Foo.Bar{a: 2}],
        i: [4, 5],
        j: :A,
        k: true,
        l: %{"a" => 1, "b" => 0},
        o: [:A, :B],
        p: "deprecated"
      },
      %Foo2{a: 0},
      %Foo2{a: 1, b: 5, c: "", e: %Foo.Bar{}, g: [0], i: [1, 2], l: %{}},
      %Scalars{},
      %Scalars{
        string: "s",
        bool: true,
        float: -0.0,
        double: 0.5,
        int32: -1,
        uint32: 1,
        sint32: -1,
        fixed32: 1,
        sfixed32: -1,
        int64: -1,
        uint64: 1,
        sint64: -1,
        fixed64: 1,
        sfixed64: -1,
        bytes: <<0, 1>>,
        repeated_string: ["a", ""],
        repeated_bool: [true, false],
        repeated_int32: [0, -1]
      },
      %Maps{mapii: %{1 => 0}, mapbi: %{false => 1}, mapsi: %{"" => 0}},
      %Oneof{first: {:a, 0}, second: {:d, ""}},
      %Oneof{first: {:e, :UNKNOWN}, other: "other"},
      %OneofProto3{first: {:b, ""}, second: {:c, 0}},
      %Proto3Optional{a: 0, b: "", c: :UNKNOWN},
      %Link{value: 1, child: %Link{child: %Link{value: 2}}},
      %Foo{__unknown_fields__: [{3, 2, "unknown"}]},
      Ext.Foo1.put_extension(%Ext.Foo1{fa: 1}, Ext.PbExtension, :foo2, [1, 2])
    ]
  end
end
