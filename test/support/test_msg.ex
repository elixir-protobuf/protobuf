defmodule TestMsg do
  defmodule SyntaxOption do
    use Protobuf, syntax: :proto3
    defstruct []
  end

  defmodule Foo.Bar do
    use Protobuf, syntax: :proto3

    defstruct [:a, :b]

    field :a, 1, type: :int32
    field :b, 2, type: :string
  end

  defmodule EnumFoo do
    use Protobuf, enum: true, syntax: :proto3

    field :UNKNOWN, 0
    field :A, 1
    field :B, 2
    field :C, 4
  end

  defmodule MapFoo do
    use Protobuf, map: true, syntax: :proto3

    defstruct [:key, :value]
    field :key, 1, type: :string
    field :value, 2, type: :int32
  end

  defmodule Foo do
    use Protobuf, syntax: :proto3

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o]

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
  end

  defmodule Foo2 do
    use Protobuf, syntax: :proto2

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m]

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
    # field :k, 12, optioanl: true, type: :bool
    field :l, 13, repeated: true, type: MapFoo, map: true
    # field :m, 14, optional: true, type: EnumFoo, default: :B, enum: true
  end

  defmodule Oneof do
    use Protobuf

    defstruct [:first, :second, :other]

    oneof :first, 0
    oneof :second, 1
    field :a, 1, optional: true, type: :int32, oneof: 0
    field :b, 2, optional: true, type: :string, oneof: 0
    field :c, 3, optional: true, type: :int32, oneof: 1
    field :d, 4, optional: true, type: :string, oneof: 1
    field :other, 5, optional: true, type: :string
  end

  defmodule OneofProto3 do
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
    use Protobuf, syntax: :proto3
    defstruct [:child]
    field :child, 1, type: Parent.Child
  end

  defmodule Parent.Child do
    use Protobuf, syntax: :proto3
    defstruct [:parent]
    field :parent, 1, type: Parent
  end

  defmodule Link do
    use Protobuf, syntax: :proto3
    defstruct [:child, :value]
    field :child, 1, type: Link
    field :value, 2, type: :int32
  end
end
