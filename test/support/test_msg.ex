defmodule TestMsg do
  @moduledoc false

  defmodule SyntaxOption do
    @moduledoc false
    use Protobuf, syntax: :proto3
  end

  defmodule Foo.Bar do
    @moduledoc false
    use Protobuf, syntax: :proto3

    field :a, 1, type: :int32
    field :b, 2, type: :string
  end

  defmodule Foo.Baz do
    @moduledoc false
    use Protobuf, syntax: :proto3

    field :a, 1, type: :int32
    field :b, 2, type: :string
    field :c, 3, type: :string
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

    field :key, 1, type: :string
    field :value, 2, type: :int32
  end

  defmodule Foo do
    @moduledoc false
    use Protobuf, syntax: :proto3

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

    field :a, 1, repeated: true, type: :sint32
  end

  defmodule SignedInt32RepeatedPacked do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :a, 1, repeated: true, type: :sint32, packed: true
  end

  defmodule Oneof do
    @moduledoc false
    use Protobuf

    oneof :first, 0
    oneof :second, 1
    field :a, 1, optional: true, type: :int32, oneof: 0
    field :b, 2, optional: true, type: :string, oneof: 0
    field :c, 3, optional: true, type: :int32, oneof: 1
    field :d, 4, optional: true, type: :string, oneof: 1
    field :e, 6, optional: true, type: EnumFoo, enum: true, default: :A, oneof: 0
    field :other, 5, optional: true, type: :string
  end

  defmodule OneofProto3 do
    @moduledoc false
    use Protobuf, syntax: :proto3

    oneof :first, 0
    oneof :second, 1
    field :a, 1, optional: true, type: :int32, oneof: 0
    field :b, 2, optional: true, type: :string, oneof: 0
    field :c, 3, optional: true, type: :int32, oneof: 1
    field :d, 4, optional: true, type: :string, oneof: 1
    field :e, 6, type: EnumFoo, enum: true, oneof: 0
    field :other, 5, optional: true, type: :string
  end

  defmodule Proto3Optional do
    @moduledoc false
    use Protobuf, syntax: :proto3

    field :a, 1, proto3_optional: true, type: :int32
    field :b, 2, type: :string
    field :c, 3, proto3_optional: true, type: EnumFoo, enum: true
  end

  defmodule Parent do
    @moduledoc false
    use Protobuf, syntax: :proto3
    field :child, 1, type: Parent.Child
  end

  defmodule Parent.Child do
    @moduledoc false
    use Protobuf, syntax: :proto3
    field :parent, 1, type: Parent
  end

  defmodule Link do
    @moduledoc false
    use Protobuf, syntax: :proto3
    field :child, 1, type: Link
    field :value, 2, type: :int32
  end

  defmodule DefaultEnum2 do
    @moduledoc false
    use Protobuf, enum: true, syntax: :proto2

    field :a, 0
    field :b, 1
  end

  defmodule EnumBar2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :a, 1, required: true, type: DefaultEnum2, enum: true
    field :b, 2, optional: true, type: DefaultEnum2, enum: true
  end

  defmodule EnumFoo2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :a, 1, optional: true, type: DefaultEnum2, enum: true
    field :b, 2, optional: true, type: DefaultEnum2, enum: true
  end

  defmodule Scalars do
    @moduledoc false
    use Protobuf, syntax: :proto3

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

    field :key, 1, type: :int32
    field :value, 2, type: :int32
  end

  defmodule MapBoolToInt do
    use Protobuf, map: true, syntax: :proto3

    field :key, 1, type: :bool
    field :value, 2, type: :int32
  end

  defmodule Maps do
    use Protobuf, syntax: :proto3

    field :mapii, 1, repeated: true, map: true, type: MapIntToInt
    field :mapbi, 2, repeated: true, map: true, type: MapBoolToInt
    field :mapsi, 3, repeated: true, map: true, type: MapFoo
  end

  defmodule TransformModule do
    @behaviour Protobuf.TransformModule

    alias TestMsg.WithTransformModule

    @impl true
    defmacro typespec(default_typespec) do
      case __CALLER__.module do
        WithTransformModule ->
          quote do
            @type t() :: integer()
          end

        _ ->
          default_typespec
      end
    end

    # In an actual implementation, one could write the implementations of
    # encode/2 and decode/2 in a separate module and use the structs
    # directly.

    @impl true
    def encode(integer, WithTransformModule) when is_integer(integer) do
      struct(WithTransformModule, field: integer)
    end

    @impl true
    def decode(%{__struct__: WithTransformModule, field: integer}, WithTransformModule) do
      integer
    end
  end

  defmodule WithTransformModule do
    use Protobuf, syntax: :proto3

    field :field, 1, type: :int32

    def transform_module(), do: TestMsg.TransformModule
  end

  defmodule ContainsTransformModule do
    use Protobuf, syntax: :proto3

    field :field, 1, type: WithTransformModule
  end

  defmodule TransformIntegerStrings do
    @behaviour Protobuf.TransformModule

    alias TestMsg.ContainsIntegerStringTransformModule

    @impl true
    def encode(
          %{__struct__: ContainsIntegerStringTransformModule, field: str},
          ContainsIntegerStringTransformModule
        )
        when is_binary(str) do
      struct(ContainsIntegerStringTransformModule, field: String.to_integer(str))
    end

    @impl true
    def decode(%{__struct__: ContainsIntegerStringTransformModule} = value, _) do
      value
    end
  end

  defmodule ContainsIntegerStringTransformModule do
    use Protobuf, syntax: :proto3

    field :field, 1, type: :int32

    def transform_module(), do: TestMsg.TransformIntegerStrings
  end

  defmodule Ext.EnumFoo do
    @moduledoc false
    use Protobuf, enum: true, syntax: :proto2

    field :UNKNOWN, 0
    field :A, 1
    field :B, 2
    field :C, 4
  end

  defmodule Ext.Foo1 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :fa, 1, optional: true, type: :uint32

    extensions([{100, 101}, {1000, 536_870_912}])
  end

  defmodule Ext.Foo2 do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :fa, 1, optional: true, type: :uint32

    extensions([{100, 101}, {1000, 536_870_912}])
  end

  defmodule Ext.Options do
    @moduledoc false
    use Protobuf, syntax: :proto2

    field :a, 1, optional: true, type: :string
  end

  defmodule Ext.Parent do
    @moduledoc false
    use Protobuf, syntax: :proto2
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
