defmodule Protobuf.EnumOptionsProcessor do
  @moduledoc """
  Defines hooks to process custom enum options.

  Functions in this file are used at several stages of the protobuf lifecycle:
  compilation from .proto to .pb.ex, encoding, and decoding
  """

  @typedoc """
  Keyword list of field options. Right now only [extype: mytype].
  """
  @type options :: Brex.Elixirpb.EnumOptions.t()

  def get_transformers(opts) do
    opts
    |> Enum.flat_map(fn
      {:enum, :lowercase} -> [:lowercase]
      {:enum, :deprefix} -> [:deprefix]
      {:enum, :atomize} -> [:deprefix, :lowercase]
      _ -> []
    end)
    |> Enum.sort()
    |> Enum.uniq()
  end

  def validate_opts!(%Brex.Elixirpb.EnumOptions{} = struct) do
    struct
    |> Map.from_struct()
    |> Enum.flat_map(fn
      {:lowercase, true} ->
        [enum: :lowercase]

      {:deprefix, true} ->
        [enum: :deprefix]

      {:atomize, true} ->
        [enum: :atomize]

      {t, nil} when t in [:lowercase, :deprefix, :atomize] ->
        []

      {t, false} when t in [:lowercase, :deprefix, :atomize] ->
        []

      z ->
        raise "Unknown Enum Option #{inspect(z)}! " <>
                "Possible Enum Options are atomize, deprefix, and lowercase."
    end)
  end

  def validate_opts!(v) do
    raise "Unknown Custom Enum Option: #{inspect(v)}"
  end

  # cal_ stands for calculate
  def cal_prefix!(mod, fields, transformers) do
    if :deprefix in transformers do
      prefix =
        mod
        |> Macro.underscore()
        |> Kernel.<>("_")
        |> String.upcase()

      is_prefixed? =
        Enum.all?(fields, fn
          %{name: name} -> String.starts_with?(name, prefix)
        end)

      if is_prefixed? do
        prefix
      else
        raise "Atomize or Deprefix custom enum option present, but no consistent prefix found for " <>
                "#{inspect(mod)}!"
      end
    else
      ""
    end
  end

  def generate_types(mod, fields, options) do
    transformers =
      options
      |> validate_opts!()
      |> get_transformers()

    prefix = cal_prefix!(mod, fields, transformers)

    fields
    |> Enum.map(fn f -> ":#{transform(f.name, prefix, transformers, :backward)}" end)
    |> Enum.join(" | ")
  end

  def options_str(options) do
    options
    |> validate_opts!()
    |> Enum.map(fn {k, v} -> "#{k}: #{Protobuf.Protoc.Generator.Util.print(v)}" end)
  end

  def generate_mappings(mod, props, fields, options) do
    transformers = get_transformers(options)

    field_props = Enum.map(props, fn {_fnum, field_props} -> field_props end)

    prefix =
      mod
      |> Atom.to_string()
      |> String.split(".")
      |> List.last()
      |> cal_prefix!(field_props, transformers)

    original_to_transformed =
      Enum.into(fields, %{}, fn {name_atom, fnum, _} ->
        name = Atom.to_string(name_atom)
        transformed_name = transform(name, prefix, transformers, :backward)
        transformed_name_atom = String.to_atom(transformed_name)
        {name_atom, %{fnum: fnum, name: transformed_name, name_atom: transformed_name_atom}}
      end)

    atom_to_num =
      for {_, %{fnum: fnum, name_atom: tname_atom}} <- original_to_transformed,
          do: {tname_atom, fnum},
          into: %{}

    num_to_atom =
      for {_, %{fnum: fnum, name_atom: name_atom}} <- original_to_transformed,
          do: {fnum, name_atom}

    string_or_num_to_atom =
      for {fnum, %{name_atom: old_name_atom}} <- props,
          %{name_atom: new_name_atom, name: new_name} = original_to_transformed[old_name_atom],
          key <- [fnum, new_name],
          do: {key, new_name_atom},
          into: %{}

    transformation_mapping =
      Enum.into(original_to_transformed, %{}, fn {old_name_atom, %{name_atom: new_name_atom}} ->
        {old_name_atom, new_name_atom}
      end)

    # for the lowercase and atomize options, we want to make each enum option
    # available as a module method e.g. MyEnum.foo_option()
    lowercase_extra_accessor_funs =
      if :lowercase in transformers do
        Enum.map(original_to_transformed, fn {_, %{name_atom: tname_atom}} ->
          quote do
            def unquote(tname_atom)(), do: unquote(tname_atom)
          end
        end)
      else
        []
      end

    # __transformation_mapping__ isn't strictly necessary, it's kind of a
    # paper trail of what the brex enum option did for debugging
    accessor_funs =
      lowercase_extra_accessor_funs ++
        [
          quote do
            def prefix(), do: unquote(prefix)
          end,
          quote do
            def __transformation_mapping__, do: unquote(Macro.escape(transformation_mapping))
          end
        ]

    {atom_to_num, num_to_atom, string_or_num_to_atom, accessor_funs}
  end

  defp transform(value, prefix, transforms, :forward) do
    Enum.reduce(transforms, value, fn
      :lowercase, v -> String.upcase(v)
      :deprefix, v -> String.replace_prefix(v, "", prefix)
    end)
  end

  defp transform(value, prefix, transforms, :backward) do
    Enum.reduce(transforms, value, fn
      :lowercase, v -> String.downcase(v)
      :deprefix, v -> String.replace_prefix(v, prefix, "")
    end)
  end
end
