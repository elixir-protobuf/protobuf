defmodule Google.Protobuf.Compiler.Version do
  use Protobuf

  defstruct [:major, :minor, :patch, :suffix]

  field :major, 1, optional: true, type: :int32
  field :minor, 2, optional: true, type: :int32
  field :patch, 3, optional: true, type: :int32
  field :suffix, 4, optional: true, type: :string
end

defmodule Google.Protobuf.Compiler.CodeGeneratorRequest do
  use Protobuf

  defstruct [:file_to_generate, :parameter, :proto_file, :compiler_version]

  field :file_to_generate, 1, repeated: true, type: :string
  field :parameter, 2, optional: true, type: :string
  field :proto_file, 15, repeated: true, type: Google.Protobuf.FileDescriptorProto
  field :compiler_version, 3, optional: true, type: Google.Protobuf.Compiler.Version
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse do
  use Protobuf

  defstruct [:error, :file]

  field :error, 1, optional: true, type: :string
  field :file, 15, repeated: true, type: Google.Protobuf.Compiler.CodeGeneratorResponse_File
end

defmodule Google.Protobuf.Compiler.CodeGeneratorResponse_File do
  use Protobuf

  defstruct [:name, :insertion_point, :content]

  field :name, 1, optional: true, type: :string
  field :insertion_point, 2, optional: true, type: :string
  field :content, 15, optional: true, type: :string
end
