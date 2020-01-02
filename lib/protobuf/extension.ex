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

  def get_extension_props(extendee, field) do
    case GlobalStore.get({Protobuf.Extension, extendee, field}, nil) do
      nil ->
        nil
      mod ->
        index = {extendee, field}
        ext_props = mod.__protobuf_info__(:extension_props)
        case ext_props.name_to_tag do
          %{^index => tag_idx} ->
            case ext_props.extensions do
              %{^tag_idx => props} ->
                props
              _ ->
                nil
            end
          _ ->
            nil
        end
    end
  end

  def get_extension_props_by_tag(extendee, tag) do
    case GlobalStore.get({Protobuf.Extension, extendee, tag}, nil) do
      nil ->
        nil
      mod ->
        index = {extendee, tag}
        case mod.__protobuf_info__(:extension_props).extensions do
          %{^index => props} ->
            props
          _ ->
            nil
        end
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
      {mod, mod.__protobuf_info__(:extension_props)}
    end)
    |> Enum.reject(fn {_mod, props} -> is_nil(props) end)
    |> Enum.each(fn {mod, props} ->
      Enum.each(props.extensions, fn {_, ext} ->
        name_atom = ext.field_props.name_atom
        fnum = ext.field_props.fnum
        name_key = {Protobuf.Extension, ext.extendee, name_atom}
        fnum_key = {Protobuf.Extension, ext.extendee, fnum}
        if GlobalStore.get(name_key, nil) do
          raise "Extension #{inspect(ext.extendee)}##{name_atom} already exists"
        end
        if GlobalStore.get(fnum_key, nil) do
          raise "Extension #{inspect(ext.extendee)}##{fnum} already exists"
        end
        GlobalStore.put(name_key, mod)
        GlobalStore.put(fnum_key, mod)
      end)
    end)
  end
end
