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
    docs_chunk = 'Docs'
    assert {:ok, {_module, [{^docs_chunk, bin}]}} = :beam_lib.chunks(bytecode, [docs_chunk])
    :erlang.binary_to_term(bin)
  end
end
