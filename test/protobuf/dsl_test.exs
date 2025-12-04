defmodule Protobuf.DSLTest do
  use ExUnit.Case, async: true

  alias Protobuf.{FieldProps, MessageProps}
  alias TestMsg.{Foo, Foo2, Proto3Optional}

  test "default syntax is proto2" do
    defmodule DefaultSyntax do
      use Protobuf
    end

    assert %MessageProps{syntax: :proto2} = DefaultSyntax.__message_props__()
  end

  test "supports syntax option" do
    defmodule Proto3Syntax do
      use Protobuf, syntax: :proto3
    end

    assert %MessageProps{syntax: :proto3} = Proto3Syntax.__message_props__()
  end

  test "creates __message_props__/0 function" do
    assert %MessageProps{} = msg_props = Foo.__message_props__()

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

  test "proto3_optional? is false by default for proto3" do
    msg_props = Proto3Optional.__message_props__()
    field_props = msg_props.field_props
    assert %FieldProps{fnum: 2, name: "b", proto3_optional?: false} = field_props[2]
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
    assert TestMsg.EnumFoo.key(213_123) == 213_123
    assert TestMsg.EnumFoo.mapping() == %{UNKNOWN: 0, A: 1, B: 2, C: 4, D: 4, E: 4}

    assert %{
             0 => :UNKNOWN,
             1 => :A,
             2 => :B,
             "A" => :A,
             "B" => :B,
             "C" => :C,
             "UNKNOWN" => :UNKNOWN,
             "D" => :D,
             "E" => :E
           } = TestMsg.EnumFoo.__reverse_mapping__()

    # Varies with erlang version
    assert TestMsg.EnumFoo.__reverse_mapping__()[4] in [:C, :D, :E]

    assert %FieldProps{fnum: 11, type: {:enum, TestMsg.EnumFoo}, wire_type: 0} =
             Foo.__message_props__().field_props[11]
  end

  test "supports enum value with string" do
    assert TestMsg.EnumFoo.value("A") == 1
    assert TestMsg.EnumFoo.value("B") == 2
    assert TestMsg.EnumFoo.value("C") == 4
    assert TestMsg.EnumFoo.value("D") == 4
    assert TestMsg.EnumFoo.value("E") == 4
    assert TestMsg.EnumFoo.value("UNKNOWN") == 0
    assert_raise FunctionClauseError, fn -> TestMsg.EnumFoo.value("F") end
    assert_raise FunctionClauseError, fn -> TestMsg.EnumFoo.value("INVALID") end
  end

  test "ignores unknown options" do
    msg_props = Foo.__message_props__()
    assert msg_props.field_props[11].wire_type == 0
    refute msg_props.field_props[11].embedded?
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

  test "creates transform_module/1 function" do
    assert TestMsg.Foo.transform_module() == nil
    assert TestMsg.WithTransformModule.transform_module() == TestMsg.TransformModule
  end

  test "raises a compilation error if there is already a definition for the t/0 type for an enum" do
    assert_raise Protobuf.InvalidError,
                 ~r{t/0 type and the struct are automatically generated},
                 fn ->
                   Code.eval_quoted(
                     quote do
                       defmodule MessageWithWarning do
                         use Protobuf, syntax: :proto3, enum: true

                         @type t() :: integer() | :FOO

                         field :FOO, 0, type: :bool
                       end
                     end
                   )
                 end
  end

  test "raises a compilation error if there is already a call to defstruct/1 and a definition for the t/0 type" do
    assert_raise Protobuf.InvalidError,
                 ~r{t/0 type and the struct are automatically generated},
                 fn ->
                   Code.eval_quoted(
                     quote do
                       defmodule MessageWithWarning do
                         use Protobuf, syntax: :proto3

                         @type t() :: %__MODULE__{foo: boolean()}

                         defstruct [:foo]

                         field :foo, 1, type: :bool
                       end
                     end
                   )
                 end
  end

  test "raises a compilation error if there is already a call to defstruct/1 but no definition for the t/0 type" do
    assert_raise Protobuf.InvalidError,
                 ~r{t/0 type and the struct are automatically generated},
                 fn ->
                   Code.eval_quoted(
                     quote do
                       defmodule MessageWithDefstructError do
                         use Protobuf, syntax: :proto3

                         defstruct [:foo]

                         field :foo, 1, type: :bool
                       end
                     end
                   )
                 end
  end

  test "raises a compilation error if there is already a definition for the t/0 type but no defstruct" do
    assert_raise Protobuf.InvalidError,
                 ~r{the t/0 type and the struct are automatically generated},
                 fn ->
                   Code.eval_quoted(
                     quote do
                       defmodule MessageWithTTypeError do
                         use Protobuf, syntax: :proto3

                         @type t() :: %__MODULE__{foo: boolean()}

                         field :foo, 1, type: :bool
                       end
                     end
                   )
                 end
  end

  test "raises a compilation error if syntax is proto3 and the first enum has tag other than 0" do
    assert_raise RuntimeError,
                 "the first enum value must have tag 0 in proto3, got: 1",
                 fn ->
                   Code.eval_quoted(
                     quote do
                       defmodule MessageWithProto3BadEnumTag do
                         use Protobuf, syntax: :proto3, enum: true
                         field :NOT_ZERO, 1
                       end
                     end
                   )
                 end
  end
end
