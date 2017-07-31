Code.require_file "proto_gen/test.pb.ex", __DIR__
defmodule Protobuf.Protoc.IntegrationTest do
  use ExUnit.Case, async: true
  @moduletag :integration

  test "encode and decode My_Test.Request" do
    entry = %My_Test.Reply.Entry{key_that_needs_1234camel_CasIng: 1, value: -12345, _my_field_name_2: 21}
    reply = %My_Test.Reply{found: [entry], compact_keys: [1, 2, 3]}
    input = %My_Test.Request{
      key: [123], hue: My_Test.Request.Color.val(:GREEN), hat: My_Test.HatType.val(:FEZ),
      deadline: 123.0, name_mapping: [%My_Test.Request.NameMappingEntry{key: 321, value: "name"}],
      msg_mapping: [%My_Test.Request.MsgMappingEntry{key: 1234, value: reply}]
    }
    output = My_Test.Request.encode(input)
    assert My_Test.Request.decode(output) == input
  end
end
