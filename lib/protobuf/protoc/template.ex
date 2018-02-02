defmodule Protobuf.Protoc.Template do
  @msg_tmpl Path.expand("./templates/message.ex.eex", :code.priv_dir(:protobuf))
  @enum_tmpl Path.expand("./templates/enum.ex.eex", :code.priv_dir(:protobuf))
  @svc_tmpl Path.expand("./templates/service.ex.eex", :code.priv_dir(:protobuf))

  require EEx

  EEx.function_from_file(
    :def,
    :message,
    @msg_tmpl,
    [:name, :options, :struct_fields, :typespec, :oneofs, :fields],
    trim: true
  )

  EEx.function_from_file(:def, :enum, @enum_tmpl, [:name, :options, :fields], trim: true)
  EEx.function_from_file(:def, :service, @svc_tmpl, [:mod_name, :name, :methods], trim: true)
end
