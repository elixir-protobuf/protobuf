defmodule Protobuf.Application do
  use Application

  def start(_type, _args) do
    mods = get_all_modules()
    Protobuf.Extension.cal_extensions(mods)

    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp get_all_modules() do
    case :code.get_mode() do
      :embedded ->
        :erlang.loaded()

      :interactive ->
        for {app, _, _} <- Application.loaded_applications() do
          {:ok, modules} = :application.get_key(app, :modules)
          modules
        end
        |> Enum.concat()
    end
  end
end
