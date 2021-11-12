ExUnit.configure(exclude: [integration: true])
ExUnit.start()

Protobuf.load_extensions()

defmodule Protobuf.TestHelpers do
  def purge_modules(modules) when is_list(modules) do
    Enum.each(modules, fn mod ->
      :code.delete(mod)
      :code.purge(mod)
    end)
  end

  # TODO: Remove when we depend on Elixir 1.11+.
  def tmp_dir(context) do
    dir_name =
      "#{inspect(context[:case])}#{context[:describe]}#{context[:test]}"
      |> String.downcase()
      |> String.replace(["-", " ", ".", "_"], "_")

    tmp_dir_name = Path.join(System.tmp_dir!(), dir_name)

    File.rm_rf!(tmp_dir_name)
    File.mkdir_p!(tmp_dir_name)

    Map.put(context, :tmp_dir, tmp_dir_name)
  end
end
