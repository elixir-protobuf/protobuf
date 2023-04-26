defmodule Google.Protobuf.Compiler.CodeGeneratorResponse.Feature do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :FEATURE_NONE, 0
  field :FEATURE_PROTO3_OPTIONAL, 1
end

defmodule Google.Protobuf.Compiler.Version do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :major, 1, optional: true, type: :int32
  field :minor, 2, optional: true, type: :int32
  field :patch, 3, optional: true, type: :int32
  field :suffix, 4, optional: true, type: :string
end

defmodule Google.Protobuf.Compiler.CodeGeneratorRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :file_to_generate, 1, repeated: true, type: :string
  field :parameter, 2, optional: true, type: :string
  field :proto_file, 15, repeated: true, type: Google.Protobuf.FileDescriptorProto
  field :compiler_version, 3, optional: true, type: Google.Protobuf.Compiler.Version
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse.File do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :name, 1, optional: true, type: :string
  field :insertion_point, 2, optional: true, type: :string
  field :content, 15, optional: true, type: :string
  field :generated_code_info, 16, optional: true, type: Google.Protobuf.GeneratedCodeInfo
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto2

  field :error, 1, optional: true, type: :string
  field :supported_features, 2, optional: true, type: :uint64
  field :file, 15, repeated: true, type: Google.Protobuf.Compiler.CodeGeneratorResponse.File
end
