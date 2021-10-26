defmodule Protobuf.Application do
  use Application

  @moduledoc """
  When extensions feature is enabled, all modules are scanned to fetch
  runtime information for extensions, see `Protobuf.Extension` for details.

  No children are created now.
  """

  @doc false
  @impl true
  def start(_type, _args) do
    # TODO: Deprecate automatically loading modules, in favor of Protobuf.load_extensions/0
    Protobuf.Extension.__cal_extensions__()

    Supervisor.start_link(_children = [], strategy: :one_for_one)
  end

  @doc false
  @impl true
  def stop(_state) do
    Protobuf.Extension.__unload_extensions__()
    :ok
  end
end
