defmodule Protobuf.Protoc.Parser do
  @moduledoc ""

  alias Protobuf.Protoc.Metadata
  alias Protobuf.Protoc.Utils

  defmodule Context do
    @moduledoc false
    defstruct package: "",
              syntax: "",

              # For one message
              namespace: []
  end

  @spec parse(Google.Protobuf.Compiler.CodeGeneratorRequest.t()) :: [Metadata.Package.t()]
  def parse(req) do
    :ets.new(__MODULE__, [:named_table, :set, :protected])
    context = %Context{}
    files = req.file_to_generate

    files =
      req.proto_file
      |> Enum.filter(fn desc -> Enum.member?(files, desc.name) end)
      |> Enum.map(fn desc -> parse_file(context, desc) end)

    files
    |> Enum.group_by(& &1.package)
    |> Enum.map(fn {pkg, files} ->
      pkg = %Metadata.Package{
        fqn: pkg,
        files: files
      }

      write_md(pkg, pkg)
      pkg
    end)
  end

  @spec parse_file(Context.t(), Google.Protobuf.FileDescriptorProto.t()) :: any
  defp parse_file(
         ctx,
         %Google.Protobuf.FileDescriptorProto{package: package, syntax: syntax, name: name} = desc
       ) do
    ctx = %{ctx | package: package, syntax: syntax(syntax)}

    msgs = Enum.map(desc.message_type, &parse_msg(ctx, package, &1))
    # result = Result.put_tree([package, name], file)
    msg_fqns = Enum.map(msgs, fn m -> m.fqn end)

    fqn = name

    # TODO: enums
    # TODO: services

    file = %Metadata.File{
      # desc: Map.put(desc, :source_code_info, nil),
      fqn: fqn,
      messages: msg_fqns,
      package: package
    }

    write_md(fqn, file)
    write_desc(fqn, desc)
    file
  end

  @spec parse_msg(Context.t(), String.t(), Google.Protobuf.DescriptorProto.t()) :: any
  defp parse_msg(%{namespace: ns} = ctx, file_fqn, desc) do
    fqn = Utils.join_name([file_fqn, desc.name])
    fields = Enum.map(desc.field, &parse_field(ctx, fqn, &1))
    field_fqns = Enum.map(fields, fn f -> f.fqn end)

    # TODO: enums
    # TODO: oneof
    # TODO: nested messages
    # new_ctx = %{ctx | namespace: ns ++ [desc.name]}

    msg = %Metadata.Message{
      namespace: Utils.join_name(ns),
      fqn: fqn,
      # desc: Map.put(desc, :source_code_info, nil),
      file: file_fqn,
      fields: field_fqns
    }

    write_md(fqn, msg)
    write_desc(fqn, desc)
    msg
  end

  @spec parse_field(Context.t(), String.t(), Google.Protobuf.FieldDescriptorProto.t()) :: any
  defp parse_field(_ctx, msg_fqn, %{name: name} = desc) do
    fqn = Utils.join_name([msg_fqn, name])

    field = %Metadata.Field{
      # desc: Map.put(desc, :source_code_info, nil),
      fqn: fqn,
      message: msg_fqn
    }

    write_md(fqn, field)
    write_desc(fqn, desc)
    field
  end

  defp syntax("proto3"), do: :proto3
  defp syntax("proto2"), do: :proto2

  defp write_md(fqn, md) do
    :ets.insert_new(__MODULE__, {{:metadata, fqn}, md})
  end

  defp write_desc(fqn, desc) do
    # For easy to debug. source_code_info is massy
    desc = Map.put(desc, :source_code_info, nil)
    :ets.insert_new(__MODULE__, {{:desc, fqn}, desc})
  end
end
