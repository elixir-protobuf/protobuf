defmodule Protobuf.Extensions do
  @moduledoc """
  Module to globally track extensions.
  """

  @extension_fields_table :extension_fields_table
  @extension_props_table :extension_props_table

  @doc """
  Initializes a new protobuf extensions table. This function
  may be called many as it will have no effect after the first.
  """
  def init() do
    :ets.new(@extension_fields_table, [:named_table, :public, :bag])
    :ets.new(@extension_props_table, [:named_table, :public, :set])
  end

  @doc """
  Adds a prop to a protobuf extensions table.
  """
  def add_extension_prop(module, field) do
    :ets.insert(@extension_fields_table, {module, field})

    fields = for {^module, field} <- :ets.lookup(@extension_fields_table, module), do: field

    :ets.insert(@extension_props_table, {module, Protobuf.DSL.generate_msg_props(fields, [], [])})
  end

  @doc """
  Gets message props from a given protobuf extensions table.
  """
  def get_extension_props(module) do
    case :ets.lookup(@extension_props_table, module) do
      [] -> nil
      [{^module, message_props}] -> message_props
    end
  end
end
