defmodule Protobuf.DecodeError do
  defexception message: "something wrong when decoding"
end

defmodule Protobuf.EncodeError do
  defexception message: "something wrong when encoding"
end

defmodule Protobuf.InvalidError do
  defexception [:message]
end
