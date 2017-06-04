defmodule Protobuf.Protoc.CLI do
  def main(args) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/T5enez_BBTI
    :io.setopts(:standard_io, encoding: :latin1)
    bin = IO.binread(:all)
    request = Protobuf.Decoder.decode(bin, Google_Protobuf_Compiler.CodeGeneratorRequest)
    files = Enum.map request.proto_file, fn(desc) ->
      Protobuf.Protoc.Generator.generate(desc)
    end
    response = %Google_Protobuf_Compiler.CodeGeneratorResponse{file: files}
    IO.binwrite(Protobuf.Encoder.encode(response))
  end
end
