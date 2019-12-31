defmodule Protobuf.Extension.Persistent do
  @type t :: %__MODULE__{type: atom}
  defstruct [:type]
end
