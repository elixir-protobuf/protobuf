Code.require_file("../support/test_msg.ex", __DIR__)
defmodule Protobuf.DSLTest do
  use ExUnit.Case, async: true

  alias Protobuf.FieldProps

  test "decode/2 supports false :use_default" do
    struct = TestMsg.Foo.decode(<<8, 42>>, use_default: false)
    assert struct == %TestMsg.Foo{a: 42}
  end

  test "creates __message_props__ function" do
    msg_props = TestMsg.Foo.__message_props__
    tags_map = Enum.reduce([1, 2, 3] ++ Enum.to_list(5..13), %{}, fn(i, acc) -> Map.put(acc, i, i) end)
    assert tags_map == msg_props.tags_map
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 1, name: "a", name_atom: :a,
      required?: true, type: :int32, wire_type: 0} = field_props[1]
    assert %FieldProps{fnum: 2, name: "b", name_atom: :b,
      optional?: true, type: :fixed64, wire_type: 1} = field_props[2]
    assert %FieldProps{fnum: 8, name: "g", name_atom: :g,
      repeated?: true, type: :int32, wire_type: 0} = field_props[8]
  end

  test "saves ordered tags" do
    msg_props = TestMsg.Foo.__message_props__
    assert [1, 2, 3] ++ Enum.to_list(5..13) == msg_props.ordered_tags
  end

  test "supports embedded fields" do
    msg_props = TestMsg.Foo.__message_props__
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 6, name: "e", name_atom: :e,
      optional?: true, type: TestMsg.Foo.Bar, wire_type: 2, embedded?: true} = field_props[6]
    assert %FieldProps{fnum: 9, name: "h", name_atom: :h,
      repeated?: true, type: TestMsg.Foo.Bar, wire_type: 2, embedded?: true} = field_props[9]
  end

  test "supports repeated_fields" do
    msg_props = TestMsg.Foo.__message_props__
    assert msg_props.repeated_fields == [:g, :h, :i]
  end

  test "supports packed option" do
    msg_props = TestMsg.Foo.__message_props__
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 10, name: "i", repeated?: true, packed?: true} = field_props[10]
  end

  test "supports enum" do
    msg_props = TestMsg.EnumFoo.__message_props__
    assert msg_props.enum? == true
    assert TestMsg.EnumFoo.val(:A) == 1
    assert TestMsg.EnumFoo.val(:B) == 2
    assert TestMsg.EnumFoo.val(:C) == 4
    assert %FieldProps{fnum: 11, type: :enum, wire_type: 0} = TestMsg.Foo.__message_props__.field_props[11]
  end

  test "ignores unknown options" do
    msg_props = TestMsg.Foo.__message_props__
    assert msg_props.field_props[11].wire_type == 0
    assert msg_props.field_props[11].enum_type == TestMsg.EnumFoo
    refute msg_props.field_props[11].embedded?
  end

  test "generates __default_struct__ function" do
    assert %TestMsg.Foo{a: 0, b: 5, c: "", d: 0.0, e: %TestMsg.Foo.Bar{a: 0, b: ""}, f: 0,
      g: [], h: [], i: [], j: 0, k: false, l: %{}} = TestMsg.Foo.__default_struct__
  end

  test "generates new function" do
    assert %TestMsg.Foo{a: 0, b: 5, c: "", d: 0.0, e: %TestMsg.Foo.Bar{a: 0, b: ""}, f: 0,
             g: [], h: [], i: [], j: 0, k: false, l: %{}} =
           TestMsg.Foo.new
    assert %TestMsg.Foo{a: 1, b: 42, c: "abc", d: 0.0, e: %TestMsg.Foo.Bar{a: 2, b: "asd"}, f: 0,
             g: [], h: [], i: [], j: 0, k: false, l: %{}} =
           TestMsg.Foo.new(%{a: 1, b: 42, c: "abc", e: TestMsg.Foo.Bar.new(a: 2, b: "asd")})
  end
end
