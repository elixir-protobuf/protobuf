defmodule Protobuf.DSL.TypespecsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Protobuf.{FieldProps, MessageProps}
  alias Protobuf.DSL.Typespecs

  @unknown_fields_spec "__unknown_fields__: [{field_number :: integer(), Protobuf.Wire.Types.wire_type(), value :: term()}]"

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

      assert Typespecs.quoted_enum_typespec(message_props) ==
               clean_meta(expected, [:import, :context])
    end

    property "works for any number of possible enum values" do
      check all field_names <- list_of(atom(:alphanumeric), min_length: 1), max_runs: 10 do
        field_props =
          field_names
          |> Enum.with_index(1)
          |> Map.new(fn {name, index} -> {index, %FieldProps{name_atom: name}} end)

        message_props = %MessageProps{field_props: field_props}
        expected = "integer() | #{Enum.map_join(field_names, " | ", &inspect/1)}"

        assert message_props |> Typespecs.quoted_enum_typespec() |> Macro.to_string() == expected
      end
    end
  end

  describe "quoted_message_typespec/1" do
    test "with an empty message" do
      message_props = %MessageProps{field_props: %{}, oneof: []}
      quoted = Typespecs.quoted_message_typespec(message_props)
      assert Macro.to_string(quoted) == "%__MODULE__{#{@unknown_fields_spec}}"
    end

    test "with a field" do
      message_props = %MessageProps{
        field_props: %{1 => %FieldProps{name_atom: :foo, type: :int32}},
        oneof: []
      }

      quoted = Typespecs.quoted_message_typespec(message_props)
      assert Macro.to_string(quoted) == "%__MODULE__{foo: integer(), #{@unknown_fields_spec}}"
    end

    test "with a oneof field" do
      message_props = %MessageProps{
        field_props: %{
          1 => %FieldProps{name_atom: :foo, type: :int32, oneof: 0},
          2 => %FieldProps{name_atom: :bar, type: :bool, oneof: 0}
        },
        oneof: [my_oneof_field: 0]
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) ==
               "%__MODULE__{my_oneof_field: {:foo, integer()} | {:bar, boolean()}, #{@unknown_fields_spec}}"
    end

    test "with fields of scalar types" do
      mappings = [
        {:string, "String.t()"},
        {:bytes, "binary()"},
        {:bool, "boolean()"},
        {:int32, "integer()"},
        {:int64, "integer()"},
        {:sint32, "integer()"},
        {:sint64, "integer()"},
        {:sfixed32, "integer()"},
        {:sfixed64, "integer()"},
        {:uint32, "non_neg_integer()"},
        {:uint64, "non_neg_integer()"},
        {:fixed32, "non_neg_integer()"},
        {:fixed64, "non_neg_integer()"},
        {:float, "float() | :infinity | :negative_infinity | :nan"},
        {:double, "float() | :infinity | :negative_infinity | :nan"}
      ]

      for {proto_type, string_spec} <- mappings do
        message_props = %MessageProps{
          field_props: %{1 => %FieldProps{name_atom: :foo, type: proto_type}},
          oneof: []
        }

        quoted = Typespecs.quoted_message_typespec(message_props)

        assert Macro.to_string(quoted) ==
                 "%__MODULE__{foo: #{string_spec}, #{@unknown_fields_spec}}"
      end
    end

    test "with an enum field" do
      message_props = %MessageProps{
        field_props: %{1 => %FieldProps{name_atom: :foo, type: {:enum, Foo}}},
        oneof: []
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) == "%__MODULE__{foo: Foo.t(), #{@unknown_fields_spec}}"
    end

    test "with a group field" do
      message_props = %MessageProps{
        field_props: %{1 => %FieldProps{name_atom: :foo, type: :group}},
        oneof: []
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) == "%__MODULE__{foo: term(), #{@unknown_fields_spec}}"
    end

    test "with an embedded field" do
      message_props = %MessageProps{
        field_props: %{1 => %FieldProps{name_atom: :foo, type: EmbeddedFoo, embedded?: true}},
        oneof: []
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) ==
               "%__MODULE__{foo: EmbeddedFoo.t() | nil, #{@unknown_fields_spec}}"
    end

    test "with an optional field" do
      message_props = %MessageProps{
        field_props: %{1 => %FieldProps{name_atom: :foo, type: :int32, optional?: true}},
        oneof: []
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) ==
               "%__MODULE__{foo: integer() | nil, #{@unknown_fields_spec}}"
    end

    test "with extensions" do
      message_props = %MessageProps{
        field_props: %{},
        oneof: [],
        extension_range: [{1, 10}]
      }

      quoted = Typespecs.quoted_message_typespec(message_props)

      assert Macro.to_string(quoted) ==
               "%__MODULE__{__pb_extensions__: map(), #{@unknown_fields_spec}}"
    end
  end

  defp clean_meta(expr, vars) do
    cleaner = &Keyword.drop(&1, vars)
    Macro.prewalk(expr, &Macro.update_meta(&1, cleaner))
  end
end
