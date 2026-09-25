defmodule Protobuf.Extension.Props do
  @moduledoc false

  defmodule Extension do
    @moduledoc false
    @type t :: %__MODULE__{
            extendee: module,
            field_props: Protobuf.FieldProps.t(),
            full_name: String.t() | nil
          }
    defstruct extendee: nil,
              field_props: nil,
              full_name: nil
  end

  @type t :: %__MODULE__{
          extensions: %{{module, integer} => Extension.t()},
          name_to_tag: %{{module, atom} => {module, integer}}
        }
  defstruct extensions: %{}, name_to_tag: %{}
end
