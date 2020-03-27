defprotocol Protobuf.Encodable do
  @moduledoc """
  Defines the contract for Elixir terms transformations before encode a message.

  Implementing this protocol is useful to translate Elixir terms to protobuf
  structs, works in combination with `Protobuf.Decodable`.

  ## Examples

      defimpl Protobuf.Encodable, for: Date do
        def to_protobuf(%Date{year: year, month: month, day: day}, MyApp.Protobuf.Date) do
          MyApp.Protobuf.Date.new(year: year, month: month, day: day)
        end
      end

      # later, you can use Elixir terms in your fields and those will be
      # converted to protobuf structs before binary encoding
      %{protobuf_message | birthday: ~D[1988-10-29]}

  """
  @fallback_to_any true

  @doc """
  This function will invoked before encode a term and only if encoding target is
  a protobuf message. The returning value will be used in place of current
  Elixir `term` struct.
  """
  @spec to_protobuf(t, module) :: struct
  def to_protobuf(term, target_protobuf_module)
end

defimpl Protobuf.Encodable, for: Any do
  def to_protobuf(term, _target_protobuf_module), do: term
end
