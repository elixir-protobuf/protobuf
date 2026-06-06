defmodule Protobuf.Protoc.EscriptConfigTest do
  use ExUnit.Case, async: true

  # Regression test for https://github.com/elixir-protobuf/protobuf/issues/420
  #
  # protoc feeds the protoc-gen-elixir plugin a serialized CodeGeneratorRequest on
  # stdin. That binary routinely contains bytes that are invalid UTF-8 (protobuf
  # varint length prefixes such as 0xa1). Starting with OTP 26, the standard_io
  # device defaults to unicode mode, and reading those bytes back raises
  #
  #     {:no_translation, :unicode, :latin1}
  #
  # unless the VM is told to use latin1 for standard IO. Whether the crash triggers
  # depends on where the first non-ASCII byte lands relative to the first read chunk,
  # which is why the bug appears to depend on the .proto file name.
  #
  # The robust fix is to start the escript's VM with
  # `-kernel standard_io_encoding latin1` on every affected OTP release, so stdin is
  # read as raw bytes without any unicode -> latin1 translation.
  describe "escript emu_args" do
    test "force latin1 standard_io encoding on OTP >= 26 (issue #420)" do
      emu_args = Mix.Project.config()[:escript][:emu_args]
      otp_release = String.to_integer(System.otp_release())

      if otp_release >= 26 do
        assert emu_args =~ "standard_io_encoding latin1", """
        Expected the protoc-gen-elixir escript to start the VM with \
        `-kernel standard_io_encoding latin1` on OTP #{otp_release}.

        Without it, reading protoc's CodeGeneratorRequest from stdin can crash with
        {:no_translation, :unicode, :latin1} (issue #420).

        Got emu_args: #{inspect(emu_args)}
        """
      end
    end
  end
end
