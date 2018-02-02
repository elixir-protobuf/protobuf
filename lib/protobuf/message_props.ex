defmodule Protobuf.MessageProps do
  alias Protobuf.FieldProps

  @type t :: %__MODULE__{
          ordered_tags: [integer],
          tags_map: %{integer => integer},
          field_props: %{integer => FieldProps.T},
          field_tags: %{atom => integer},
          repeated_fields: [atom],
          syntax: atom,
          oneof: [{atom, non_neg_integer}],
          enum?: boolean,
          extendable?: boolean,
          map?: boolean
        }
  defstruct ordered_tags: [],
            tags_map: %{},
            field_props: %{},
            field_tags: %{},
            repeated_fields: [],
            syntax: :proto2,
            oneof: [],
            enum?: false,
            extendable?: false,
            map?: false

  def has_oneof?(props) do
    length(props.oneof) > 0
  end
end
