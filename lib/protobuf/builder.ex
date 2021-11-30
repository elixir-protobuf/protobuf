defmodule Protobuf.Builder do
  @moduledoc false

  alias Protobuf.FieldProps

  @spec new(module) :: %{required(:__struct__) => module} when module: module()
  def new(mod) when is_atom(mod) do
    mod.__default_struct__()
  end

  @spec new(module, Enum.t()) :: %{required(:__struct__) => module} when module: module()
  def new(mod, attrs) when is_atom(mod) do
    new_maybe_strict(mod, attrs, _strict? = false)
  end

  @spec new!(module, Enum.t()) :: %{required(:__struct__) => module} when module: module()
  def new!(mod, attrs) when is_atom(mod) do
    new_maybe_strict(mod, attrs, _strict? = true)
  end

  # Used by Protobuf.DSL
  @doc false
  def field_default(syntax, field_props)

  def field_default(_syntax, %FieldProps{default: default}) when not is_nil(default), do: default
  def field_default(_syntax, %FieldProps{repeated?: true}), do: []
  def field_default(_syntax, %FieldProps{map?: true}), do: %{}
  def field_default(:proto3, props), do: type_default(props.type)
  def field_default(_syntax, _props), do: nil

  # Used by Protobuf.Protoc.Generator.Message
  @doc false
  def type_default(type)

  def type_default(:int32), do: 0
  def type_default(:int64), do: 0
  def type_default(:uint32), do: 0
  def type_default(:uint64), do: 0
  def type_default(:sint32), do: 0
  def type_default(:sint64), do: 0
  def type_default(:bool), do: false
  def type_default({:enum, _}), do: 0
  def type_default(:fixed32), do: 0
  def type_default(:sfixed32), do: 0
  def type_default(:fixed64), do: 0
  def type_default(:sfixed64), do: 0
  def type_default(:float), do: 0.0
  def type_default(:double), do: 0.0
  def type_default(:bytes), do: <<>>
  def type_default(:string), do: ""
  def type_default(:message), do: nil
  def type_default(:group), do: nil
  def type_default(_), do: nil

  defp new_maybe_strict(mod, attrs, strict?) do
    case attrs do
      # If the attrs is the module, we just return it.
      %{__struct__: ^mod} ->
        attrs

      # If "attrs" is a struct but not the same struct as "mod", then we raise if are being
      # strict.
      %{__struct__: _other_mod} when strict? ->
        raise ArgumentError,
          message: "The __struct__ in the struct doesn't with the message module"

      # If "attrs" is a struct but not the same struct as "mod", then we use it as attributes
      # to build our new struct:
      %{__struct__: _} ->
        new_from_enum(mod, Map.from_struct(attrs), strict?)

      not_a_struct ->
        new_from_enum(mod, not_a_struct, strict?)
    end
  end

  defp new_from_enum(mod, attrs, strict?) do
    props = mod.__message_props__()
    default_struct = mod.__default_struct__()
    msg = if strict?, do: struct!(default_struct, attrs), else: struct(default_struct, attrs)

    Enum.reduce(props.embedded_fields, msg, fn field_name, acc ->
      case msg do
        %{^field_name => value} when not is_nil(value) ->
          case props.field_props[props.field_tags[field_name]] do
            %FieldProps{embedded?: true, repeated?: true, type: type} ->
              %{acc | field_name => Enum.map(value, &type.new/1)}

            %FieldProps{embedded?: true, repeated?: false, type: type} ->
              %{acc | field_name => type.new(value)}

            _other ->
              acc
          end

        _ ->
          acc
      end
    end)
  end
end
