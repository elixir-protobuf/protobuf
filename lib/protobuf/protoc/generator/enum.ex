defmodule Protobuf.Protoc.Generator.Enum do
  @moduledoc false
  alias Protobuf.Protoc.Generator.Util

  def generate_list(ctx, descs) do
    Enum.map(descs, fn desc -> generate(ctx, desc) end)
  end

  def generate(%{namespace: ns} = ctx, desc) do
    enum_options = cal_options(ctx, desc)
    name = Util.trans_name(desc.name)
    fields = Enum.map(desc.value, fn f -> generate_field(f) end)
    msg_name = Util.mod_name(ctx, ns ++ [name])
    generate_desc = if ctx.gen_descriptors?, do: desc, else: nil
    type = generate_type(enum_options, name, desc)

    Protobuf.Protoc.Template.enum(
      msg_name,
      msg_opts(ctx, desc),
      fields,
      type,
      generate_desc,
      option_str(enum_options)
    )
  end

  defp option_str(nil), do: []
  defp option_str(enum_options), do: Protobuf.EnumOptionsProcessor.options_str(enum_options)

  def generate_type(enum_options, name, desc) when not is_nil(enum_options) do
    field_values = Protobuf.EnumOptionsProcessor.generate_types(name, desc.value, enum_options)

    "@type t :: integer | " <> field_values
  end

  def generate_type(_enum_options, _name, %{value: fields}) do
    field_values =
      fields
      |> Enum.map(fn f -> ":#{f.name}" end)
      |> Enum.join(" | ")

    "@type t :: integer | " <> field_values
  end

  def generate_field(f) do
    ":#{f.name}, #{f.number}"
  end

  # cal_ stands for calculate
  def cal_options(%{custom_field_options?: true}, %{options: options}) when not is_nil(options) do
    Google.Protobuf.EnumOptions.get_extension(options, Brex.Elixirpb.PbExtension, :enum)
  end

  def cal_options(_ctx, _desc), do: nil

  defp msg_opts(%{syntax: syntax, custom_field_options?: custom_field_options}, _desc) do
    opts = %{syntax: syntax, enum: true}

    opts =
      if custom_field_options do
        # When you compile .proto files into .pb.ex files, there's a
        # Brex-specific flag called "custom_field_options" that turns on or off
        # Brex's custom option handling. At first it was only being used for
        # field options, but now it's used for field, enum, and file options.
        Map.put(opts, :custom_field_options?, true)
      else
        opts
      end

    str = Util.options_to_str(opts)
    ", " <> str
  end
end
