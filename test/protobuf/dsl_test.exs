defmodule Protobuf.DSLTest do
  use ExUnit.Case, async: true

  alias Protobuf.FieldProps
  alias TestMsg.{Foo, Foo2}
  alias TestMsg.Ext.DualUseCase

  defmodule DefaultSyntax do
    use Protobuf
  end

  test "default syntax is proto2" do
    assert DefaultSyntax.__message_props__().syntax == :proto2
  end

  test "supports syntax option" do
    msg_props = TestMsg.SyntaxOption.__message_props__()
    assert msg_props.syntax == :proto3
  end

  test "creates __message_props__ function" do
    msg_props = Foo.__message_props__()

    tags_map =
      Enum.reduce([1, 2, 3] ++ Enum.to_list(5..17) ++ [101], %{}, fn i, acc ->
        Map.put(acc, i, i)
      end)

    assert tags_map == msg_props.tags_map
    field_props = msg_props.field_props

    assert %FieldProps{
             fnum: 1,
             name: "a",
             name_atom: :a,
             optional?: true,
             type: :int32,
             wire_type: 0
           } = field_props[1]

    assert %FieldProps{
             fnum: 2,
             name: "b",
             name_atom: :b,
             optional?: true,
             type: :fixed64,
             wire_type: 1
           } = field_props[2]

    assert %FieldProps{
             fnum: 8,
             name: "g",
             name_atom: :g,
             repeated?: true,
             type: :int32,
             wire_type: 0
           } = field_props[8]
  end

  test "required?/optional? can be set for proto2" do
    msg_props = Foo2.__message_props__()
    assert %FieldProps{fnum: 1, required?: true} = msg_props.field_props[1]
    assert %FieldProps{fnum: 3, optional?: true} = msg_props.field_props[3]
  end

  test "saves ordered tags" do
    msg_props = Foo.__message_props__()
    assert [1, 2, 3] ++ Enum.to_list(5..17) ++ [101] == msg_props.ordered_tags
  end

  test "supports embedded fields" do
    msg_props = Foo.__message_props__()
    field_props = msg_props.field_props

    assert %FieldProps{
             fnum: 6,
             name: "e",
             name_atom: :e,
             optional?: true,
             type: Foo.Bar,
             wire_type: 2,
             embedded?: true
           } = field_props[6]

    assert %FieldProps{
             fnum: 9,
             name: "h",
             name_atom: :h,
             repeated?: true,
             type: Foo.Bar,
             wire_type: 2,
             embedded?: true
           } = field_props[9]
  end

  test "supports repeated_fields" do
    msg_props = Foo.__message_props__()
    assert msg_props.repeated_fields == [:g, :h, :i, :o]
  end

  test "supports embedded_fields" do
    msg_props = Foo.__message_props__()
    assert msg_props.embedded_fields == [:e, :h]
  end

  test "packed? is true by default for proto3" do
    msg_props = Foo.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 10, name: "i", repeated?: true, packed?: true} = field_props[10]
    assert %FieldProps{name: "o", repeated?: true, packed?: true} = field_props[16]
  end

  test "packed? can be set to false for proto3" do
    msg_props = Foo.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 8, name: "g", repeated?: true, packed?: false} = field_props[8]
  end

  test "packed? is false by default for proto2" do
    msg_props = Foo2.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 8, name: "g", repeated?: true, packed?: false} = field_props[8]
  end

  test "packed? can be set to true for proto2" do
    msg_props = Foo2.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 10, name: "i", repeated?: true, packed?: true} = field_props[10]
  end

  test "deprecated? is false by default" do
    msg_props = Foo.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 10, name: "i", deprecated?: false} = field_props[10]
  end

  test "deprecated? can be set to true" do
    msg_props = Foo.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 17, name: "p", deprecated?: true} = field_props[17]
  end

  test "field options is nil by default" do
    msg_props = DualUseCase.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{options: nil} = field_props[2]
  end

  test "field options can by keyword list" do
    msg_props = DualUseCase.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{options: [extype: "String.t"]} = field_props[1]
  end

  test "supports enum" do
    assert %{enum?: true} = TestMsg.EnumFoo.__message_props__()
    assert TestMsg.EnumFoo.value(:A) == 1
    assert TestMsg.EnumFoo.value(:B) == 2
    assert TestMsg.EnumFoo.value(:C) == 4
    assert TestMsg.EnumFoo.value(:D) == 4
    assert TestMsg.EnumFoo.value(:E) == 4
    assert_raise FunctionClauseError, fn -> TestMsg.EnumFoo.value(:F) end
    assert TestMsg.EnumFoo.value(1000) == 1000
    assert TestMsg.EnumFoo.key(1) == :A
    assert TestMsg.EnumFoo.key(2) == :B
    assert TestMsg.EnumFoo.key(4) == :C
    assert_raise FunctionClauseError, fn -> TestMsg.EnumFoo.key(5) end
    assert TestMsg.EnumFoo.mapping() == %{UNKNOWN: 0, A: 1, B: 2, C: 4, D: 4, E: 4}

    assert TestMsg.EnumFoo.__reverse_mapping__() == %{
             0 => :UNKNOWN,
             1 => :A,
             2 => :B,
             4 => :C,
             "A" => :A,
             "B" => :B,
             "C" => :C,
             "UNKNOWN" => :UNKNOWN
           }

    assert %FieldProps{fnum: 11, type: {:enum, TestMsg.EnumFoo}, wire_type: 0} =
             Foo.__message_props__().field_props[11]
  end

  test "supports enum w/ custom option atomize" do
    assert %{enum?: true} = TestMsg.Ext.EnumFooCustom.__message_props__()
    assert TestMsg.Ext.EnumFooCustom.value(:letter_a) == 0
    assert TestMsg.Ext.EnumFooCustom.value(:letter_b) == 1
    assert TestMsg.Ext.EnumFooCustom.value(:letter_c) == 2
    assert TestMsg.Ext.EnumFooCustom.value(:letter_d) == 3
    assert TestMsg.Ext.EnumFooCustom.value(:letter_e) == 3

    assert_raise FunctionClauseError, fn ->
      TestMsg.Ext.EnumFooCustom.value(:ENUM_FOO_CUSTOM_LETTER_A)
    end

    assert TestMsg.Ext.EnumFooCustom.value(1000) == 1000
    assert TestMsg.Ext.EnumFooCustom.key(1) == :letter_b
    assert TestMsg.Ext.EnumFooCustom.key(2) == :letter_c
    assert TestMsg.Ext.EnumFooCustom.key(3) == :letter_d
    assert_raise FunctionClauseError, fn -> TestMsg.Ext.EnumFooCustom.key(5) end

    assert TestMsg.Ext.EnumFooCustom.mapping() == %{
             letter_a: 0,
             letter_b: 1,
             letter_c: 2,
             letter_d: 3,
             letter_e: 3
           }

    assert TestMsg.Ext.EnumFooCustom.__reverse_mapping__() == %{
             0 => :letter_a,
             1 => :letter_b,
             2 => :letter_c,
             3 => :letter_d,
             "letter_a" => :letter_a,
             "letter_b" => :letter_b,
             "letter_c" => :letter_c,
             "letter_d" => :letter_d
           }

    assert TestMsg.Ext.EnumFooCustom.__transformation_mapping__() == %{
             ENUM_FOO_CUSTOM_LETTER_A: :letter_a,
             ENUM_FOO_CUSTOM_LETTER_B: :letter_b,
             ENUM_FOO_CUSTOM_LETTER_C: :letter_c,
             ENUM_FOO_CUSTOM_LETTER_D: :letter_d,
             ENUM_FOO_CUSTOM_LETTER_E: :letter_e
           }

    assert TestMsg.Ext.EnumFooCustom.prefix() == "ENUM_FOO_CUSTOM_"

    assert TestMsg.Ext.EnumFooCustom.letter_a() == :letter_a
    assert TestMsg.Ext.EnumFooCustom.letter_b() == :letter_b
    assert TestMsg.Ext.EnumFooCustom.letter_c() == :letter_c
    assert TestMsg.Ext.EnumFooCustom.letter_d() == :letter_d
    assert TestMsg.Ext.EnumFooCustom.letter_e() == :letter_e
  end

  test "ignores unknown options" do
    msg_props = Foo.__message_props__()
    assert msg_props.field_props[11].wire_type == 0
    refute msg_props.field_props[11].embedded?
  end

  test "generates __default_struct__ function" do
    assert %Foo{
             a: 0,
             b: 0,
             c: "",
             d: 0.0,
             e: nil,
             f: 0,
             g: [],
             h: [],
             i: [],
             j: :UNKNOWN,
             k: false,
             l: %{},
             m: :UNKNOWN,
             n: 0.0,
             o: [],
             p: "",
             non_matched: ""
           } == Foo.__default_struct__()
  end

  test "generates new function" do
    assert %Foo{
             a: 0,
             c: "",
             d: 0.0,
             e: nil,
             f: 0,
             g: [],
             h: [],
             i: [],
             j: :UNKNOWN,
             k: false,
             l: %{}
           } = Foo.new()

    assert %Foo{
             a: 1,
             b: 42,
             c: "abc",
             d: 0.0,
             e: %Foo.Bar{a: 2, b: "asd"},
             f: 0,
             g: [],
             h: [],
             i: [],
             j: :UNKNOWN,
             k: false,
             l: %{}
           } = Foo.new(%{a: 1, b: 42, c: "abc", e: Foo.Bar.new(a: 2, b: "asd")})
  end

  test "set oneof of message props" do
    msg_props = TestMsg.Oneof.__message_props__()
    assert %{oneof: [{:first, 0}, {:second, 1}]} = msg_props
    assert msg_props.field_props[1].oneof == 0
    assert msg_props.field_props[2].oneof == 0
    assert msg_props.field_props[3].oneof == 1
    assert msg_props.field_props[4].oneof == 1
    refute msg_props.field_props[5].oneof
  end
end
