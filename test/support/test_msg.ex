defmodule TestMsg do
  @moduledoc false

  defmodule SyntaxOption do
    @moduledoc false
    use Protobuf, syntax: :proto3
    defstruct []
  end

  defmodule Foo.Bar do
    @moduledoc false
    use Protobuf, syntax: :proto3

    defstruct [:a, :b]

    field :a, 1, type: :int32
    field :b, 2, type: :string
  end

  defmodule EnumFoo do
    @moduledoc false
    use Protobuf, enum: true, syntax: :proto3

    field :UNKNOWN, 0
    field :A, 1
    field :B, 2
    field :C, 4
    field :D, 4
    field :E, 4
  end

  defmodule MapFoo do
    @moduledoc false
    use Protobuf, map: true, syntax: :proto3

    defstruct [:key, :value]
    field :key, 1, type: :string
    field :value, 2, type: :int32
  end

  defmodule Foo do
    @moduledoc false
    use Protobuf, syntax: :proto3

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :non_matched]

    field :a, 1, type: :int32
    field :b, 2, type: :fixed64
    field :c, 3, type: :string
    # 4 is skipped for testing
    field :d, 5, type: :float
    field :e, 6, type: Foo.Bar
    field :f, 7, type: :int32
    field :g, 8, repeated: true, type: :int32, packed: false
    field :h, 9, repeated: true, type: Foo.Bar
    field :i, 10, repeated: true, type: :int32
    field :j, 11, type: EnumFoo, enum: true
    field :k, 12, type: :bool
    field :l, 13, repeated: true, type: MapFoo, map: true
    field :m, 14, type: EnumFoo, enum: true
    field :n, 15, type: :double
    field :o, 16, repeated: true, type: EnumFoo, enum: true
    field :p, 17, type: :string, deprecated: true
    # Used for testing against same field name with different types(in Foo2)
    field :non_matched, 101, type: :string
  end

  defmodule Foo2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :non_matched]

    field :a, 1, required: true, type: :int32
    field :b, 2, optional: true, type: :fixed64, default: 5
    field :c, 3, optional: true, type: :string
    # 4 is skipped for testing
    # field :d, 5, optional: true, type: :float
    field :e, 6, optional: true, type: Foo.Bar
    # field :f, 7, optional: true, type: :int32
    field :g, 8, repeated: true, type: :int32
    # field :h, 9, repeated: true, type: Foo.Bar
    field :i, 10, repeated: true, type: :int32, packed: true
    # field :j, 11, optional: true, type: EnumFoo, enum: true
    # field :k, 12, optional: true, type: :bool
    field :l, 13, repeated: true, type: MapFoo, map: true
    field :non_matched, 101, type: :int32, optional: true
  end

  defmodule SignedInt32Repeated do
    @moduledoc false
    use Protobuf, syntax: :proto2

    defstruct [:a]

    field :a, 1, repeated: true, type: :sint32
  end

  defmodule SignedInt32RepeatedPacked do
    @moduledoc false
    use Protobuf, syntax: :proto2

    defstruct [:a]

    field :a, 1, repeated: true, type: :sint32, packed: true
  end

  defmodule Oneof do
    @moduledoc false
    use Protobuf

    defstruct [:first, :second, :other]

    oneof :first, 0
    oneof :second, 1
    field :a, 1, optional: true, type: :int32, oneof: 0
    field :b, 2, optional: true, type: :string, oneof: 0
    field :c, 3, optional: true, type: :int32, oneof: 1
    field :d, 4, optional: true, type: :string, oneof: 1
    field :e, 6, optional: true, type: EnumFoo, enum: true, oneof: 0
    field :other, 5, optional: true, type: :string
  end

  defmodule OneofProto3 do
    @moduledoc false
    use Protobuf, syntax: :proto3

    defstruct [:first, :second, :other]

    oneof :first, 0
    oneof :second, 1
    field :a, 1, optional: true, type: :int32, oneof: 0
    field :b, 2, optional: true, type: :string, oneof: 0
    field :c, 3, optional: true, type: :int32, oneof: 1
    field :d, 4, optional: true, type: :string, oneof: 1
    field :e, 6, type: EnumFoo, enum: true, oneof: 0
    field :other, 5, optional: true, type: :string
  end

  defmodule Parent do
    @moduledoc false
    use Protobuf, syntax: :proto3
    defstruct [:child]
    field :child, 1, type: Parent.Child
  end

  defmodule Parent.Child do
    @moduledoc false
    use Protobuf, syntax: :proto3
    defstruct [:parent]
    field :parent, 1, type: Parent
  end

  defmodule Link do
    @moduledoc false
    use Protobuf, syntax: :proto3
    defstruct [:child, :value]
    field :child, 1, type: Link
    field :value, 2, type: :int32
  end

  defmodule Bar2.Enum do
    @moduledoc false
    use Protobuf, enum: true, syntax: :proto2

    field :a, 0
    field :b, 1
  end

  defmodule Bar2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :a, 1, required: true, type: Bar2.Enum, enum: true
    field :b, 2, optional: true, type: Bar2.Enum, enum: true
  end

  defmodule Scalars do
    @moduledoc false
    use Protobuf, syntax: :proto3

    defstruct [
      :string,
      :bool,
      :float,
      :double,
      :int32,
      :uint32,
      :sint32,
      :fixed32,
      :sfixed32,
      :int64,
      :uint64,
      :sint64,
      :fixed64,
      :sfixed64,
      :bytes,
      :repeated_string,
      :repeated_bool,
      :repeated_float,
      :repeated_double,
      :repeated_int32,
      :repeated_uint32,
      :repeated_sint32,
      :repeated_fixed32,
      :repeated_sfixed32,
      :repeated_int64,
      :repeated_uint64,
      :repeated_sint64,
      :repeated_fixed64,
      :repeated_sfixed64,
      :repeated_bytes
    ]

    field :string, 1, type: :string
    field :bool, 2, type: :bool

    field :float, 3, type: :float
    field :double, 4, type: :double

    field :int32, 5, type: :int32
    field :uint32, 6, type: :uint32
    field :sint32, 7, type: :sint32
    field :fixed32, 8, type: :fixed32
    field :sfixed32, 9, type: :sfixed32

    field :int64, 10, type: :int64
    field :uint64, 11, type: :uint64
    field :sint64, 12, type: :sint64
    field :fixed64, 13, type: :fixed64
    field :sfixed64, 14, type: :sfixed64

    field :bytes, 15, type: :bytes

    field :repeated_string, 16, repeated: true, type: :string
    field :repeated_bool, 17, repeated: true, type: :bool

    field :repeated_float, 18, repeated: true, type: :float
    field :repeated_double, 19, repeated: true, type: :double

    field :repeated_int32, 20, repeated: true, type: :int32
    field :repeated_uint32, 21, repeated: true, type: :uint32
    field :repeated_sint32, 22, repeated: true, type: :sint32
    field :repeated_fixed32, 23, repeated: true, type: :fixed32
    field :repeated_sfixed32, 24, repeated: true, type: :sfixed32

    field :repeated_int64, 25, repeated: true, type: :int64
    field :repeated_uint64, 26, repeated: true, type: :uint64
    field :repeated_sint64, 27, repeated: true, type: :sint64
    field :repeated_fixed64, 28, repeated: true, type: :fixed64
    field :repeated_sfixed64, 29, repeated: true, type: :sfixed64

    field :repeated_bytes, 30, repeated: true, type: :bytes
  end

  defmodule MapIntToInt do
    use Protobuf, map: true, syntax: :proto3

    defstruct [:key, :value]

    field :key, 1, type: :int32
    field :value, 2, type: :int32
  end

  defmodule MapBoolToInt do
    use Protobuf, map: true, syntax: :proto3

    defstruct [:key, :value]

    field :key, 1, type: :bool
    field :value, 2, type: :int32
  end

  defmodule Maps do
    use Protobuf, syntax: :proto3

    defstruct [:mapii, :mapbi, :mapsi]

    field :mapii, 1, repeated: true, map: true, type: MapIntToInt
    field :mapbi, 2, repeated: true, map: true, type: MapBoolToInt
    field :mapsi, 3, repeated: true, map: true, type: MapFoo
  end

  defmodule WithTransformModule do
    use Protobuf, syntax: :proto3

    defstruct [:field]

    field :field, 1, type: :int32

    def transform_module(), do: TestMsg.TransformModule
  end

  defmodule ContainsTransformModule do
    use Protobuf, syntax: :proto3

    defstruct [:field]

    field :field, 1, type: WithTransformModule
  end

  defmodule TransformModule do
    @behaviour Protobuf.TransformModule

    @impl true
    def encode(integer, WithTransformModule) when is_integer(integer) do
      %WithTransformModule{field: integer}
    end

    @impl true
    def decode(%WithTransformModule{field: integer}, WithTransformModule) do
      integer
    end
  end

  defmodule Ext.EnumFoo do
    @moduledoc false
    use Protobuf, enum: true, syntax: :proto2

    @type t :: integer | :UNKNOWN | :A | :B | :C

    field :UNKNOWN, 0
    field :A, 1
    field :B, 2
    field :C, 4
  end

  defmodule Ext.Foo1 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    @type t :: %__MODULE__{
            fa: non_neg_integer,
            __pb_extensions__: map
          }
    defstruct [:fa, :__pb_extensions__]

    field :fa, 1, optional: true, type: :uint32

    extensions([{100, 101}, {1000, 536_870_912}])
  end

  defmodule Ext.Foo2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    @type t :: %__MODULE__{
            fa: non_neg_integer,
            __pb_extensions__: map
          }
    defstruct [:fa, :__pb_extensions__]

    field :fa, 1, optional: true, type: :uint32

    extensions([{100, 101}, {1000, 536_870_912}])
  end

  defmodule Ext.Options do
    @moduledoc false
    use Protobuf, syntax: :proto2

    @type t :: %__MODULE__{
            a: String.t()
          }
    defstruct [:a]

    field :a, 1, optional: true, type: :string
  end

  defmodule Ext.Parent do
    @moduledoc false
    use Protobuf, syntax: :proto2

    @type t :: %__MODULE__{}
    defstruct []
  end

  defmodule Ext.PbExtension do
    @moduledoc false
    use Protobuf, syntax: :proto2

    extend Ext.Foo1, :foo, 1047, optional: true, type: Ext.Options
    extend Ext.Foo1, :foo2, 1049, repeated: true, type: :uint32
    extend Ext.Foo2, :bar, 1047, optional: true, type: :string
    extend Ext.Foo1, :"Parent.foo", 1048, optional: true, type: Ext.EnumFoo, enum: true
  end
end
