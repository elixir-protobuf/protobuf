defmodule My_Test.Request do
  use Protobuf

  @type t :: %__MODULE__{
    key:          [integer],
    hue:          integer,
    hat:          integer,
    deadline:     float,
    somegroup:    any,
    name_mapping: %{integer => String.t},
    msg_mapping:  %{integer => My_Test.Reply.t},
    reset:        integer,
    get_key:      String.t
  }
  defstruct [:key, :hue, :hat, :deadline, :somegroup, :name_mapping, :msg_mapping, :reset, :get_key]

  field :key, 1, repeated: true, type: :int64
  field :hue, 3, optional: true, type: My_Test.Request.Color, enum: true
  field :hat, 4, optional: true, type: My_Test.HatType, default: :FEDORA, enum: true
  field :deadline, 7, optional: true, type: :float, default: "inf"
  field :somegroup, 8, optional: true, type: :group
  field :name_mapping, 14, repeated: true, type: My_Test.Request.NameMappingEntry, map: true
  field :msg_mapping, 15, repeated: true, type: My_Test.Request.MsgMappingEntry, map: true
  field :reset, 12, optional: true, type: :int32
  field :get_key, 16, optional: true, type: :string
end

defmodule My_Test.Request.SomeGroup do
  use Protobuf

  @type t :: %__MODULE__{
    group_field: integer
  }
  defstruct [:group_field]

  field :group_field, 9, optional: true, type: :int32
end

defmodule My_Test.Request.NameMappingEntry do
  use Protobuf, map: true

  @type t :: %__MODULE__{
    key:   integer,
    value: String.t
  }
  defstruct [:key, :value]

  field :key, 1, optional: true, type: :int32
  field :value, 2, optional: true, type: :string
end

defmodule My_Test.Request.MsgMappingEntry do
  use Protobuf, map: true

  @type t :: %__MODULE__{
    key:   integer,
    value: My_Test.Reply.t
  }
  defstruct [:key, :value]

  field :key, 1, optional: true, type: :sint64
  field :value, 2, optional: true, type: My_Test.Reply
end

defmodule My_Test.Request.Color do
  use Protobuf, enum: true

  field :RED, 0
  field :GREEN, 1
  field :BLUE, 2
end

defmodule My_Test.Reply do
  use Protobuf

  @type t :: %__MODULE__{
    found:        [My_Test.Reply.Entry.t],
    compact_keys: [integer]
  }
  defstruct [:found, :compact_keys]

  field :found, 1, repeated: true, type: My_Test.Reply.Entry
  field :compact_keys, 2, repeated: true, type: :int32, packed: true
end

defmodule My_Test.Reply.Entry do
  use Protobuf

  @type t :: %__MODULE__{
    key_that_needs_1234camel_CasIng: integer,
    value:                           integer,
    _my_field_name_2:                integer
  }
  defstruct [:key_that_needs_1234camel_CasIng, :value, :_my_field_name_2]

  field :key_that_needs_1234camel_CasIng, 1, required: true, type: :int64
  field :value, 2, optional: true, type: :int64, default: 7
  field :_my_field_name_2, 3, optional: true, type: :int64
end

defmodule My_Test.Reply.Entry.Game do
  use Protobuf, enum: true

  field :FOOTBALL, 1
  field :TENNIS, 2
end

defmodule My_Test.OtherBase do
  use Protobuf

  @type t :: %__MODULE__{
    name: String.t
  }
  defstruct [:name]

  field :name, 1, optional: true, type: :string
end

defmodule My_Test.ReplyExtensions do
  use Protobuf

  defstruct []

end

defmodule My_Test.OtherReplyExtensions do
  use Protobuf

  @type t :: %__MODULE__{
    key: integer
  }
  defstruct [:key]

  field :key, 1, optional: true, type: :int32
end

defmodule My_Test.OldReply do
  use Protobuf

  defstruct []

end

defmodule My_Test.Communique do
  use Protobuf

  @type t :: %__MODULE__{
    make_me_cry: boolean,
    number:      integer,
    name:        String.t,
    data:        String.t,
    temp_c:      float,
    height:      float,
    today:       integer,
    maybe:       boolean,
    delta:       integer,
    msg:         My_Test.Reply.t,
    somegroup:   any
  }
  defstruct [:make_me_cry, :number, :name, :data, :temp_c, :height, :today, :maybe, :delta, :msg, :somegroup]

  field :make_me_cry, 1, optional: true, type: :bool
  field :number, 5, optional: true, type: :int32
  field :name, 6, optional: true, type: :string
  field :data, 7, optional: true, type: :bytes
  field :temp_c, 8, optional: true, type: :double
  field :height, 9, optional: true, type: :float
  field :today, 10, optional: true, type: My_Test.Days, enum: true
  field :maybe, 11, optional: true, type: :bool
  field :delta, 12, optional: true, type: :sint32
  field :msg, 13, optional: true, type: My_Test.Reply
  field :somegroup, 14, optional: true, type: :group
end

defmodule My_Test.Communique.SomeGroup do
  use Protobuf

  @type t :: %__MODULE__{
    member: String.t
  }
  defstruct [:member]

  field :member, 15, optional: true, type: :string
end

defmodule My_Test.Communique.Delta do
  use Protobuf

  defstruct []

end

defmodule My_Test.HatType do
  use Protobuf, enum: true

  field :FEDORA, 1
  field :FEZ, 2
end

defmodule My_Test.Days do
  use Protobuf, enum: true

  field :MONDAY, 1
  field :TUESDAY, 2
  field :LUNDI, 1
end
