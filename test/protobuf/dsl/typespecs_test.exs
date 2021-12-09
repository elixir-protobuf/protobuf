defmodule Protobuf.DSL.TypespecsTest do
  use ExUnit.Case, async: true

  alias Protobuf.{FieldProps, MessageProps}
  alias Protobuf.DSL.Typespecs

  describe "quoted_enum_typespec/1" do
    test "returns integer() | ..." do
      message_props = %MessageProps{
        field_props: %{
          1 => %FieldProps{name_atom: :FOO},
          2 => %FieldProps{name_atom: :BAR},
          3 => %FieldProps{name_atom: :BAZ}
        }
      }

      expected =
        quote do
          integer() | :FOO | :BAR | :BAZ
        end

      assert Typespecs.quoted_enum_typespec(message_props) == expected
    end
  end

  describe "quoted_message_typespec/1" do
    test "with an empty message" do
      message_props = %MessageProps{field_props: %{}, oneof: []}
      quoted = Typespecs.quoted_message_typespec(message_props)
      assert Macro.to_string(quoted) == "%__MODULE__{}"
    end
  end
end
