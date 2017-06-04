defmodule Protobuf.Protoc.Template do
  @msg_tmpl Path.expand("./templates/message.ex.eex", :code.priv_dir(:protobuf))

  require EEx
  EEx.function_from_file :def, :message, @msg_tmpl, [:name, :struct_fields, :fields], trim: true
end
