defmodule Protobuf.MessageProps do
  alias Protobuf.FieldProps
  @type t :: %__MODULE__{
    ordered_tags: [integer],
    tags_map: %{integer => integer},
    field_props: %{integer => FieldProps.T},
    repeated_fields: [atom],

    enum?: boolean,
    extendable?: boolean,
    oneof?: boolean,
  }
  defstruct [
    ordered_tags: [],
    tags_map: %{},
    field_props: %{},
    repeated_fields: [],

    enum?: false,
    oneof?: false,
    extendable?: false,
  ]
end
