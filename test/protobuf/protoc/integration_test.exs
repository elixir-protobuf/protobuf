defmodule Protobuf.Protoc.IntegrationTest do
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

    dual =
      Protobuf.Protoc.ExtTest.Dual.new(a: "s1", b: Google.Protobuf.StringValue.new(value: "s2"))

    assert dual.a == "s1"
    assert dual.b.value == "s2"

    assert %{options: [extype: "String.t"]} =
             Protobuf.Protoc.ExtTest.Dual.__message_props__().field_props[1]

    output = Protobuf.Protoc.ExtTest.Dual.encode(dual)

    assert Protobuf.Protoc.ExtTest.Dual.decode(output) == dual
  end

  test "extension use case 2" do
    dt = DateTime.from_unix!(1_464_096_368, :microsecond)

    msg =
      Ext.MyMessage.new(
        f1: 1.0,
        f2: 2.0,
        f3: 3,
        f4: 4,
        f5: 5,
        f6: 6,
        f7: true,
        f8: "8",
        f9: "9",
        nested: Ext.Nested.new(my_timestamp: {:dt, dt}),
        no_extype: %Google.Protobuf.StringValue{value: "none"},
        normal1: 1234,
        normal2: "hello",
        repeated_field: ["r1", "r2"],
        color: :TRAFFIC_LIGHT_COLOR_UNSET,
        color_lc: :traffic_light_color_invalid,
        color_depr: :GREEN,
        color_atom: :red,
        color_repeated: [:red, :green],
        color_repeated_normal: [:TRAFFIC_LIGHT_COLOR_RED, :TRAFFIC_LIGHT_COLOR_GREEN]
      )

    assert msg |> Ext.MyMessage.encode() |> Ext.MyMessage.decode() == msg
  end

  test "extension use case empty values" do
    msg =
      Ext.MyMessage.new(
        f1: 0.0,
        f3: 0,
        f7: false,
        f8: "",
        nested: Ext.Nested.new(),
        no_extype: %Google.Protobuf.StringValue{value: ""},
        normal1: 0,
        normal2: "",
        repeated_field: [],
        color_repeated: [],
        color_repeated_normal: [],
        normal3: []
      )

    assert msg |> Ext.MyMessage.encode() |> Ext.MyMessage.decode() == msg
  end

  test "extensions when enums are nil" do
    msg =
      Ext.MyMessage.new(
        color: nil,
        color_lc: nil,
        color_depr: nil,
        color_atom: nil,
        enums_oneof: {:color_oneof_atom, :invalid}
      )

    assert %Ext.MyMessage{
             color: :TRAFFIC_LIGHT_COLOR_INVALID,
             color_atom: :invalid,
             color_depr: :INVALID,
             color_lc: :traffic_light_color_invalid,
             enums_oneof: {:color_oneof_atom, :invalid}
           } = msg |> Ext.MyMessage.encode() |> Ext.MyMessage.decode()
  end

  test "empty message" do
    assert Ext.MyMessage.new() |> Ext.MyMessage.encode() |> Ext.MyMessage.decode() ==
             Ext.MyMessage.new()
  end

  test "new_and_verify!" do
    dt = DateTime.from_unix!(1_464_096_368, :microsecond)

    msg =
      Ext.MyMessage.new_and_verify!(
        f1: 1.0,
        f2: 2.0,
        f3: 3,
        f4: 4,
        f5: 5,
        f6: 6,
        f7: true,
        f8: "8",
        f9: "9",
        nested: Ext.Nested.new(my_timestamp: {:dt, dt}),
        no_extype: %Google.Protobuf.StringValue{value: "none"},
        normal1: 1234,
        normal2: "hello",
        repeated_field: ["r1", "r2"],
        color: :TRAFFIC_LIGHT_COLOR_UNSET,
        color_lc: :traffic_light_color_invalid,
        color_depr: :GREEN,
        color_atom: :red,
        color_repeated: [:red, :green],
        color_repeated_normal: [:TRAFFIC_LIGHT_COLOR_RED, :TRAFFIC_LIGHT_COLOR_GREEN]
      )

    assert msg |> Ext.MyMessage.encode() |> Ext.MyMessage.decode() == msg
  end
end
