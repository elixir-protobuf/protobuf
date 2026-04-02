ExUnit.configure(exclude: [integration: true])
ExUnit.start()

Protobuf.load_extensions()

defmodule Protobuf.TestHelpers do
  import ExUnit.Assertions

  def purge_modules(modules) when is_list(modules) do
    Enum.each(modules, fn mod ->
      :code.purge(mod)
      :code.delete(mod)
    end)
  end

  def read_generated_file(relative_path) do
    base_path = [__DIR__, "../generated", relative_path] |> Path.join()

    if File.exists?(base_path) do
      File.read!(base_path)
    else
      filename = Path.basename(relative_path)
      generated_dir = [__DIR__, "../generated"] |> Path.join()

      case find_file_in_dir(generated_dir, filename) do
        {:ok, path} -> File.read!(path)
        :not_found -> File.read!(base_path)
      end
    end
  end

  defp find_file_in_dir(dir, filename) do
    case File.ls(dir) do
      {:ok, entries} ->
        Enum.find_value(entries, :not_found, fn entry ->
          path = Path.join(dir, entry)

          cond do
            entry == filename -> {:ok, path}
            File.dir?(path) ->
              case find_file_in_dir(path, filename) do
                {:ok, found_path} -> {:ok, found_path}
                :not_found -> nil
              end
            true -> nil
          end
        end)

      {:error, _} ->
        :not_found
    end
  end

  def get_type_spec_as_string(module, bytecode, type)
      when is_atom(module) and is_binary(bytecode) and is_atom(type) do
    # This code is taken from Code.Typespec in Elixir (v1.13 in particular).
    assert {:ok, {_, [debug_info: {:debug_info_v1, _backend, {:elixir_v1, %{}, specs}}]}} =
             :beam_lib.chunks(bytecode, [:debug_info])

    spec =
      Enum.find_value(specs, fn
        {:attribute, _, :type, {^type, _, _} = spec} -> spec
        _other -> nil
      end)

    assert not is_nil(spec), "Spec for type #{inspect(module)}.#{type} not found"

    # Code.Typespec.type_to_quoted/1 is not public API in Elixir, but we're still using
    # it here for tests.
    spec
    |> Code.Typespec.type_to_quoted()
    |> Macro.to_string()
  end

  # This code is taken from Code.fetch_docs/1 in Elixir (v1.13 in particular).
  def fetch_docs_from_bytecode(bytecode) when is_binary(bytecode) do
    docs_chunk = ~c"Docs"
    assert {:ok, {_module, [{^docs_chunk, bin}]}} = :beam_lib.chunks(bytecode, [docs_chunk])
    :erlang.binary_to_term(bin)
  end
end
