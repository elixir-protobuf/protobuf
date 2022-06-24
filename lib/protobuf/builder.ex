defmodule Protobuf.Builder do
  @moduledoc false

  alias Protobuf.FieldProps

  @spec new(module) :: %{required(:__struct__) => module, optional(atom()) => any()}
        when module: module()
  def new(mod) when is_atom(mod) do
    struct(mod)
  end

  @spec new(module, Enum.t()) :: %{required(:__struct__) => module, optional(atom()) => any()}
        when module: module()
  def new(mod, attrs) when is_atom(mod) do
    new_maybe_strict(mod, attrs, _strict? = false)
  end

  @spec new!(module, Enum.t()) :: %{required(:__struct__) => module, optional(atom()) => any()}
        when module: module()
  def new!(mod, attrs) when is_atom(mod) do
    new_maybe_strict(mod, attrs, _strict? = true)
  end

  defp new_maybe_strict(mod, attrs, strict?) do
    case attrs do
      # If the attrs is the module, we just return it.
      %{__struct__: ^mod} ->
        attrs

      # If "attrs" is a struct but not the same struct as "mod", then we raise if are being
      # strict.
      %{__struct__: _} = struct when strict? ->
        raise ArgumentError,
          message: "Struct %#{inspect(mod)}{} was expected, but given #{inspect(struct)}"

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
    msg = if strict?, do: struct!(mod, attrs), else: struct(mod, attrs)

    Enum.reduce(props.embedded_fields, msg, fn field_name, acc ->
      case msg do
        %{^field_name => value} when not is_nil(value) ->
          case props.field_props[props.field_tags[field_name]] do
            %FieldProps{embedded?: true, repeated?: true, type: type} ->
              if type.transform_module() do
                acc
              else
                %{acc | field_name => Enum.map(value, &type.new/1)}
              end

            %FieldProps{embedded?: true, repeated?: false, type: type} ->
              if type.transform_module() do
                acc
              else
                %{acc | field_name => type.new(value)}
              end

            _other ->
              acc
          end

        _ ->
          acc
      end
    end)
  end
end
