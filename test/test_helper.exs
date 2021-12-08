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
    assert {:ok, {_, [debug_info: {:debug_info_v1, backend, data}]}} =
             :beam_lib.chunks(bytecode, [:debug_info])

    assert {:ok, specs} =
             (case data do
                {:elixir_v1, %{}, specs} ->
                  {:ok, specs}

                _ ->
                  case backend.debug_info(:erlang_v1, module, data, []) do
                    {:ok, abstract_code} -> {:ok, abstract_code}
                    _ -> :error
                  end
              end)

    spec =
      Enum.find_value(specs, fn
        {:attribute, _, :type, {^type, _, _} = spec} -> spec
        _other -> nil
      end)

    quoted = Code.Typespec.type_to_quoted(spec)

    Macro.to_string(quoted)
  end
end
