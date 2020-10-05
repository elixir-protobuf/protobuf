defmodule Protobuf.DecodeError do
  defexception message: "something wrong when decoding"
end

defmodule Protobuf.EncodeError do
  defexception message: "something wrong when encoding"
end

defmodule Protobuf.TypeEncodeError do
  defexception message: "value is invalid for the type"
end

defmodule Protobuf.InvalidError do
  defexception [:message]
end

defmodule Protobuf.VerificationError do
  defexception [:message]
end

defmodule Protobuf.ExtensionNotFound do
  defexception message: "extension for the field is not found"
end
