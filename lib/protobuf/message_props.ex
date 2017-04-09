defmodule Protobuf.MessageProps do
  alias Protobuf.FieldProps
  @type t :: %__MODULE__{
    tags_map: %{integer => integer},
    field_props: %{integer => FieldProps.T},
    repeated_fields: [atom],

    extendable?: boolean,
    oneof?: boolean
  }
  defstruct [
    tags_map: %{},
    field_props: %{},
    repeated_fields: [],

    oneof?: false,
    extendable?: false,
  ]
end
