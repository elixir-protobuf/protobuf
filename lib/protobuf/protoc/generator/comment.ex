defmodule Protobuf.Protoc.Generator.Comment do
  @moduledoc false

  defstruct detached: [],
            leading: nil,
            path: [],
            trailing: nil

  @type t :: %__MODULE__{
          detached: [String.t()],
          leading: String.t(),
          path: [any()],
          trailing: String.t()
        }

  @doc """
  Parses comment information from `Google.Protobuf.FileDescriptorProto`.
  """
  @spec parse(Google.Protobuf.FileDescriptorProto.t()) :: [t()]
  def parse(file_descriptor_proto) do
    file_descriptor_proto
    |> get_locations()
    |> Enum.reject(fn location ->
      location.leading_comments == "" and location.trailing_comments == "" and
        Enum.empty?(location.leading_detached_comments)
    end)
    |> Enum.map(fn location ->
      %__MODULE__{
        detached: Enum.map(location.leading_detached_comments, &parse_detached/1),
        leading: Map.get(location, :leading_comments, ""),
        path: Map.get(location, :path, []),
        trailing: Map.get(location, :trailing_comments, "")
      }
    end)
  end

  defp get_locations(file_descriptor_proto) do
    cond do
      Map.get(file_descriptor_proto, :source_code_info) == nil ->
        []

      Map.get(file_descriptor_proto.source_code_info, :location) == nil ->
        []

      true ->
        file_descriptor_proto.source_code_info.location
    end
  end

  defp parse_detached(str) do
    str
    |> String.replace("\n ", "\n")
    |> String.trim()
  end

  @doc """
  Finds a comment via the path. Pretty formats the text for
  immediate use.
  """
  def get(comments, path) do
    case Enum.find(comments, fn comment -> comment.path == path end) do
      nil -> ""
      comment -> pretty_text(comment)
    end
  end

  defp pretty_text(comment) do
    [comment.leading, comment.trailing | comment.detached]
    |> Enum.reject(&is_nil/1)
    |> Enum.join("\n\n")
    |> String.trim()
  end
end
