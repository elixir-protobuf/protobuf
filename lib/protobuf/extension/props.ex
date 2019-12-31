defmodule Protobuf.Extension.Props do
  @moduledoc false

  defmodule Extension do
    @moduledoc false
    @type t :: %__MODULE__{
      extendee: module,
      name_atom: atom,
      fnum: non_neg_integer,
      type: atom
    }
    defstruct extendee: nil,
              name_atom: nil,
              fnum: nil,
              type: nil
  end

  @type t :: %__MODULE__{
    extensions: [Extension.t]
  }
  defstruct extensions: []
end
