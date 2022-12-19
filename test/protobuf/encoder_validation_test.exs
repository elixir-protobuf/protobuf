defmodule Protobuf.EncoderTest.Validation do
  use ExUnit.Case, async: true

  @valid_vals %{
    int32: -32,
    int64: -64,
    uint32: 32,
    uint64: 64,
    sint32: 32,
    sint64: 64,
    bool: true,
    enum: 3,
    fixed64: 164,
    sfixed64: 264,
    double: 2.23,
    bytes: <<1, 2, 3>>,
    string: "str",
    fixed32: 132,
    sfixed32: 232,
    float: 1.23,
    nil: nil
  }

  def other_types(white_list) do
    keys = List.wrap(white_list)

    @valid_vals |> Map.take(keys) |> Map.values()
  end

  test "encode_type/2 is invalid" do
    assert_invalid = fn type, others ->
      Enum.each(other_types(others), fn {invalid, err_type} ->
        assert_raise err_type, fn ->
          Protobuf.Wire.encode(type, invalid)
        end
      end)
    end

    int_list = [
      bool: ArgumentError,
      double: ArithmeticError,
      bytes: ArgumentError,
      string: ArgumentError,
      float: ArithmeticError,
      nil: ArgumentError
    ]

    assert_invalid.(:int32, int_list)
    assert_invalid.(:int64, int_list)
    assert_invalid.(:uint32, int_list)
    assert_invalid.(:uint64, int_list)
    assert_invalid.(:sint32, int_list)
    assert_invalid.(:sint64, int_list)
    assert_invalid.(:enum, int_list)
    assert_invalid.(:fixed64, int_list)
    assert_invalid.(:sfixed64, int_list)
    assert_invalid.(:fixed32, int_list)
    assert_invalid.(:fixed64, int_list)

    float_list = [
      bool: ArgumentError,
      bytes: ArgumentError,
      string: ArgumentError,
      nil: ArgumentError
    ]

    assert_invalid.(:double, float_list)
    assert_invalid.(:float, float_list)

    bytes_list = [
      int32: ArgumentError,
      bool: ArgumentError,
      double: ArgumentError,
      nil: ArgumentError
    ]

    assert_invalid.(:bytes, bytes_list)
    assert_invalid.(:string, bytes_list)
  end

  test "field is invalid" do
    msg = %TestMsg.Foo{a: "abc"}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Foo#a.*Protobuf.EncodeError/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "proto2 invalid when required field is nil" do
    msg = %TestMsg.Foo2{a: nil}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Foo2#a.*Protobuf.EncodeError/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "proto2 valid optional field is nil" do
    msg = %TestMsg.Foo2{a: 1, c: nil}

    assert Protobuf.Encoder.encode(msg)
  end

  test "oneof invalid format" do
    msg = %TestMsg.Oneof{first: 1}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Oneof#first should be {key, val}/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "oneof field doesn't match" do
    msg = %TestMsg.Oneof{first: {:c, 42}}

    assert_raise Protobuf.EncodeError, ~r/:c doesn't belong to TestMsg.Oneof#first/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "oneof field is invalid" do
    msg = %TestMsg.Oneof{first: {:a, "abc"}}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Oneof#a.*Protobuf.EncodeError/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "oneof field is non-existent" do
    msg = %TestMsg.OneofProto3{first: {:x, "foo"}}

    assert_raise Protobuf.EncodeError, ~r/:x wasn't found in TestMsg.OneofProto3#first/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "repeated field is not list" do
    msg = %TestMsg.Foo{g: 1}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Foo#g.*Protocol.UndefinedError/, fn ->
      Protobuf.Encoder.encode(msg)
    end

    msg = %TestMsg.Foo{}
    msg = %{msg | h: %TestMsg.Foo.Bar{}}

    assert_raise Protobuf.EncodeError, ~r/TestMsg.Foo#h.*Protocol.UndefinedError/, fn ->
      Protobuf.Encoder.encode(msg)
    end
  end

  test "build embedded field map when encode" do
    msg = %TestMsg.Foo{}
    msg = %TestMsg.Foo{msg | e: %{a: 1}}
    msg1 = %TestMsg.Foo{e: %{a: 1}}

    assert Protobuf.Encoder.encode(msg) == Protobuf.Encoder.encode(msg1)
  end
end
