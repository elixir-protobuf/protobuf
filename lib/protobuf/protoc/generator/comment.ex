defmodule Protobuf.Protoc.Generator.Comment do
  @moduledoc false

  alias Protobuf.Protoc.Context

  @doc """
  Parses comment information from `Google.Protobuf.FileDescriptorProto`
  into a map with path keys.
  """
  @spec parse(Google.Protobuf.FileDescriptorProto.t()) :: %{optional(String.t()) => String.t()}
  def parse(file_descriptor_proto) do
    file_descriptor_proto
    |> get_locations()
    |> Enum.reject(&empty_comment?/1)
    |> Map.new(fn location ->
      {Enum.join(location.path, "."), format_comment(location)}
    end)
  end

  defp get_locations(%{source_code_info: %{location: value}}) when is_list(value),
    do: value

  defp get_locations(_value), do: []

  defp empty_comment?(%{leading_comments: value}) when not is_nil(value) and value != "",
    do: false

  defp empty_comment?(%{trailing_comments: value}) when not is_nil(value) and value != "",
    do: false

  defp empty_comment?(%{leading_detached_comments: value}), do: Enum.empty?(value)

  defp format_comment(location) do
    [location.leading_comments, location.trailing_comments | location.leading_detached_comments]
    |> Enum.reject(&is_nil/1)
    |> Enum.join("\n\n")
    |> String.replace(~r/\n{3,}/, "\n")
    |> normalize_indentation()
    |> String.trim()
  end

  defp normalize_indentation(comments) do
    indentation =
      String.split(comments, "\n")
      |> Enum.reject(&String.match?(&1, ~r/^\s*$/))
      |> Enum.map(fn line ->
        Regex.run(~r/^\s*/, line, capture: :first)
        |> List.first()
        |> String.length()
      end)
      |> Enum.min(fn -> 0 end)

    comments
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.replace_prefix(line, String.duplicate(" ", indentation), "")
    end)
    |> Enum.join("\n")
  end

  @doc """
  Finds a comment via the context. Returns an empty string if the
  comment is not found or if `include_docs?` is set to false.
  """
  @spec get(Context.t()) :: String.t()
  def get(%{include_docs?: false}), do: ""

  def get(%{comments: comments, current_comment_path: path}),
    do: get(comments, path)

  @doc """
  Finds a comment via a map of comments and a path. Returns an
  empty string if the comment is not found
  """
  @spec get(%{optional(String.t()) => String.t()}, String.t()) :: String.t()
  def get(comments, path), do: Map.get(comments, path, "")
end
