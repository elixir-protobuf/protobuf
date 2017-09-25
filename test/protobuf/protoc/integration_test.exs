Code.require_file "proto_gen/test.pb.ex", __DIR__
defmodule Protobuf.Protoc.IntegrationTest do
  use ExUnit.Case, async: true
  @moduletag :integration

  test "encode and decode My_Test.Request" do
    entry = %My_Test.Reply.Entry{key_that_needs_1234camel_CasIng: 1, value: -12345, _my_field_name_2: 21}
    reply = %My_Test.Reply{found: [entry], compact_keys: [1, 2, 3]}
    input = My_Test.Request.new(
      key: [123], hue: My_Test.Request.Color.value(:GREEN), hat: My_Test.HatType.value(:FEZ),
      deadline: 123.0, name_mapping: %{321 => "name"},
      msg_mapping: %{1234 => reply}
    )
    output = My_Test.Request.encode(input)
    assert My_Test.Request.__message_props__.field_props[14].map?
    assert My_Test.Request.__message_props__.field_props[15].map?
    assert My_Test.Request.NameMappingEntry.__message_props__.map?
    assert My_Test.Request.MsgMappingEntry.__message_props__.map?
    assert My_Test.Request.decode(output) == input
  end

  test "encode and decode My_Test.Communique(oneof)" do
    unions = [number: 42, name: "abc", temp_c: 1.2, height: 2.5, today: 1, maybe: true,
              delta: 123, msg: My_Test.Reply.new()]
    Enum.each(unions, fn(union) ->
      input = %My_Test.Communique{union: union}
      output = My_Test.Communique.encode(input)
      assert My_Test.Communique.decode(output) == input
    end)
  end
end
