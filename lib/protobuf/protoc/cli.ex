defmodule Protobuf.Protoc.CLI do
  def main(_) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI
    :io.setopts(:standard_io, encoding: :latin1)
    bin = IO.binread(:all)
    response = run(bin)

    IO.binwrite(Protobuf.Encoder.encode(response))
  end

  def run(bin) do
    Protobuf.Extensions.init()

    do_run(bin, false)
  end

  # do_run with `run_extensions = false` will generate all protobufs and then re-run
  # after loading those protobufs. This is a requirement for extensions.
  # do_run with `run_extensions = true` will assume all extensions are already loaded into code
  defp do_run(bin, run_extensions) do
    request = Protobuf.Decoder.decode(bin, Google.Protobuf.Compiler.CodeGeneratorRequest, run_extensions)
    # debug
    # raise inspect(request, limit: :infinity)
    ctx = %Protobuf.Protoc.Context{}
    ctx = parse_params(ctx, request.parameter)
    ctx = find_package_names(ctx, request.proto_file)

    if not run_extensions do
      for desc <- request.proto_file do
        content = Protobuf.Protoc.Generator.generate(ctx, desc).content

        Code.eval_string(content)
      end

      do_run(bin, true)
    else
      files = request.proto_file
        |> Enum.filter(fn(desc) -> Enum.member?(request.file_to_generate, desc.name) end)
        |> Enum.map(fn(desc) -> Protobuf.Protoc.Generator.generate(ctx, desc) end)

      Google.Protobuf.Compiler.CodeGeneratorResponse.new(file: files)
    end
  end

  def parse_params(ctx, params_str) when is_binary(params_str) do
    params = String.split(params_str, ",")
    parse_params(ctx, params)
  end
  def parse_params(ctx, ["plugins=" <> plugins|t]) do
    plugins = String.split(plugins, "+")
    ctx = %{ctx|plugins: plugins}
    parse_params(ctx, t)
  end
  def parse_params(ctx, _), do: ctx

  defp find_package_names(ctx, descs) do
    find_package_names(ctx, descs, %{})
  end
  defp find_package_names(ctx, [], acc), do: %{ctx|pkg_mapping: acc}
  defp find_package_names(ctx, [desc|t], acc) do
    find_package_names(ctx, t, Map.put(acc, desc.name, desc.package))
  end
end
