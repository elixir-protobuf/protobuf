defmodule Protobuf.DecodeError do
  defexception message: "something wrong when decoding"
end

defmodule Protobuf.InvalidError do
  defexception [:message]
end
