defmodule Google.Protobuf.FieldDescriptor do
  def has_presence?() do
  end

  def has_optional_keyword?() do
  end
end

defmodule Google.Protobuf.OneofDescriptor do
  def is_synthetic?(%Google.Protobuf.FieldDescriptorProto{proto3_optional: proto3_optional}) do
    proto3_optional
  end

  def is_synthetic?(_), do: "Invalid field"
end

defmodule Google.Protobuf.Descriptor do
  def real_containing_oneof() do
  end
end
