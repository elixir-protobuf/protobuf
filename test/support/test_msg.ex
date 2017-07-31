defmodule TestMsg do
  defmodule Foo.Bar do
    use Protobuf

    defstruct [:a, :b]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :string
  end

  defmodule EnumFoo do
    use Protobuf, enum: true

    field :A, 1
    field :B, 2
    field :C, 4
  end

  defmodule MapFoo do
    use Protobuf, map: true

    defstruct [:key, :value]
    field :key, 1, optional: true, type: :string
    field :value, 2, optional: true, type: :int32
  end

  defmodule Foo do
    use Protobuf

    defstruct [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l]

    field :a, 1, optional: true, type: :int32
    field :b, 2, optional: true, type: :fixed64
    field :c, 3, optional: true, type: :string
    # 4 is skipped for testing
    field :d, 5, optional: true, type: :fixed32
    field :e, 6, optional: true, type: Foo.Bar
    field :f, 7, optional: true, type: :int32
    field :g, 8, repeated: true, type: :int32
    field :h, 9, repeated: true, type: Foo.Bar
    field :i, 10, repeated: true, type: :int32, packed: true
    field :j, 11, optional: true, type: EnumFoo, enum: true
    field :k, 12, optioanl: true, type: :bool
    field :l, 13, repeated: true, type: MapFoo, map: true
  end
end
