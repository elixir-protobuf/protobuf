defmodule Google.Protobuf.FieldDescriptorProto.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :TYPE_DOUBLE
          | :TYPE_FLOAT
          | :TYPE_INT64
          | :TYPE_UINT64
          | :TYPE_INT32
          | :TYPE_FIXED64
          | :TYPE_FIXED32
          | :TYPE_BOOL
          | :TYPE_STRING
          | :TYPE_GROUP
          | :TYPE_MESSAGE
          | :TYPE_BYTES
          | :TYPE_UINT32
          | :TYPE_ENUM
          | :TYPE_SFIXED32
          | :TYPE_SFIXED64
          | :TYPE_SINT32
          | :TYPE_SINT64

  field :TYPE_DOUBLE, 1
  field :TYPE_FLOAT, 2
  field :TYPE_INT64, 3
  field :TYPE_UINT64, 4
  field :TYPE_INT32, 5
  field :TYPE_FIXED64, 6
  field :TYPE_FIXED32, 7
  field :TYPE_BOOL, 8
  field :TYPE_STRING, 9
  field :TYPE_GROUP, 10
  field :TYPE_MESSAGE, 11
  field :TYPE_BYTES, 12
  field :TYPE_UINT32, 13
  field :TYPE_ENUM, 14
  field :TYPE_SFIXED32, 15
  field :TYPE_SFIXED64, 16
  field :TYPE_SINT32, 17
  field :TYPE_SINT64, 18
end

defmodule Google.Protobuf.FieldDescriptorProto.Label do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :LABEL_OPTIONAL | :LABEL_REQUIRED | :LABEL_REPEATED

  field :LABEL_OPTIONAL, 1
  field :LABEL_REQUIRED, 2
  field :LABEL_REPEATED, 3
end

defmodule Google.Protobuf.FileOptions.OptimizeMode do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :SPEED | :CODE_SIZE | :LITE_RUNTIME

  field :SPEED, 1
  field :CODE_SIZE, 2
  field :LITE_RUNTIME, 3
end

defmodule Google.Protobuf.FieldOptions.CType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :STRING | :CORD | :STRING_PIECE

  field :STRING, 0
  field :CORD, 1
  field :STRING_PIECE, 2
end

defmodule Google.Protobuf.FieldOptions.JSType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :JS_NORMAL | :JS_STRING | :JS_NUMBER

  field :JS_NORMAL, 0
  field :JS_STRING, 1
  field :JS_NUMBER, 2
end

defmodule Google.Protobuf.MethodOptions.IdempotencyLevel do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :IDEMPOTENCY_UNKNOWN | :NO_SIDE_EFFECTS | :IDEMPOTENT

  field :IDEMPOTENCY_UNKNOWN, 0
  field :NO_SIDE_EFFECTS, 1
  field :IDEMPOTENT, 2
end

defmodule Google.Protobuf.FileDescriptorSet do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          file: [Google.Protobuf.FileDescriptorProto.t()]
        }

  defstruct [:file]

  field :file, 1, repeated: true, type: Google.Protobuf.FileDescriptorProto

  def transform_module(), do: nil
end

defmodule Google.Protobuf.FileDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          package: String.t(),
          dependency: [String.t()],
          public_dependency: [integer],
          weak_dependency: [integer],
          message_type: [Google.Protobuf.DescriptorProto.t()],
          enum_type: [Google.Protobuf.EnumDescriptorProto.t()],
          service: [Google.Protobuf.ServiceDescriptorProto.t()],
          extension: [Google.Protobuf.FieldDescriptorProto.t()],
          options: Google.Protobuf.FileOptions.t() | nil,
          source_code_info: Google.Protobuf.SourceCodeInfo.t() | nil,
          syntax: String.t()
        }

  defstruct [
    :name,
    :package,
    :dependency,
    :public_dependency,
    :weak_dependency,
    :message_type,
    :enum_type,
    :service,
    :extension,
    :options,
    :source_code_info,
    :syntax
  ]

  field :name, 1, optional: true, type: :string
  field :package, 2, optional: true, type: :string
  field :dependency, 3, repeated: true, type: :string
  field :public_dependency, 10, repeated: true, type: :int32
  field :weak_dependency, 11, repeated: true, type: :int32
  field :message_type, 4, repeated: true, type: Google.Protobuf.DescriptorProto
  field :enum_type, 5, repeated: true, type: Google.Protobuf.EnumDescriptorProto
  field :service, 6, repeated: true, type: Google.Protobuf.ServiceDescriptorProto
  field :extension, 7, repeated: true, type: Google.Protobuf.FieldDescriptorProto
  field :options, 8, optional: true, type: Google.Protobuf.FileOptions
  field :source_code_info, 9, optional: true, type: Google.Protobuf.SourceCodeInfo
  field :syntax, 12, optional: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.DescriptorProto.ExtensionRange do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          start: integer,
          end: integer,
          options: Google.Protobuf.ExtensionRangeOptions.t() | nil
        }

  defstruct [:start, :end, :options]

  field :start, 1, optional: true, type: :int32
  field :end, 2, optional: true, type: :int32
  field :options, 3, optional: true, type: Google.Protobuf.ExtensionRangeOptions

  def transform_module(), do: nil
end

defmodule Google.Protobuf.DescriptorProto.ReservedRange do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          start: integer,
          end: integer
        }

  defstruct [:start, :end]

  field :start, 1, optional: true, type: :int32
  field :end, 2, optional: true, type: :int32

  def transform_module(), do: nil
end

defmodule Google.Protobuf.DescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          field: [Google.Protobuf.FieldDescriptorProto.t()],
          extension: [Google.Protobuf.FieldDescriptorProto.t()],
          nested_type: [Google.Protobuf.DescriptorProto.t()],
          enum_type: [Google.Protobuf.EnumDescriptorProto.t()],
          extension_range: [Google.Protobuf.DescriptorProto.ExtensionRange.t()],
          oneof_decl: [Google.Protobuf.OneofDescriptorProto.t()],
          options: Google.Protobuf.MessageOptions.t() | nil,
          reserved_range: [Google.Protobuf.DescriptorProto.ReservedRange.t()],
          reserved_name: [String.t()]
        }

  defstruct [
    :name,
    :field,
    :extension,
    :nested_type,
    :enum_type,
    :extension_range,
    :oneof_decl,
    :options,
    :reserved_range,
    :reserved_name
  ]

  field :name, 1, optional: true, type: :string
  field :field, 2, repeated: true, type: Google.Protobuf.FieldDescriptorProto
  field :extension, 6, repeated: true, type: Google.Protobuf.FieldDescriptorProto
  field :nested_type, 3, repeated: true, type: Google.Protobuf.DescriptorProto
  field :enum_type, 4, repeated: true, type: Google.Protobuf.EnumDescriptorProto
  field :extension_range, 5, repeated: true, type: Google.Protobuf.DescriptorProto.ExtensionRange
  field :oneof_decl, 8, repeated: true, type: Google.Protobuf.OneofDescriptorProto
  field :options, 7, optional: true, type: Google.Protobuf.MessageOptions
  field :reserved_range, 9, repeated: true, type: Google.Protobuf.DescriptorProto.ReservedRange
  field :reserved_name, 10, repeated: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.ExtensionRangeOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:uninterpreted_option, :__pb_extensions__]

  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.FieldDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          number: integer,
          label: Google.Protobuf.FieldDescriptorProto.Label.t(),
          type: Google.Protobuf.FieldDescriptorProto.Type.t(),
          type_name: String.t(),
          extendee: String.t(),
          default_value: String.t(),
          oneof_index: integer,
          json_name: String.t(),
          options: Google.Protobuf.FieldOptions.t() | nil,
          proto3_optional: boolean
        }

  defstruct [
    :name,
    :number,
    :label,
    :type,
    :type_name,
    :extendee,
    :default_value,
    :oneof_index,
    :json_name,
    :options,
    :proto3_optional
  ]

  field :name, 1, optional: true, type: :string
  field :number, 3, optional: true, type: :int32
  field :label, 4, optional: true, type: Google.Protobuf.FieldDescriptorProto.Label, enum: true
  field :type, 5, optional: true, type: Google.Protobuf.FieldDescriptorProto.Type, enum: true
  field :type_name, 6, optional: true, type: :string
  field :extendee, 2, optional: true, type: :string
  field :default_value, 7, optional: true, type: :string
  field :oneof_index, 9, optional: true, type: :int32
  field :json_name, 10, optional: true, type: :string
  field :options, 8, optional: true, type: Google.Protobuf.FieldOptions
  field :proto3_optional, 17, optional: true, type: :bool

  def transform_module(), do: nil
end

defmodule Google.Protobuf.OneofDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          options: Google.Protobuf.OneofOptions.t() | nil
        }

  defstruct [:name, :options]

  field :name, 1, optional: true, type: :string
  field :options, 2, optional: true, type: Google.Protobuf.OneofOptions

  def transform_module(), do: nil
end

defmodule Google.Protobuf.EnumDescriptorProto.EnumReservedRange do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          start: integer,
          end: integer
        }

  defstruct [:start, :end]

  field :start, 1, optional: true, type: :int32
  field :end, 2, optional: true, type: :int32

  def transform_module(), do: nil
end

defmodule Google.Protobuf.EnumDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          value: [Google.Protobuf.EnumValueDescriptorProto.t()],
          options: Google.Protobuf.EnumOptions.t() | nil,
          reserved_range: [Google.Protobuf.EnumDescriptorProto.EnumReservedRange.t()],
          reserved_name: [String.t()]
        }

  defstruct [:name, :value, :options, :reserved_range, :reserved_name]

  field :name, 1, optional: true, type: :string
  field :value, 2, repeated: true, type: Google.Protobuf.EnumValueDescriptorProto
  field :options, 3, optional: true, type: Google.Protobuf.EnumOptions

  field :reserved_range, 4,
    repeated: true,
    type: Google.Protobuf.EnumDescriptorProto.EnumReservedRange

  field :reserved_name, 5, repeated: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.EnumValueDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          number: integer,
          options: Google.Protobuf.EnumValueOptions.t() | nil
        }

  defstruct [:name, :number, :options]

  field :name, 1, optional: true, type: :string
  field :number, 2, optional: true, type: :int32
  field :options, 3, optional: true, type: Google.Protobuf.EnumValueOptions

  def transform_module(), do: nil
end

defmodule Google.Protobuf.ServiceDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          method: [Google.Protobuf.MethodDescriptorProto.t()],
          options: Google.Protobuf.ServiceOptions.t() | nil
        }

  defstruct [:name, :method, :options]

  field :name, 1, optional: true, type: :string
  field :method, 2, repeated: true, type: Google.Protobuf.MethodDescriptorProto
  field :options, 3, optional: true, type: Google.Protobuf.ServiceOptions

  def transform_module(), do: nil
end

defmodule Google.Protobuf.MethodDescriptorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          input_type: String.t(),
          output_type: String.t(),
          options: Google.Protobuf.MethodOptions.t() | nil,
          client_streaming: boolean,
          server_streaming: boolean
        }

  defstruct [:name, :input_type, :output_type, :options, :client_streaming, :server_streaming]

  field :name, 1, optional: true, type: :string
  field :input_type, 2, optional: true, type: :string
  field :output_type, 3, optional: true, type: :string
  field :options, 4, optional: true, type: Google.Protobuf.MethodOptions
  field :client_streaming, 5, optional: true, type: :bool, default: false
  field :server_streaming, 6, optional: true, type: :bool, default: false

  def transform_module(), do: nil
end

defmodule Google.Protobuf.FileOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          java_package: String.t(),
          java_outer_classname: String.t(),
          java_multiple_files: boolean,
          java_generate_equals_and_hash: boolean,
          java_string_check_utf8: boolean,
          optimize_for: Google.Protobuf.FileOptions.OptimizeMode.t(),
          go_package: String.t(),
          cc_generic_services: boolean,
          java_generic_services: boolean,
          py_generic_services: boolean,
          php_generic_services: boolean,
          deprecated: boolean,
          cc_enable_arenas: boolean,
          objc_class_prefix: String.t(),
          csharp_namespace: String.t(),
          swift_prefix: String.t(),
          php_class_prefix: String.t(),
          php_namespace: String.t(),
          php_metadata_namespace: String.t(),
          ruby_package: String.t(),
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [
    :java_package,
    :java_outer_classname,
    :java_multiple_files,
    :java_generate_equals_and_hash,
    :java_string_check_utf8,
    :optimize_for,
    :go_package,
    :cc_generic_services,
    :java_generic_services,
    :py_generic_services,
    :php_generic_services,
    :deprecated,
    :cc_enable_arenas,
    :objc_class_prefix,
    :csharp_namespace,
    :swift_prefix,
    :php_class_prefix,
    :php_namespace,
    :php_metadata_namespace,
    :ruby_package,
    :uninterpreted_option,
    :__pb_extensions__
  ]

  field :java_package, 1, optional: true, type: :string
  field :java_outer_classname, 8, optional: true, type: :string
  field :java_multiple_files, 10, optional: true, type: :bool, default: false
  field :java_generate_equals_and_hash, 20, optional: true, type: :bool, deprecated: true
  field :java_string_check_utf8, 27, optional: true, type: :bool, default: false

  field :optimize_for, 9,
    optional: true,
    type: Google.Protobuf.FileOptions.OptimizeMode,
    default: :SPEED,
    enum: true

  field :go_package, 11, optional: true, type: :string
  field :cc_generic_services, 16, optional: true, type: :bool, default: false
  field :java_generic_services, 17, optional: true, type: :bool, default: false
  field :py_generic_services, 18, optional: true, type: :bool, default: false
  field :php_generic_services, 42, optional: true, type: :bool, default: false
  field :deprecated, 23, optional: true, type: :bool, default: false
  field :cc_enable_arenas, 31, optional: true, type: :bool, default: true
  field :objc_class_prefix, 36, optional: true, type: :string
  field :csharp_namespace, 37, optional: true, type: :string
  field :swift_prefix, 39, optional: true, type: :string
  field :php_class_prefix, 40, optional: true, type: :string
  field :php_namespace, 41, optional: true, type: :string
  field :php_metadata_namespace, 44, optional: true, type: :string
  field :ruby_package, 45, optional: true, type: :string
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.MessageOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          message_set_wire_format: boolean,
          no_standard_descriptor_accessor: boolean,
          deprecated: boolean,
          map_entry: boolean,
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [
    :message_set_wire_format,
    :no_standard_descriptor_accessor,
    :deprecated,
    :map_entry,
    :uninterpreted_option,
    :__pb_extensions__
  ]

  field :message_set_wire_format, 1, optional: true, type: :bool, default: false
  field :no_standard_descriptor_accessor, 2, optional: true, type: :bool, default: false
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :map_entry, 7, optional: true, type: :bool
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.FieldOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          ctype: Google.Protobuf.FieldOptions.CType.t(),
          packed: boolean,
          jstype: Google.Protobuf.FieldOptions.JSType.t(),
          lazy: boolean,
          deprecated: boolean,
          weak: boolean,
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [
    :ctype,
    :packed,
    :jstype,
    :lazy,
    :deprecated,
    :weak,
    :uninterpreted_option,
    :__pb_extensions__
  ]

  field :ctype, 1,
    optional: true,
    type: Google.Protobuf.FieldOptions.CType,
    default: :STRING,
    enum: true

  field :packed, 2, optional: true, type: :bool

  field :jstype, 6,
    optional: true,
    type: Google.Protobuf.FieldOptions.JSType,
    default: :JS_NORMAL,
    enum: true

  field :lazy, 5, optional: true, type: :bool, default: false
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :weak, 10, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.OneofOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:uninterpreted_option, :__pb_extensions__]

  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.EnumOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          allow_alias: boolean,
          deprecated: boolean,
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:allow_alias, :deprecated, :uninterpreted_option, :__pb_extensions__]

  field :allow_alias, 2, optional: true, type: :bool
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.EnumValueOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          deprecated: boolean,
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:deprecated, :uninterpreted_option, :__pb_extensions__]

  field :deprecated, 1, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.ServiceOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          deprecated: boolean,
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:deprecated, :uninterpreted_option, :__pb_extensions__]

  field :deprecated, 33, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.MethodOptions do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          deprecated: boolean,
          idempotency_level: Google.Protobuf.MethodOptions.IdempotencyLevel.t(),
          uninterpreted_option: [Google.Protobuf.UninterpretedOption.t()],
          __pb_extensions__: map
        }

  defstruct [:deprecated, :idempotency_level, :uninterpreted_option, :__pb_extensions__]

  field :deprecated, 33, optional: true, type: :bool, default: false

  field :idempotency_level, 34,
    optional: true,
    type: Google.Protobuf.MethodOptions.IdempotencyLevel,
    default: :IDEMPOTENCY_UNKNOWN,
    enum: true

  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption

  def transform_module(), do: nil

  extensions [{1000, 536_870_912}]
end

defmodule Google.Protobuf.UninterpretedOption.NamePart do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name_part: String.t(),
          is_extension: boolean
        }

  defstruct [:name_part, :is_extension]

  field :name_part, 1, required: true, type: :string
  field :is_extension, 2, required: true, type: :bool

  def transform_module(), do: nil
end

defmodule Google.Protobuf.UninterpretedOption do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: [Google.Protobuf.UninterpretedOption.NamePart.t()],
          identifier_value: String.t(),
          positive_int_value: non_neg_integer,
          negative_int_value: integer,
          double_value: float | :infinity | :negative_infinity | :nan,
          string_value: binary,
          aggregate_value: String.t()
        }

  defstruct [
    :name,
    :identifier_value,
    :positive_int_value,
    :negative_int_value,
    :double_value,
    :string_value,
    :aggregate_value
  ]

  field :name, 2, repeated: true, type: Google.Protobuf.UninterpretedOption.NamePart
  field :identifier_value, 3, optional: true, type: :string
  field :positive_int_value, 4, optional: true, type: :uint64
  field :negative_int_value, 5, optional: true, type: :int64
  field :double_value, 6, optional: true, type: :double
  field :string_value, 7, optional: true, type: :bytes
  field :aggregate_value, 8, optional: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.SourceCodeInfo.Location do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          path: [integer],
          span: [integer],
          leading_comments: String.t(),
          trailing_comments: String.t(),
          leading_detached_comments: [String.t()]
        }

  defstruct [:path, :span, :leading_comments, :trailing_comments, :leading_detached_comments]

  field :path, 1, repeated: true, type: :int32, packed: true
  field :span, 2, repeated: true, type: :int32, packed: true
  field :leading_comments, 3, optional: true, type: :string
  field :trailing_comments, 4, optional: true, type: :string
  field :leading_detached_comments, 6, repeated: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.SourceCodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          location: [Google.Protobuf.SourceCodeInfo.Location.t()]
        }

  defstruct [:location]

  field :location, 1, repeated: true, type: Google.Protobuf.SourceCodeInfo.Location

  def transform_module(), do: nil
end

defmodule Google.Protobuf.GeneratedCodeInfo.Annotation do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          path: [integer],
          source_file: String.t(),
          begin: integer,
          end: integer
        }

  defstruct [:path, :source_file, :begin, :end]

  field :path, 1, repeated: true, type: :int32, packed: true
  field :source_file, 2, optional: true, type: :string
  field :begin, 3, optional: true, type: :int32
  field :end, 4, optional: true, type: :int32

  def transform_module(), do: nil
end

defmodule Google.Protobuf.GeneratedCodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          annotation: [Google.Protobuf.GeneratedCodeInfo.Annotation.t()]
        }

  defstruct [:annotation]

  field :annotation, 1, repeated: true, type: Google.Protobuf.GeneratedCodeInfo.Annotation

  def transform_module(), do: nil
end
