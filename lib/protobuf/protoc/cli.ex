defmodule Protobuf.Protoc.CLI do
  def main(_) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI
    :io.setopts(:standard_io, encoding: :latin1)
    bin = IO.binread(:all)
    request = Protobuf.Decoder.decode(bin, Google_Protobuf_Compiler.CodeGeneratorRequest)
    ctx = %Protobuf.Protoc.Context{}
    ctx = parse_params(ctx, request.parameter)
    files = Enum.map request.proto_file, fn(desc) ->
      Protobuf.Protoc.Generator.generate(ctx, desc)
    end
    response = %Google_Protobuf_Compiler.CodeGeneratorResponse{file: files}
    IO.binwrite(Protobuf.Encoder.encode(response))
  end

  def parse_params(ctx, nil), do: ctx
  def parse_params(ctx, params_str) when is_binary(params_str) do
    params = String.split(params_str, ",")
    parse_params(ctx, params)
  end
  def parse_params(ctx, ["plugins=" <> plugins|t]) do
    plugins = String.split(plugins, "+")
    ctx = %{ctx|plugins: plugins}
    parse_params(ctx, t)
  end
  def parse_params(ctx, []), do: ctx
end
