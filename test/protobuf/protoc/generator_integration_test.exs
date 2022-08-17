defmodule Protobuf.Protoc.GeneratorIntegrationTest do
  use ExUnit.Case, async: true
  @moduletag :integration

  test "encode and decode My.Test.Request" do
    entry = %My.Test.Reply.Entry{
      key_that_needs_1234camel_CasIng: 1,
      value: -12_345,
      _my_field_name_2: 21
    }

    reply = My.Test.Reply.new(found: [entry], compact_keys: [1, 2, 3])

    input =
      My.Test.Request.new(
        key: [123],
        hue: :GREEN,
        hat: :FEZ,
        deadline: 123.0,
        name_mapping: %{321 => "name"},
        msg_mapping: %{1234 => reply}
      )

    output = My.Test.Request.encode(input)
    assert My.Test.Request.__message_props__().field_props[14].map?
    assert My.Test.Request.__message_props__().field_props[15].map?
    assert My.Test.Request.NameMappingEntry.__message_props__().map?
    assert My.Test.Request.MsgMappingEntry.__message_props__().map?
    assert My.Test.Request.decode(output) == input
  end

  test "encode and decode My.Test.Communique(oneof)" do
    unions = [
      number: 42,
      name: "abc",
      temp_c: 1.2,
      height: 2.5,
      today: :MONDAY,
      maybe: true,
      delta: 123,
      msg: My.Test.Reply.new()
    ]

    Enum.each(unions, fn union ->
      input = %My.Test.Communique{union: union}
      output = My.Test.Communique.encode(input)
      assert My.Test.Communique.decode(output) == input
    end)
  end

  test "encoding maps ensure that validates the input" do
    cases = [
      %{key: :int32_map, wrong_value: "not int32", expected_type: :int32},
      %{key: :sint32_map, wrong_value: "not sint32", expected_type: :sint32},
      %{key: :sfixed32_map, wrong_value: "not sfixed32", expected_type: :sfixed32},
      %{key: :fixed32_map, wrong_value: "not fixed32", expected_type: :fixed32},
      %{key: :uint32_map, wrong_value: "not uint32", expected_type: :uint32},
      %{key: :int64_map, wrong_value: "not int64", expected_type: :int64},
      %{key: :sint64_map, wrong_value: "not sint64", expected_type: :sint64},
      %{key: :sfixed64_map, wrong_value: "not sfixed64", expected_type: :sfixed64},
      %{key: :fixed64_map, wrong_value: "not fixed64", expected_type: :fixed64},
      %{key: :uint64_map, wrong_value: "not uint64", expected_type: :uint64},
      %{key: :float_map, wrong_value: "not float", expected_type: :float},
      %{key: :double_map, wrong_value: "not double", expected_type: :double},
      %{key: :string_map, wrong_value: %{levels: %{level_1: 0.4}}, expected_type: :string},
      %{key: :bool_map, wrong_value: "not bool", expected_type: :bool},
      %{key: :bytes_map, wrong_value: 42, expected_type: :bytes},
      %{key: :enum_map, wrong_value: "not an map enum value", expected_type: :enum, opts: [use_enum_numbers: false]},

      # ASK: I got stuck here due to getting confused by https://github.com/elixir-protobuf/protobuf/blob/885f39e2eccd5468d885d62955fcf695ac6f1fce/lib/protobuf/json/encode.ex#L213
      %{key: :enum_map, wrong_value: :NOT_VALID, expected_type: :enum, opts: [use_enum_numbers: true]},
#      %{key: :enum_map, wrong_value: 42, expected_type: :enum, opts: [use_enum_numbers: false]},
#      %{key: :enum_map, wrong_value: 42, expected_type: :enum, opts: [use_enum_numbers: true]},

#      %{key: :enum_map, wrong_value: :NOT_VALID, expected_type: :enum, opts: [use_enum_numbers: true]},

      # ASK: Do not know the implications of https://github.com/elixir-protobuf/protobuf/blob/885f39e2eccd5468d885d62955fcf695ac6f1fce/lib/protobuf/json/encode.ex#L213
      # 10 is not a valid index in the enum so I would expect the test to pass
#      %{key: :enum_map, wrong_value: 10, expected_type: :enum},
    ]

    for case <- cases do
      message = Regex.compile!("#{inspect(case.wrong_value)} is invalid for type #{inspect(case.expected_type)}")

      assert_raise Protobuf.EncodeError, message, fn ->
        %{}
        |> Map.put(case.key, %{value: case.wrong_value})
        |> My.Test.MapInput.new!()
        |> Protobuf.JSON.encode!(Map.get(case, :opts, []))
      end
    end
  end

  test "options" do
    assert %{deprecated?: true} = My.Test.Options.__message_props__().field_props[1]
  end

  test "extensions" do
    assert "hello" == Protobuf.Protoc.ExtTest.Foo.new(a: "hello").a
  end

  describe "custom options" do
    # These fail the first time, when extensions are not loaded. Then, they start to pass.
    @describetag :skip

    test "with enums" do
      descriptor = Test.EnumWithCustomOptions.descriptor()

      assert %Google.Protobuf.EnumValueDescriptorProto{} =
               value = Enum.find(descriptor.value, &(&1.number == 1))

      assert %Google.Protobuf.EnumValueOptions{__pb_extensions__: extensions} = value.options
      assert Map.fetch(extensions, {Test.PbExtension, :my_custom_option}) == {:ok, "hello"}
    end

    test "with messages" do
      descriptor = Test.MessageWithCustomOptions.descriptor()

      assert %Google.Protobuf.MessageOptions{__pb_extensions__: extensions} = descriptor.options

      assert Map.fetch(extensions, {Test.PbExtension, :lowercase_name}) ==
               {:ok, "message_with_custom_options"}
    end
  end

  test "maps without packages" do
    input = NoPackageMessage.new(number_mapping: %{321 => 123, 1337 => 1})

    output = NoPackageMessage.encode(input)
    assert NoPackageMessage.__message_props__().field_props[1].map?
    assert NoPackageMessage.NumberMappingEntry.__message_props__().map?
    assert NoPackageMessage.decode(output) == input
  end
end
