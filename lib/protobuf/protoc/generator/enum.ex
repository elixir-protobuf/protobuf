defmodule Protobuf.Protoc.Generator.Enum do
  @moduledoc false

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Util

  @spec generate_list(Context.t(), [Google.Protobuf.EnumDescriptorProto.t()]) :: [String.t()]
  def generate_list(%Context{} = ctx, descs) when is_list(descs) do
    Enum.map(descs, &generate(ctx, &1))
  end

  @spec generate(Context.t(), Google.Protobuf.EnumDescriptorProto.t()) :: String.t()
  def generate(%Context{namespace: ns} = ctx, %Google.Protobuf.EnumDescriptorProto{} = desc) do
    msg_name = Util.mod_name(ctx, ns ++ [Macro.camelize(desc.name)])
    fields = Enum.map(desc.value, &generate_field/1)
    generate_desc = if ctx.gen_descriptors?, do: desc, else: nil
    type = generate_type(desc.value)

    Protobuf.Protoc.Template.enum(msg_name, msg_opts(ctx, desc), fields, type, generate_desc)
  end

  defp generate_type(fields) do
    union = Enum.map_join(fields, " | ", &enum_value_name_to_atom_string(&1.name))
    # An enum can always be passed as an integer so we hardcode the integer/0 type here
    # alongside the union of atoms.
    "@type t :: integer | " <> union
  end

  defp generate_field(%Google.Protobuf.EnumValueDescriptorProto{name: name, number: number}) do
    "#{enum_value_name_to_atom_string(name)}, #{number}"
  end

  defp msg_opts(%{syntax: syntax}, _desc) do
    opts = %{syntax: syntax, enum: true}
    ", " <> Util.options_to_str(opts)
  end

  defp enum_value_name_to_atom_string(name) when is_binary(name), do: ":" <> name
end
