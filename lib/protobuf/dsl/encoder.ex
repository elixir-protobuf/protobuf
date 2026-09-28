defmodule Protobuf.DSL.Encoder do
  @moduledoc false

  # Compile-time generation of specialized encoders.
  #
  # `Protobuf.Encoder` is an interpreter: for every field of every message it
  # walks `__message_props__/0`, looks up the field props, dispatches on the
  # type and re-evaluates the presence rules. All of that is decided by the
  # schema, which is fully known when `use Protobuf` expands, so it can be done
  # once at compile time instead — which is what protoc does for Go/Java/Scala.
  #
  # Each message module gets:
  #
  #   * `__encode_sized__(message)` - returns `{iodata, byte_size}` (or `:skip`),
  #     so that a parent message can write its length prefix without the extra
  #     `IO.iodata_length/1` traversal that the interpreter needs.
  #
  #   * `__encode_entry_sized__(key, value)` - only for map entry messages, to
  #     encode an entry without materializing the entry struct.
  #
  # Messages with a `transform_module/0` fall back to the interpreted encoder,
  # and so do values that aren't a struct of the expected module (implicit
  # casts). When the generated encoder raises, `Protobuf.Encoder` replays the
  # message through the interpreter so that error messages keep naming the
  # field that failed.

  alias Protobuf.{FieldProps, MessageProps}

  @varint_types %{
    int32: {-0x80000000, 0x7FFFFFFF},
    int64: {-0x8000000000000000, 0x7FFFFFFFFFFFFFFF},
    uint32: {0, 0xFFFFFFFF},
    uint64: {0, 0xFFFFFFFFFFFFFFFF}
  }

  @zigzag_types %{
    sint32: {-0x80000000, 0x7FFFFFFF},
    sint64: {-0x8000000000000000, 0x7FFFFFFFFFFFFFFF}
  }

  # Types for which Protobuf.Wire.encode/2 returns a binary of a known length.
  @fixed_types [:fixed32, :sfixed32, :float, :fixed64, :sfixed64, :double]

  @spec quoted_encode_functions(MessageProps.t(), Macro.t() | nil) :: Macro.t() | nil
  def quoted_encode_functions(%MessageProps{enum?: true}, _transform_module_ast), do: nil

  def quoted_encode_functions(%MessageProps{} = props, nil) do
    block([
      quoted_no_warn_undefined(props),
      quoted_message_encoder(props),
      quoted_entry_encoder(props)
    ])
  end

  def quoted_encode_functions(%MessageProps{} = props, _transform_module_ast) do
    block([quoted_fallback_encoder(), quoted_fallback_entry_encoder(props)])
  end

  # The generated code calls child message and enum modules directly, and a
  # message compiled on its own (as the protoc generator tests do) may not have
  # them at all.
  defp quoted_no_warn_undefined(%MessageProps{field_props: field_props}) do
    modules =
      field_props
      |> Map.values()
      |> Enum.flat_map(&referenced_modules/1)
      |> Enum.uniq()

    if modules != [] do
      quote do
        @compile {:no_warn_undefined, unquote(modules)}
      end
    end
  end

  defp referenced_modules(%FieldProps{embedded?: true, type: mod}) when is_atom(mod), do: [mod]
  defp referenced_modules(%FieldProps{type: {:enum, mod}}), do: [mod]
  defp referenced_modules(%FieldProps{}), do: []

  ## Message encoder

  defp quoted_message_encoder(%MessageProps{} = props) do
    fields = ordered_fields(props)

    quote do
      @doc false
      @spec __encode_sized__(term()) :: {iodata(), non_neg_integer()} | :skip
      def __encode_sized__(%__MODULE__{unquote_splicing(quoted_destructure(fields))} = msg) do
        unquote(quoted_encode_body(fields, props))
      rescue
        error ->
          Protobuf.Encoder.reraise_generated_error(msg, __MODULE__, error, __STACKTRACE__)
      end

      def __encode_sized__(other) do
        Protobuf.Encoder.encode_child_sized(other, __MODULE__)
      end

      unquote(block(Enum.map(fields, &quoted_field_helper(&1, props))))
    end
  end

  defp quoted_fallback_encoder do
    quote do
      @doc false
      @spec __encode_sized__(term()) :: {iodata(), non_neg_integer()} | :skip
      def __encode_sized__(msg) do
        Protobuf.Encoder.encode_child_sized(msg, __MODULE__)
      end
    end
  end

  defp quoted_entry_encoder(%MessageProps{map?: true} = props) do
    key_prop = Map.fetch!(props.field_props, 1)
    value_prop = Map.fetch!(props.field_props, 2)

    quote do
      @doc false
      @spec __encode_entry_sized__(term(), term()) :: {iodata(), non_neg_integer()} | :skip
      def __encode_entry_sized__(key, value) do
        acc = {[], 0}
        unquote(quoted_field(key_prop, props, var(:key)))
        unquote(quoted_field(value_prop, props, var(:value)))
        acc
      rescue
        error ->
          Protobuf.Encoder.reraise_generated_entry_error(
            {key, value},
            __MODULE__,
            error,
            __STACKTRACE__
          )
      end

      unquote(quoted_field_helper(key_prop, props))
      unquote(quoted_field_helper(value_prop, props))
    end
  end

  defp quoted_entry_encoder(%MessageProps{}), do: nil

  defp quoted_fallback_entry_encoder(%MessageProps{map?: true}) do
    quote do
      @doc false
      @spec __encode_entry_sized__(term(), term()) :: {iodata(), non_neg_integer()} | :skip
      def __encode_entry_sized__(key, value) do
        Protobuf.Encoder.encode_map_entry_sized({key, value}, __MODULE__)
      end
    end
  end

  defp quoted_fallback_entry_encoder(%MessageProps{}), do: nil

  defp quoted_encode_body(fields, %MessageProps{} = props) do
    quote do
      acc = {[], 0}
      unquote(quoted_oneof_values(props))
      unquote_splicing(Enum.map(fields, &quoted_field(&1, props, field_var(&1, props))))
      unquote(quoted_unknown_fields())
      unquote(quoted_extensions(props))
      acc
    end
  end

  # Fields are encoded in tag order because some conformance tests expect it.
  defp ordered_fields(%MessageProps{ordered_tags: tags, field_props: field_props}) do
    Enum.map(tags, &Map.fetch!(field_props, &1))
  end

  defp quoted_destructure(fields) do
    for %FieldProps{oneof: nil} = fp <- fields, do: {fp.name_atom, var(:"v_#{fp.name_atom}")}
  end

  # oneof_actual_vals/2 also validates that each {field, value} tuple belongs
  # to the oneof group it is stored in.
  defp quoted_oneof_values(%MessageProps{oneof: []}), do: nil

  defp quoted_oneof_values(%MessageProps{}) do
    quote do
      oneofs = Protobuf.Encoder.oneof_actual_vals(__MODULE__.__message_props__(), msg)
    end
  end

  defp field_var(%FieldProps{oneof: nil} = fp, _props), do: var(:"v_#{fp.name_atom}")

  defp field_var(%FieldProps{name_atom: name}, _props) do
    quote do: Map.get(oneofs, unquote(name))
  end

  ## Trailing fields

  defp quoted_unknown_fields do
    quote do
      acc =
        case msg.__unknown_fields__ do
          [] ->
            acc

          unknown ->
            {io, size} = acc
            encoded = Protobuf.Encoder.encode_unknown_fields_iodata(unknown)
            {[io | encoded], size + IO.iodata_length(encoded)}
        end
    end
  end

  defp quoted_extensions(%MessageProps{syntax: :proto2, extension_range: ranges})
       when not is_nil(ranges) do
    quote do
      acc =
        case msg.__pb_extensions__ do
          extensions when extensions == %{} ->
            acc

          extensions ->
            {io, size} = acc
            encoded = Protobuf.Encoder.encode_extensions_iodata(__MODULE__, extensions)
            {[io | encoded], size + IO.iodata_length(encoded)}
        end
    end
  end

  defp quoted_extensions(%MessageProps{}), do: nil

  ## Fields

  # Repeated, packed and map fields loop in a generated private function so that
  # the loop is a direct local call instead of an anonymous function apply.
  defp quoted_field_helper(%FieldProps{} = fp, %MessageProps{} = props) do
    cond do
      fp.map? -> quoted_map_helper(fp, props)
      fp.repeated? and fp.packed? -> quoted_packed_helper(fp, props)
      fp.repeated? -> quoted_repeated_helper(fp, props)
      true -> nil
    end
  end

  defp quoted_field(%FieldProps{} = fp, %MessageProps{} = props, val) do
    cond do
      fp.map? -> quoted_map_field(fp, props, val)
      fp.repeated? and fp.packed? -> quoted_packed_field(fp, props, val)
      fp.repeated? -> quoted_repeated_field(fp, props, val)
      true -> quoted_singular_field(fp, props, val)
    end
  end

  defp quoted_singular_field(%FieldProps{} = fp, %MessageProps{} = props, val) do
    quote do
      acc = unquote(case_ast(val, skipped_then_emit_clauses(fp, props, var(:value))))
    end
  end

  defp skipped_then_emit_clauses(%FieldProps{embedded?: true} = fp, %MessageProps{} = props, val) do
    embedded_clauses(fp, props, val)
  end

  # Skip clauses come first, so any emit clause matching a value that is already
  # skipped (a proto3 `false`, a proto2 field holding its declared default) would
  # be unreachable and is dropped.
  defp skipped_then_emit_clauses(%FieldProps{} = fp, %MessageProps{} = props, val) do
    patterns = skip_patterns(fp, props)

    emit =
      Enum.reject(
        emit_clauses(fp, implicit_presence?(fp, props), val),
        &covered_by?(&1, patterns)
      )

    Enum.map(patterns, &clause(&1, quote(do: acc))) ++ emit
  end

  defp covered_by?({:->, _meta, [[pattern], _body]}, patterns) do
    literal_pattern?(pattern) and pattern in patterns
  end

  defp literal_pattern?(pattern) do
    is_atom(pattern) or is_number(pattern) or is_binary(pattern)
  end

  ## Embedded fields

  # A value that looks like a proto3 default (0, "", false) is absent when the
  # child module doesn't transform, but present when its transform module turns
  # it into a message — only known at runtime, so those values get their own
  # clauses. The common nil/struct values never consult the transform module.
  defp embedded_clauses(%FieldProps{type: type} = fp, %MessageProps{} = props, val) do
    default_clauses =
      for default <- embedded_default_patterns(fp, props) do
        encoded =
          quote(do: Protobuf.Encoder.encode_child_default_sized(unquote(default), unquote(type)))

        clause(default, quoted_embedded_emit(fp, encoded))
      end

    [clause(nil, quote(do: acc)), clause([], quote(do: acc))] ++
      default_clauses ++
      [
        clause(
          val,
          quoted_embedded_emit(fp, quote(do: unquote(type).__encode_sized__(unquote(val))))
        )
      ]
  end

  defp embedded_default_patterns(%FieldProps{} = fp, %MessageProps{} = props) do
    if implicit_presence?(fp, props) do
      [0, quoted_positive_zero(), "", false]
    else
      []
    end
  end

  defp quoted_embedded_emit(%FieldProps{encoded_fnum: key}, encoded_call) do
    quote do
      case unquote(encoded_call) do
        :skip ->
          acc

        {encoded, encoded_size} ->
          {io, size} = acc
          prefix = Protobuf.Wire.Varint.encode(encoded_size)

          {[io, unquote(key), prefix | encoded],
           size + unquote(byte_size(key)) + byte_size(prefix) + encoded_size}
      end
    end
  end

  ## Repeated fields

  defp quoted_repeated_field(%FieldProps{} = fp, %MessageProps{} = props, val) do
    fun = helper_name(fp)
    emit = quote(do: unquote(fun)(list, acc))
    clauses = skip_clauses(fp, props) ++ [clause(var(:list), emit)]

    quote do
      acc = unquote(case_ast(val, clauses))
    end
  end

  defp quoted_repeated_helper(%FieldProps{} = fp, %MessageProps{} = props) do
    fun = helper_name(fp)
    element_clauses = element_clauses(fp, props)

    quote do
      defp unquote(fun)([], acc), do: acc

      defp unquote(fun)([element | rest], acc) do
        acc = unquote(case_ast(var(:element), element_clauses))
        unquote(fun)(rest, acc)
      end

      defp unquote(fun)(other, acc), do: unquote(fun)(Enum.to_list(other), acc)
    end
  end

  # Embedded elements keep the interpreter's per-element presence check;
  # scalar elements are always emitted, the whole list is checked instead. That
  # includes the zero value of an enum, which is why elements never have implicit
  # presence.
  defp element_clauses(%FieldProps{embedded?: true} = fp, %MessageProps{} = props) do
    skipped_then_emit_clauses(fp, props, var(:element))
  end

  defp element_clauses(%FieldProps{} = fp, %MessageProps{}) do
    emit_clauses(fp, _implicit_presence? = false, var(:element))
  end

  ## Packed fields

  defp quoted_packed_field(%FieldProps{} = fp, %MessageProps{} = props, val) do
    fun = helper_name(fp)
    key = fp.encoded_fnum

    emit =
      quote do
        {io, size} = acc
        payload = unquote(fun)(list, <<>>)
        prefix = Protobuf.Wire.Varint.encode(byte_size(payload))

        {[io, unquote(key), prefix | payload],
         size + unquote(byte_size(key)) + byte_size(prefix) + byte_size(payload)}
      end

    clauses = skip_clauses(fp, props) ++ [clause(var(:list), emit)]

    quote do
      acc = unquote(case_ast(val, clauses))
    end
  end

  # Packed elements are contiguous on the wire, so the whole field becomes one
  # appended binary with an O(1) byte_size for its length prefix.
  defp quoted_packed_helper(%FieldProps{type: type} = fp, %MessageProps{}) do
    fun = helper_name(fp)

    quote do
      defp unquote(fun)([], payload), do: payload

      defp unquote(fun)([element | rest], payload) do
        encoded = Protobuf.Encoder.encode_wire_binary(unquote(Macro.escape(type)), element)
        unquote(fun)(rest, <<payload::binary, encoded::binary>>)
      end

      defp unquote(fun)(other, payload), do: unquote(fun)(Enum.to_list(other), payload)
    end
  end

  ## Map fields

  defp quoted_map_field(%FieldProps{} = fp, %MessageProps{} = props, val) do
    fun = helper_name(fp)

    empty_map_clause =
      guarded_clause(
        var(:map),
        quote(do: is_map(map) and map_size(map) == 0),
        quote(do: acc)
      )

    clauses =
      skip_clauses(fp, props) ++
        [empty_map_clause, clause(var(:map), quote(do: unquote(fun)(map, acc)))]

    quote do
      acc = unquote(case_ast(val, clauses))
    end
  end

  defp quoted_map_helper(%FieldProps{type: entry_mod} = fp, %MessageProps{}) do
    fun = helper_name(fp)
    key = fp.encoded_fnum

    quote do
      defp unquote(fun)(map, acc) do
        Enum.reduce(map, acc, fn {key, value}, acc ->
          case Protobuf.Encoder.encode_entry_sized(unquote(entry_mod), key, value) do
            :skip ->
              acc

            {encoded, encoded_size} ->
              {io, size} = acc
              prefix = Protobuf.Wire.Varint.encode(encoded_size)

              {[io, unquote(key), prefix | encoded],
               size + unquote(byte_size(key)) + byte_size(prefix) + encoded_size}
          end
        end)
      end
    end
  end

  ## Presence

  # Mirrors Protobuf.Presence: the patterns are the values for which the
  # interpreter's skip_field?/3 returns true, in the same pattern form (so that
  # +0.0 and 0.0 keep matching exactly like they do there).
  defp skip_clauses(%FieldProps{} = fp, %MessageProps{} = props) do
    for pattern <- skip_patterns(fp, props), do: clause(pattern, quote(do: acc))
  end

  defp skip_patterns(%FieldProps{} = fp, %MessageProps{syntax: syntax}) do
    cond do
      # Embedded values (or a whole repeated/map field of them) are only checked
      # for emptiness here, see embedded_clauses/3 for the per-value rules.
      fp.embedded? ->
        [nil, []]

      not is_nil(fp.oneof) or fp.proto3_optional? ->
        [nil, []]

      # Required proto2 fields are emitted even when they hold their default.
      syntax == :proto2 and fp.required? ->
        []

      syntax == :proto2 ->
        Enum.uniq([nil, [] | List.wrap(fp.default && quoted_default_pattern(fp.default))])

      true ->
        [nil, 0, quoted_positive_zero(), "", false, []]
    end
  end

  defp implicit_presence?(%FieldProps{proto3_optional?: true}, _props), do: false
  defp implicit_presence?(%FieldProps{oneof: oneof}, _props) when not is_nil(oneof), do: false
  defp implicit_presence?(_fp, %MessageProps{syntax: :proto3}), do: true
  defp implicit_presence?(_fp, %MessageProps{}), do: false

  # Written as a unary plus to avoid the "pattern matching on 0.0" warning.
  defp quoted_positive_zero, do: {:+, [], [0.0]}

  # Float zero defaults keep their sign explicit in the pattern: a bare 0.0
  # matches only +0.0 from Erlang/OTP 27 on and warns at compile time.
  defp quoted_default_pattern(default) when is_float(default) and default == 0.0 do
    case <<default::float>> do
      <<0::1, _::63>> -> quoted_positive_zero()
      <<1::1, _::63>> -> {:-, [], [0.0]}
    end
  end

  defp quoted_default_pattern(default), do: Macro.escape(default)

  ## Value emission

  defp emit_clauses(%FieldProps{type: type} = fp, _implicit_presence?, val)
       when type in [:string, :bytes] do
    fast =
      quote do
        unquote(if type == :string, do: quoted_validate_utf8(val))
        {io, size} = acc
        length = byte_size(unquote(val))
        prefix = Protobuf.Wire.Varint.encode(length)

        {[io, unquote(fp.encoded_fnum), prefix | unquote(val)],
         size + unquote(byte_size(fp.encoded_fnum)) + byte_size(prefix) + length}
      end

    [
      guarded_clause(val, quote(do: is_binary(unquote(val))), fast),
      clause(val, quoted_wire_emit(fp, val))
    ]
  end

  defp emit_clauses(%FieldProps{type: :bool} = fp, _implicit_presence?, val) do
    [
      clause(true, quoted_binary_emit(fp, <<1>>)),
      clause(false, quoted_binary_emit(fp, <<0>>)),
      clause(val, quoted_wire_emit(fp, val))
    ]
  end

  defp emit_clauses(%FieldProps{type: {:enum, enum_mod}} = fp, implicit_presence?, val) do
    number = var(:number)

    # In proto3, enum fields with implicit presence skip the zero value, which
    # can only be known once the atom key has been resolved to its number.
    known_clauses =
      if implicit_presence? do
        [clause(0, quote(do: acc)), clause(number, quoted_varint_emit(fp, number))]
      else
        [clause(number, quoted_varint_emit(fp, number))]
      end

    resolve =
      quote do
        unquote(case_ast(quote(do: unquote(enum_mod).value(unquote(val))), known_clauses))
      end

    [
      guarded_clause(val, quote(do: is_atom(unquote(val))), resolve),
      guarded_clause(val, quote(do: is_integer(unquote(val))), quoted_varint_emit(fp, val)),
      clause(val, quoted_wire_emit(fp, val))
    ]
  end

  defp emit_clauses(%FieldProps{type: type} = fp, _implicit_presence?, val)
       when is_map_key(@varint_types, type) do
    {min, max} = Map.fetch!(@varint_types, type)

    [
      guarded_clause(
        val,
        quote(
          do:
            is_integer(unquote(val)) and unquote(val) >= unquote(min) and
              unquote(val) <= unquote(max)
        ),
        quoted_varint_emit(fp, val)
      ),
      clause(val, quoted_wire_emit(fp, val))
    ]
  end

  defp emit_clauses(%FieldProps{type: type} = fp, _implicit_presence?, val)
       when is_map_key(@zigzag_types, type) do
    {min, max} = Map.fetch!(@zigzag_types, type)
    zigzagged = quote(do: Protobuf.Wire.Zigzag.encode(unquote(val)))

    [
      guarded_clause(
        val,
        quote(
          do:
            is_integer(unquote(val)) and unquote(val) >= unquote(min) and
              unquote(val) <= unquote(max)
        ),
        quoted_varint_emit(fp, zigzagged)
      ),
      clause(val, quoted_wire_emit(fp, val))
    ]
  end

  defp emit_clauses(%FieldProps{type: type} = fp, _implicit_presence?, val)
       when type in @fixed_types do
    emit =
      quote do
        {io, size} = acc
        encoded = Protobuf.Wire.encode(unquote(type), unquote(val))

        {[io, unquote(fp.encoded_fnum) | encoded],
         size + unquote(byte_size(fp.encoded_fnum)) + byte_size(encoded)}
      end

    [clause(val, emit)]
  end

  # Unsupported types (groups, and anything a future protoc adds) go through
  # Protobuf.Wire, which raises the same error the interpreter would.
  defp emit_clauses(%FieldProps{} = fp, _implicit_presence?, val) do
    [clause(val, quoted_wire_emit(fp, val))]
  end

  defp quoted_varint_emit(%FieldProps{encoded_fnum: key}, number) do
    quote do
      {io, size} = acc
      encoded = Protobuf.Wire.Varint.encode(unquote(number))

      {[io, unquote(key) | encoded], size + unquote(byte_size(key)) + byte_size(encoded)}
    end
  end

  defp quoted_binary_emit(%FieldProps{encoded_fnum: key}, binary) do
    quote do
      {io, size} = acc

      {[io, unquote(key) | unquote(binary)], size + unquote(byte_size(key) + byte_size(binary))}
    end
  end

  defp quoted_wire_emit(%FieldProps{encoded_fnum: key, type: type}, val) do
    quote do
      {io, size} = acc
      encoded = Protobuf.Encoder.encode_wire(unquote(Macro.escape(type)), unquote(val))

      {[io, unquote(key) | encoded], size + unquote(byte_size(key)) + IO.iodata_length(encoded)}
    end
  end

  defp quoted_validate_utf8(val) do
    quote do
      if not String.valid?(unquote(val)) do
        raise Protobuf.EncodeError,
          message: "invalid UTF-8 data for type string: #{inspect(unquote(val))}"
      end
    end
  end

  ## AST helpers

  defp helper_name(%FieldProps{fnum: fnum, name_atom: name}),
    do: :"__encode_field_#{fnum}_#{name}__"

  defp var(name), do: Macro.var(name, __MODULE__)

  defp block(asts), do: {:__block__, [], Enum.reject(asts, &is_nil/1)}

  defp case_ast(subject, clauses), do: {:case, [], [subject, [do: clauses]]}

  defp clause(pattern, body), do: {:->, [], [[pattern], body]}

  defp guarded_clause(pattern, guard, body),
    do: {:->, [], [[{:when, [], [pattern, guard]}], body]}
end
