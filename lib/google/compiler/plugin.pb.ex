defmodule Google.Protobuf.Compiler.CodeGeneratorResponse.Feature do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2
  @type t :: integer | :FEATURE_NONE | :FEATURE_PROTO3_OPTIONAL

  field :FEATURE_NONE, 0
  field :FEATURE_PROTO3_OPTIONAL, 1
end

defmodule Google.Protobuf.Compiler.Version do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          major: integer,
          minor: integer,
          patch: integer,
          suffix: String.t()
        }

  defstruct [:major, :minor, :patch, :suffix]

  field :major, 1, optional: true, type: :int32
  field :minor, 2, optional: true, type: :int32
  field :patch, 3, optional: true, type: :int32
  field :suffix, 4, optional: true, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Compiler.CodeGeneratorRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          file_to_generate: [String.t()],
          parameter: String.t(),
          proto_file: [Google.Protobuf.FileDescriptorProto.t()],
          compiler_version: Google.Protobuf.Compiler.Version.t() | nil
        }

  defstruct [:file_to_generate, :parameter, :proto_file, :compiler_version]

  field :file_to_generate, 1, repeated: true, type: :string
  field :parameter, 2, optional: true, type: :string
  field :proto_file, 15, repeated: true, type: Google.Protobuf.FileDescriptorProto
  field :compiler_version, 3, optional: true, type: Google.Protobuf.Compiler.Version

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse.File do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          insertion_point: String.t(),
          content: String.t(),
          generated_code_info: Google.Protobuf.GeneratedCodeInfo.t() | nil
        }

  defstruct [:name, :insertion_point, :content, :generated_code_info]

  field :name, 1, optional: true, type: :string
  field :insertion_point, 2, optional: true, type: :string
  field :content, 15, optional: true, type: :string
  field :generated_code_info, 16, optional: true, type: Google.Protobuf.GeneratedCodeInfo

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          error: String.t(),
          supported_features: non_neg_integer,
          file: [Google.Protobuf.Compiler.CodeGeneratorResponse.File.t()]
        }

  defstruct [:error, :supported_features, :file]

  field :error, 1, optional: true, type: :string
  field :supported_features, 2, optional: true, type: :uint64
  field :file, 15, repeated: true, type: Google.Protobuf.Compiler.CodeGeneratorResponse.File

  def transform_module(), do: nil
end
