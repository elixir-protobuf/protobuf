defmodule Protobuf.Extension do
  alias Protobuf.GlobalStore

  @spec put(module, map, atom, any) :: map
  def put(mod, struct, field, value) do
    case GlobalStore.get({Protobuf.Extension, mod, field}, nil) do
      nil ->
        raise Protobuf.ExtensionNotFound, message: "extension for #{mod}##{field} is not found"
      _ ->
        case struct do
          %{__pb_extensions__: es} ->
            Map.put(struct, :__pb_extensions__, Map.put(es, field, value))
          _ ->
            Map.put(struct, :__pb_extensions__, %{field => value})
        end
    end
  end

  @spec get(map, atom, any) :: any
  def get(struct, field, default) do
    case struct do
      %{__pb_extensions__: %{^field => val}} ->
        val
      %{} ->
        default
    end
  end

  def cal_extensions(mods) do
    mods
    |> Enum.filter(fn mod ->
      if Code.ensure_loaded?(mod) do
        function_exported?(mod, :__protobuf_info__, 1)
      end
    end)
    |> Enum.map(fn mod ->
      mod.__protobuf_info__(:extension_props)
    end)
    |> Enum.reject(fn mod -> is_nil(mod) end)
    |> Enum.each(fn props ->
      Enum.each(props.extensions, fn ext ->
        name_key = {Protobuf.Extension, ext.extendee, ext.name_atom}
        fnum_key = {Protobuf.Extension, ext.extendee, ext.fnum}
        if GlobalStore.get(name_key, nil) do
          raise "Extension #{inspect(ext.extendee)}##{ext.name_atom} already exists"
        end
        GlobalStore.put(name_key, %Protobuf.Extension.Persistent{type: ext.type})
        if GlobalStore.get(fnum_key, nil) do
          raise "Extension #{inspect(ext.extendee)}##{ext.fnum} already exists"
        end
        GlobalStore.put(fnum_key, ext.name_atom)
      end)
    end)
  end
end
