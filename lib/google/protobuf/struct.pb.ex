defmodule Google.Protobuf.NullValue do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  field :NULL_VALUE, 0
end

defmodule Google.Protobuf.Struct.FieldsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: Google.Protobuf.Value
end

defmodule Google.Protobuf.Struct do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  field :fields, 1, repeated: true, type: Google.Protobuf.Struct.FieldsEntry, map: true
end

defmodule Google.Protobuf.Value do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  oneof :kind, 0

  field :null_value, 1,
    type: Google.Protobuf.NullValue,
    json_name: "nullValue",
    enum: true,
    oneof: 0

  field :number_value, 2, type: :double, json_name: "numberValue", oneof: 0
  field :string_value, 3, type: :string, json_name: "stringValue", oneof: 0
  field :bool_value, 4, type: :bool, json_name: "boolValue", oneof: 0
  field :struct_value, 5, type: Google.Protobuf.Struct, json_name: "structValue", oneof: 0
  field :list_value, 6, type: Google.Protobuf.ListValue, json_name: "listValue", oneof: 0
end

defmodule Google.Protobuf.ListValue do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.13.0", syntax: :proto3

  field :values, 1, repeated: true, type: Google.Protobuf.Value
end
