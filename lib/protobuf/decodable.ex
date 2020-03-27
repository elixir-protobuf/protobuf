defprotocol Protobuf.Decodable do
  @moduledoc """
  Defines the contract for transformations after decode a message.

  Implementing this protocol is useful to translate protobuf structs to Elixir
  terms.

  ## Examples

      defimpl Protobuf.Decodable, for: MyApp.Protobuf.Date do
        def to_elixir(%MyApp.Protobuf.Date{year: year, month: month, day: day}) do
          {:ok, date} = Date.new(year, month, day)
          date
        end
      end

      # later in a decoded message
      proto_message.birthday
      ~D[1988-10-29]
  """
  @fallback_to_any true

  @doc """
  This function will be called after decode the protobuf message binary. The
  returning value will be used in place of current `term` struct.
  """
  @spec to_elixir(t) :: any
  def to_elixir(term)
end

defimpl Protobuf.Decodable, for: Any do
  def to_elixir(term), do: term
end
