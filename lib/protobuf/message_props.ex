defmodule Protobuf.MessageProps do
  alias Protobuf.FieldProps
  @type t :: %__MODULE__{
    tags_map: %{integer => integer},
    field_props: %{integer => FieldProps.T},

    extendable?: boolean,
    oneof?: boolean
  }
  defstruct [extendable?: false, tags_map: %{}, oneof?: false, field_props: %{}]
end
