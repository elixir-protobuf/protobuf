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
    if Application.get_env(:protobuf, :extensions, :disabled) == :enabled do
      mods = get_all_modules()
      Protobuf.Extension.__cal_extensions__(mods)
    else
      # Extensions in Protobuf should always be calculated for generating code
      {:ok, mods} = :application.get_key(:protobuf, :modules)
      Protobuf.Extension.__cal_extensions__(mods)
    end

    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  @impl true
  def stop(_state) do
    Protobuf.Extension.__unload_extensions__()
    :ok
  end

  defp get_all_modules() do
    case :code.get_mode() do
      :embedded ->
        :erlang.loaded()

      :interactive ->
        Enum.flat_map(Application.loaded_applications(), fn {app, _desc, _vsn} ->
          {:ok, modules} = :application.get_key(app, :modules)
          modules
        end)
    end
  end
end
