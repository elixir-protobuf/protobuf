defmodule Protobuf.Extension do
  alias Protobuf.GlobalStore

  @spec put(module, map, module, atom, any) :: map
  def put(mod, struct, extension_mod, field, value) do
    key = {mod, field}

    case extension_mod.__protobuf_info__(:extension_props) do
      %{name_to_tag: %{^key => _}} ->
        case struct do
          %{__pb_extensions__: es} ->
            Map.put(struct, :__pb_extensions__, Map.put(es, {extension_mod, field}, value))

          _ ->
            Map.put(struct, :__pb_extensions__, %{{extension_mod, field} => value})
        end

      _ ->
        raise Protobuf.ExtensionNotFound,
          message: "Extension #{extension_mod}##{field} is not found"
    end
  end

  @spec get(map, module, atom, any) :: any
  def get(struct, extension_mod, field, default) do
    key = {extension_mod, field}

    case struct do
      %{__pb_extensions__: %{^key => val}} ->
        val

      %{} ->
        default
    end
  end

  def get_extension_props(extendee, ext_mod, field) do
    index = {extendee, field}
    ext_props = ext_mod.__protobuf_info__(:extension_props)

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

  def get_extension_props_by_tag(extendee, tag) do
    case GlobalStore.get({Protobuf.Extension, extendee, tag}, nil) do
      nil ->
        nil

      mod ->
        index = {extendee, tag}

        case mod.__protobuf_info__(:extension_props).extensions do
          %{^index => props} ->
            {mod, props}

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
        fnum = ext.field_props.fnum
        fnum_key = {Protobuf.Extension, ext.extendee, fnum}

        if GlobalStore.get(fnum_key, nil) do
          raise "Extension #{inspect(ext.extendee)}##{fnum} already exists"
        end

        GlobalStore.put(fnum_key, mod)
      end)
    end)
  end
end
