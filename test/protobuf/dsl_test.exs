defmodule Protobuf.DSLTest do
  use ExUnit.Case, async: true

  alias Protobuf.FieldProps

  defmodule Foo.Bar do
    use Protobuf
    defstruct [:b]
    field :b, 1, required: true, type: :string
  end

  defmodule Foo do
    use Protobuf

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h]

    field :b, 2, optional: true, type: :string
    field :a, 1, required: true, type: :int32
    # 3 is skipped
    field :c, 4, repeated: true, type: :string
    field :d, 5, optional: true, type: Foo.Bar
    field :e, 6, repeated: true, type: Foo.Bar
    field :f, 7, repeated: true, type: :int32, packed: true
    field :g, 8, optional: true, type: Protobuf.DSLTest.EnumFoo, enum: true
    field :h, 9, optional: true, type: Protobuf.DSLTest.EnumFoo, default: 1, enum: true
  end

  defmodule EnumFoo do
    use Protobuf, enum: true

    field :A, 1
    field :B, 2
    field :C, 4
  end

  test "creates __message_props__ function" do
    msg_props = Foo.__message_props__
    assert %{1 => 1, 2 => 2, 4 => 4, 5 => 5, 6 => 6} = msg_props.tags_map
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 1, name: "a", name_atom: :a,
      required?: true, type: :int32, wire_type: 0} = field_props[1]
    assert %FieldProps{fnum: 2, name: "b", name_atom: :b,
      optional?: true, type: :string, wire_type: 2} = field_props[2]
    assert %FieldProps{fnum: 4, name: "c", name_atom: :c,
      repeated?: true, type: :string, wire_type: 2} = field_props[4]
  end

  test "saves ordered tags" do
    msg_props = Foo.__message_props__
    assert [1, 2, 4, 5, 6, 7, 8, 9] = msg_props.ordered_tags
  end

  test "supports embedded fields" do
    msg_props = Foo.__message_props__
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 5, name: "d", name_atom: :d,
      optional?: true, type: Foo.Bar, wire_type: 2, embedded?: true} = field_props[5]
    assert %FieldProps{fnum: 6, name: "e", name_atom: :e,
      repeated?: true, type: Foo.Bar, wire_type: 2, embedded?: true} = field_props[6]
  end

  test "supports repeated_fields" do
    msg_props = Foo.__message_props__
    assert msg_props.repeated_fields == [:c, :e, :f]
  end

  test "supports packed option" do
    msg_props = Foo.__message_props__
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 7, name: "f", repeated?: true, packed?: true} = field_props[7]
  end

  test "supports enum" do
    msg_props = EnumFoo.__message_props__
    assert msg_props.enum? == true
    assert EnumFoo.val(:A) == 1
    assert EnumFoo.val(:B) == 2
    assert EnumFoo.val(:C) == 4
    assert %FieldProps{fnum: 8, type: :enum, wire_type: 0} = Foo.__message_props__.field_props[8]
  end

  test "ignores unknown options" do
    msg_props = Foo.__message_props__
    assert msg_props.field_props[9].wire_type == 0
    assert msg_props.field_props[9].enum_type == EnumFoo
    refute msg_props.field_props[9].embedded?
  end
end
