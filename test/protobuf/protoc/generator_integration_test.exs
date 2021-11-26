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
end
