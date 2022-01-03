defmodule Conformance.Protobuf.Runner do
  @moduledoc false

  def main(_args) do
    Logger.configure_backend(:console, device: :standard_error)
    :io.setopts(:standard_io, encoding: :latin1)
    IO.puts(:stderr, "Starting runner")
    loop()
  end

  defp loop() do
    case IO.inspect(:stderr, IO.binread(:stdio, 4), label: "Read 4 bytes stdin") do
      :eof ->
        :ok

      {:error, reason} ->
        raise "failed to read 4-bytes header: #{inspect(reason)}"

      <<len::unsigned-little-32>> ->
        case IO.inspect(:stderr, IO.binread(:stdio, len), label: "Read #{len} butes stdin") do
          :eof ->
            raise "received unexpected EOF when expecting #{len} bytes"

          {:error, reason} ->
            raise "failed to read #{len} bytes from stdio: #{inspect(reason)}"

          encoded_request ->
            mod = Conformance.ConformanceResponse
            result = handle_encoded_request(encoded_request)
            response = mod.new(result: result)

            IO.inspect(:stderr, response, label: "Response")

            encoded_response = Protobuf.encode(response)

            :ok =
              IO.binwrite(
                :stdio,
                [<<IO.iodata_length(encoded_response)::unsigned-little-32>>, encoded_response]
              )

            IO.puts(:stderr, "Wrote encoded response back on the wire")

            loop()
        end
    end
  end

  defp handle_encoded_request(encoded_request) do
    case IO.inspect(:stderr, safe_decode(encoded_request, Conformance.ConformanceRequest),
           label: "Decoded req"
         ) do
      {:ok, request} ->
        handle_conformance_request(request)

      {:error, exception, stacktrace} ->
        message = Exception.format(:error, exception, stacktrace)
        {:runtime_error, "failed to decode conformance request: #{message}"}
    end
  end

  # We need to keep "mod" dynamic here because we generate the .pb.ex files for
  # Conformance.ConformanceRequest after compiling this file.
  defp handle_conformance_request(%mod{
         requested_output_format: requested_output_format,
         message_type: message_type,
         payload: {payload_kind, msg}
       })
       when mod == Conformance.ConformanceRequest and
              requested_output_format in [:PROTOBUF, :JSON] and
              payload_kind in [:protobuf_payload, :json_payload] do
    test_proto_type = to_test_proto_type(message_type)

    decode_fun =
      case payload_kind do
        :protobuf_payload -> &safe_decode/2
        :json_payload -> &Protobuf.JSON.decode/2
      end

    {encode_fun, output_payload_kind} =
      case requested_output_format do
        :PROTOBUF -> {&safe_encode/1, :protobuf_payload}
        :JSON -> {&Protobuf.JSON.encode/1, :json_payload}
      end

    with {:decode, {:ok, decoded_msg}} <- {:decode, decode_fun.(msg, test_proto_type)},
         {:encode, {:ok, encoded_msg}} <- {:encode, encode_fun.(decoded_msg)} do
      {output_payload_kind, encoded_msg}
    else
      {:decode, {:error, exception, stacktrace}} ->
        {:parse_error, Exception.format(:error, exception, stacktrace)}

      {:encode, {:error, exception, stacktrace}} ->
        {:serialize_error, Exception.format(:error, exception, stacktrace)}

      {:decode, {:error, exception}} ->
        {:parse_error, Exception.format(:error, exception, [])}

      {:encode, {:error, exception}} ->
        {:serialize_error, Exception.format(:error, exception, [])}
    end
  end

  defp handle_conformance_request(_request) do
    {:skipped, "unsupported conformance test"}
  end

  defp to_test_proto_type("protobuf_test_messages.proto3.TestAllTypesProto3"),
    do: ProtobufTestMessages.Proto3.TestAllTypesProto3

  defp to_test_proto_type("protobuf_test_messages.proto2.TestAllTypesProto2"),
    do: ProtobufTestMessages.Proto2.TestAllTypesProto2

  defp to_test_proto_type("conformance.FailureSet"), do: Conformance.FailureSet
  defp to_test_proto_type(""), do: ProtobufTestMessages.Proto3.TestAllTypesProto3

  defp safe_decode(binary, proto_type) do
    {:ok, proto_type.decode(binary)}
  rescue
    exception -> {:error, exception, __STACKTRACE__}
  end

  defp safe_encode(%mod{} = struct) do
    {:ok, mod.encode(struct)}
  rescue
    exception -> {:error, exception, __STACKTRACE__}
  end
end
