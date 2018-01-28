defmodule Protobuf.FieldProps do
  @type t :: %__MODULE__{
          fnum: integer,
          name: String.t(),
          name_atom: atom,
          wire_type: 0..5,
          type: atom,
          enum_type: atom,
          default: any,
          oneof: non_neg_integer,
          required?: boolean,
          optional?: boolean,
          repeated?: boolean,
          enum?: boolean,
          embedded?: boolean,
          packed?: boolean,
          map?: boolean
        }
  defstruct fnum: nil,
            name: nil,
            name_atom: nil,
            wire_type: nil,
            type: nil,
            enum_type: nil,
            default: nil,
            oneof: nil,
            required?: false,
            optional?: false,
            repeated?: false,
            enum?: false,
            embedded?: false,
            packed?: false,
            map?: false
end
