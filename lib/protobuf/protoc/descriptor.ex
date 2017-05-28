defmodule Google.Protobuf.FileDescriptorSet do
  use Protobuf

  defstruct [:file]

  field :file, 1, repeated: true, type: Google.Protobuf.FileDescriptorProto
end

defmodule Google.Protobuf.FileDescriptorProto do
  use Protobuf

  defstruct [:name, :package, :dependency, :public_dependency, :weak_dependency, :message_type, :enum_type, :service, :extension, :options, :source_code_info, :syntax]

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
end

defmodule Google.Protobuf.DescriptorProto do
  use Protobuf

  defstruct [:name, :field, :extension, :nested_type, :enum_type, :extension_range, :oneof_decl, :options, :reserved_range, :reserved_name]

  field :name, 1, optional: true, type: :string
  field :field, 2, repeated: true, type: Google.Protobuf.FieldDescriptorProto
  field :extension, 6, repeated: true, type: Google.Protobuf.FieldDescriptorProto
  field :nested_type, 3, repeated: true, type: Google.Protobuf.DescriptorProto
  field :enum_type, 4, repeated: true, type: Google.Protobuf.EnumDescriptorProto
  field :extension_range, 5, repeated: true, type: Google.Protobuf.DescriptorProto_ExtensionRange
  field :oneof_decl, 8, repeated: true, type: Google.Protobuf.OneofDescriptorProto
  field :options, 7, optional: true, type: Google.Protobuf.MessageOptions
  field :reserved_range, 9, repeated: true, type: Google.Protobuf.DescriptorProto_ReservedRange
  field :reserved_name, 10, repeated: true, type: :string
end

defmodule Google.Protobuf.DescriptorProto_ExtensionRange do
  use Protobuf

  defstruct [:start, :end]

  field :start, 1, optional: true, type: :int32
  field :end, 2, optional: true, type: :int32
end

defmodule Google.Protobuf.DescriptorProto_ReservedRange do
  use Protobuf

  defstruct [:start, :end]

  field :start, 1, optional: true, type: :int32
  field :end, 2, optional: true, type: :int32
end

defmodule Google.Protobuf.FieldDescriptorProto do
  use Protobuf

  defstruct [:name, :number, :label, :type, :type_name, :extendee, :default_value, :oneof_index, :json_name, :options]

  field :name, 1, optional: true, type: :string
  field :number, 3, optional: true, type: :int32
  field :label, 4, optional: true, type: Google.Protobuf.FieldDescriptorProto_Label, enum: true
  field :type, 5, optional: true, type: Google.Protobuf.FieldDescriptorProto_Type, enum: true
  field :type_name, 6, optional: true, type: :string
  field :extendee, 2, optional: true, type: :string
  field :default_value, 7, optional: true, type: :string
  field :oneof_index, 9, optional: true, type: :int32
  field :json_name, 10, optional: true, type: :string
  field :options, 8, optional: true, type: Google.Protobuf.FieldOptions
end

defmodule Google.Protobuf.FieldDescriptorProto_Type do
  use Protobuf, enum: true

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

defmodule Google.Protobuf.FieldDescriptorProto_Label do
  use Protobuf, enum: true

  field :LABEL_OPTIONAL, 1
  field :LABEL_REQUIRED, 2
  field :LABEL_REPEATED, 3
end

defmodule Google.Protobuf.OneofDescriptorProto do
  use Protobuf

  defstruct [:name, :options]

  field :name, 1, optional: true, type: :string
  field :options, 2, optional: true, type: Google.Protobuf.OneofOptions
end

defmodule Google.Protobuf.EnumDescriptorProto do
  use Protobuf

  defstruct [:name, :value, :options]

  field :name, 1, optional: true, type: :string
  field :value, 2, repeated: true, type: Google.Protobuf.EnumValueDescriptorProto
  field :options, 3, optional: true, type: Google.Protobuf.EnumOptions
end

defmodule Google.Protobuf.EnumValueDescriptorProto do
  use Protobuf

  defstruct [:name, :number, :options]

  field :name, 1, optional: true, type: :string
  field :number, 2, optional: true, type: :int32
  field :options, 3, optional: true, type: Google.Protobuf.EnumValueOptions
end

defmodule Google.Protobuf.ServiceDescriptorProto do
  use Protobuf

  defstruct [:name, :method, :options]

  field :name, 1, optional: true, type: :string
  field :method, 2, repeated: true, type: Google.Protobuf.MethodDescriptorProto
  field :options, 3, optional: true, type: Google.Protobuf.ServiceOptions
end

defmodule Google.Protobuf.MethodDescriptorProto do
  use Protobuf

  defstruct [:name, :input_type, :output_type, :options, :client_streaming, :server_streaming]

  field :name, 1, optional: true, type: :string
  field :input_type, 2, optional: true, type: :string
  field :output_type, 3, optional: true, type: :string
  field :options, 4, optional: true, type: Google.Protobuf.MethodOptions
  field :client_streaming, 5, optional: true, type: :bool, default: false
  field :server_streaming, 6, optional: true, type: :bool, default: false
end

defmodule Google.Protobuf.FileOptions do
  use Protobuf

  defstruct [:java_package, :java_outer_classname, :java_multiple_files, :java_generate_equals_and_hash, :java_string_check_utf8, :optimize_for, :go_package, :cc_generic_services, :java_generic_services, :py_generic_services, :deprecated, :cc_enable_arenas, :objc_class_prefix, :csharp_namespace, :swift_prefix, :uninterpreted_option]

  field :java_package, 1, optional: true, type: :string
  field :java_outer_classname, 8, optional: true, type: :string
  field :java_multiple_files, 10, optional: true, type: :bool, default: false
  field :java_generate_equals_and_hash, 20, optional: true, type: :bool, deprecated: true
  field :java_string_check_utf8, 27, optional: true, type: :bool, default: false
  field :optimize_for, 9, optional: true, type: Google.Protobuf.FileOptions_OptimizeMode, default: SPEED, enum: true
  field :go_package, 11, optional: true, type: :string
  field :cc_generic_services, 16, optional: true, type: :bool, default: false
  field :java_generic_services, 17, optional: true, type: :bool, default: false
  field :py_generic_services, 18, optional: true, type: :bool, default: false
  field :deprecated, 23, optional: true, type: :bool, default: false
  field :cc_enable_arenas, 31, optional: true, type: :bool, default: false
  field :objc_class_prefix, 36, optional: true, type: :string
  field :csharp_namespace, 37, optional: true, type: :string
  field :swift_prefix, 39, optional: true, type: :string
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.FileOptions_OptimizeMode do
  use Protobuf, enum: true

  field :SPEED, 1
  field :CODE_SIZE, 2
  field :LITE_RUNTIME, 3
end

defmodule Google.Protobuf.MessageOptions do
  use Protobuf

  defstruct [:message_set_wire_format, :no_standard_descriptor_accessor, :deprecated, :map_entry, :uninterpreted_option]

  field :message_set_wire_format, 1, optional: true, type: :bool, default: false
  field :no_standard_descriptor_accessor, 2, optional: true, type: :bool, default: false
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :map_entry, 7, optional: true, type: :bool
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.FieldOptions do
  use Protobuf

  defstruct [:ctype, :packed, :jstype, :lazy, :deprecated, :weak, :uninterpreted_option]

  field :ctype, 1, optional: true, type: Google.Protobuf.FieldOptions_CType, default: STRING, enum: true
  field :packed, 2, optional: true, type: :bool
  field :jstype, 6, optional: true, type: Google.Protobuf.FieldOptions_JSType, default: JS_NORMAL, enum: true
  field :lazy, 5, optional: true, type: :bool, default: false
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :weak, 10, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.FieldOptions_CType do
  use Protobuf, enum: true

  field :STRING, 0
  field :CORD, 1
  field :STRING_PIECE, 2
end

defmodule Google.Protobuf.FieldOptions_JSType do
  use Protobuf, enum: true

  field :JS_NORMAL, 0
  field :JS_STRING, 1
  field :JS_NUMBER, 2
end

defmodule Google.Protobuf.OneofOptions do
  use Protobuf

  defstruct [:uninterpreted_option]

  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.EnumOptions do
  use Protobuf

  defstruct [:allow_alias, :deprecated, :uninterpreted_option]

  field :allow_alias, 2, optional: true, type: :bool
  field :deprecated, 3, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.EnumValueOptions do
  use Protobuf

  defstruct [:deprecated, :uninterpreted_option]

  field :deprecated, 1, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.ServiceOptions do
  use Protobuf

  defstruct [:deprecated, :uninterpreted_option]

  field :deprecated, 33, optional: true, type: :bool, default: false
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.MethodOptions do
  use Protobuf

  defstruct [:deprecated, :idempotency_level, :uninterpreted_option]

  field :deprecated, 33, optional: true, type: :bool, default: false
  field :idempotency_level, 34, optional: true, type: Google.Protobuf.MethodOptions_IdempotencyLevel, default: IDEMPOTENCY_UNKNOWN, enum: true
  field :uninterpreted_option, 999, repeated: true, type: Google.Protobuf.UninterpretedOption
end

defmodule Google.Protobuf.MethodOptions_IdempotencyLevel do
  use Protobuf, enum: true

  field :IDEMPOTENCY_UNKNOWN, 0
  field :NO_SIDE_EFFECTS, 1
  field :IDEMPOTENT, 2
end

defmodule Google.Protobuf.UninterpretedOption do
  use Protobuf

  defstruct [:name, :identifier_value, :positive_int_value, :negative_int_value, :double_value, :string_value, :aggregate_value]

  field :name, 2, repeated: true, type: Google.Protobuf.UninterpretedOption_NamePart
  field :identifier_value, 3, optional: true, type: :string
  field :positive_int_value, 4, optional: true, type: :uint64
  field :negative_int_value, 5, optional: true, type: :int64
  field :double_value, 6, optional: true, type: :double
  field :string_value, 7, optional: true, type: :bytes
  field :aggregate_value, 8, optional: true, type: :string
end

defmodule Google.Protobuf.UninterpretedOption_NamePart do
  use Protobuf

  defstruct [:name_part, :is_extension]

  field :name_part, 1, required: true, type: :string
  field :is_extension, 2, required: true, type: :bool
end

defmodule Google.Protobuf.SourceCodeInfo do
  use Protobuf

  defstruct [:location]

  field :location, 1, repeated: true, type: Google.Protobuf.SourceCodeInfo_Location
end

defmodule Google.Protobuf.SourceCodeInfo_Location do
  use Protobuf

  defstruct [:path, :span, :leading_comments, :trailing_comments, :leading_detached_comments]

  field :path, 1, repeated: true, type: :int32, packed: true
  field :span, 2, repeated: true, type: :int32, packed: true
  field :leading_comments, 3, optional: true, type: :string
  field :trailing_comments, 4, optional: true, type: :string
  field :leading_detached_comments, 6, repeated: true, type: :string
end

defmodule Google.Protobuf.GeneratedCodeInfo do
  use Protobuf

  defstruct [:annotation]

  field :annotation, 1, repeated: true, type: Google.Protobuf.GeneratedCodeInfo_Annotation
end

defmodule Google.Protobuf.GeneratedCodeInfo_Annotation do
  use Protobuf

  defstruct [:path, :source_file, :begin, :end]

  field :path, 1, repeated: true, type: :int32, packed: true
  field :source_file, 2, optional: true, type: :string
  field :begin, 3, optional: true, type: :int32
  field :end, 4, optional: true, type: :int32
end