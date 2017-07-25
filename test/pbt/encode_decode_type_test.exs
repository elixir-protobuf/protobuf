defmodule Protobuf.EncodeDecodeTypeTest do
  use ExUnit.Case
  use EQC.ExUnit

  alias Protobuf.Encoder
  alias Protobuf.Decoder

  property "int32 roundtrip" do
    forall n <- resize(2_147_483_647, int()) do
      bin = Encoder.encode_type(:int32, n)
      ensure {n, ""} == Decoder.decode_type(:int32, 0, bin)
    end
  end
end
