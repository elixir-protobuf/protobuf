defmodule Conformance.Protobuf.Runner do
  @moduledoc false

  @stdin_read_timeout 3000

  @spec main() :: :ok
  def main() do
    if System.otp_release() >= "25" do
      IO.puts(:stderr, """
      It seems like conformance tests are broken on OTP 25 due to some memory leak
      for some specific payloads. You can take a look at a couple of regression tests
      related to this in: test/protobuf/conformance_regressions_test.exs

      Also take a look at these:
        * https://github.com/elixir-protobuf/protobuf/commit/19eeb0ebd17af23f4625445404a5c756675660aa
        * https://github.com/elixir-protobuf/protobuf/commit/11e1b40a6eaa51b4d2872feaee809e2834bb9b9b#diff-5ea66cbe2186e1e3db8d8bf8e5f117a060e2fa87df3e48dbc182e55af10bef70

      """)

      System.halt(1)
    end

    # Log things to stderr so that they don't interfere with the stdin/stdout interface
    # of the conformance runner.
    Logger.configure_backend(:console, device: :standard_error)

    # Force encoding on stdio.
    :ok = :io.setopts(:standard_io, binary: true, encoding: :latin1)

    loop()
  end

  defp loop() do
    case read_bytes(:stdio, 4, @stdin_read_timeout) do
      :eof ->
        :ok

      {:error, reason} ->
        raise "failed to read 4-bytes header: #{inspect(reason)}"

      <<len::unsigned-little-32>> ->
        case read_bytes(:stdio, len, @stdin_read_timeout) do
          :eof ->
            raise "received unexpected EOF when expecting #{len} bytes"

          {:error, reason} ->
            raise "failed to read #{len} bytes from stdio: #{inspect(reason)}"

          encoded_request when byte_size(encoded_request) == len ->
            mod = Conformance.ConformanceResponse
            response = mod.new!(result: handle_encoded_request(encoded_request))

            encoded_response = Protobuf.encode(response)

            iodata_to_write = [
              <<IO.iodata_length(encoded_response)::unsigned-little-32>>,
              encoded_response
            ]

            :ok = IO.binwrite(:stdio, iodata_to_write)

            loop()
        end
    end
  end

  defp read_bytes(device, count, timeout) do
    task = Task.async(fn -> IO.binread(device, count) end)

    case Task.yield(task, timeout) || Task.shutdown(task) do
      {:ok, bytes} -> bytes
      {:exit, reason} -> raise "failed to read bytes from stdio: #{inspect(reason)}"
      nil -> raise "failed to read bytes from stdio, timed out"
    end
  end

  defp handle_encoded_request(encoded_request) do
    case safe_decode(encoded_request, Conformance.ConformanceRequest) do
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
