defmodule Protobuf.Protoc.Metadata do
  @moduledoc """
  Most of functions read data from ETS.
  """

  @spec get_desc_by_fqn(String.t()) :: map() | nil
  def get_desc_by_fqn(fqn) do
    [{{:desc, ^fqn}, desc}] = :ets.lookup(Protobuf.Protoc.Parser, {:desc, fqn})
    desc
  end

  @spec get_metadata_by_fqn(String.t()) :: map() | nil
  def get_metadata_by_fqn(fqn) do
    [{{:metadata, ^fqn}, metadata}] = :ets.lookup(Protobuf.Protoc.Parser, {:metadata, fqn})
    metadata
  end

  defmodule Package do
    @moduledoc ""

    @type t :: %__MODULE__{
            fqn: String.t(),
            files: [map()]
          }

    defstruct fqn: "", files: []

    alias Protobuf.Protoc.Metadata

    @spec files([__MODULE__.t()]) :: [
            {Metadata.File.t(), Google.Protobuf.FileDescriptorProto.t()}
          ]
    def files(pkgs) when is_list(pkgs) do
      Enum.flat_map(pkgs, &files/1)
    end

    @spec files(__MODULE__.t()) :: [{Metadata.File.t(), Google.Protobuf.FileDescriptorProto.t()}]
    def files(pkg) do
      pkg
      |> Map.get(:files)
      |> Enum.map(fn %{fqn: fqn} ->
        {Metadata.get_metadata_by_fqn(fqn), Metadata.get_desc_by_fqn(fqn)}
      end)
    end
  end

  defmodule File do
    @moduledoc ""

    @type t :: %__MODULE__{
            desc: map() | nil,
            fqn: String.t(),
            package: String.t(),
            messages: [String.t()]
          }

    defstruct desc: nil, fqn: "", package: "", messages: []

    alias Protobuf.Protoc.Metadata

    @doc """
    Read all direct messages and nested messages
    """
    @spec all_messages(__MODULE__.t()) :: [
            {Metadata.Message.t(), Google.Protobuf.DescriptorProto.t()}
          ]
    def all_messages(file) do
      file
      |> Map.get(:messages)
      |> Enum.flat_map(fn message_fqn ->
        msg_desc = Metadata.get_desc_by_fqn(message_fqn)
        msg_md = Metadata.get_metadata_by_fqn(message_fqn)
        [{msg_md, msg_desc} | Metadata.Message.all_messages(msg_md)]
      end)
    end

    @doc """
    Read direct messages
    """
    @spec messages(__MODULE__.t()) :: [
            {Metadata.Message.t(), Google.Protobuf.DescriptorProto.t()}
          ]
    def messages(file) do
      file
      |> Map.get(:messages)
      |> Enum.map(fn msg_fqn ->
        {
          Protobuf.Protoc.Metadata.get_metadata_by_fqn(msg_fqn),
          Protobuf.Protoc.Metadata.get_desc_by_fqn(msg_fqn)
        }
      end)
    end

    @doc """
    Read all direct and nested enums
    """
    def all_enums(_file) do
    end

    @doc """
    Read all direct enums
    """
    def enums(_file) do
    end
  end

  defmodule Message do
    @moduledoc ""

    @type t :: %__MODULE__{
            desc: map() | nil,
            fqn: String.t(),
            namespace: String.t(),
            parent_fqn: String.t(),
            fields: [String.t()],
            nested_msgs: [String.t()]
          }

    defstruct desc: nil,
              fqn: "",
              namespace: "",
              parent_fqn: "",
              fields: [],
              nested_msgs: []

    alias Protobuf.Protoc.Metadata

    @doc """
    Return all nested messages
    """
    @spec all_messages(__MODULE__.t()) :: [{__MODULE__.t(), Google.Protobuf.DescriptorProto.t()}]
    def all_messages(msg) do
      msg
      |> Map.get(:nested_msgs)
      |> Enum.flat_map(fn msg_fqn ->
        msg_desc = Metadata.get_desc_by_fqn(msg_fqn)
        msg_md = Metadata.get_metadata_by_fqn(msg_fqn)
        [{msg_md, msg_desc} | all_messages(msg_md)]
      end)
    end

    @doc """
    Read all nested enums
    """
    def all_enums(_msg) do
    end

    @doc """
    Read all direct enums
    """
    def enums(_msg) do
      []
    end

    @spec fields(__MODULE__.t()) :: [
            {Metadata.Field.t(), Google.Protobuf.FieldDescriptorProto.t()}
          ]
    def fields(msg) do
      msg
      |> Map.get(:fields)
      |> Enum.map(fn field_fqn ->
        {
          Metadata.get_metadata_by_fqn(field_fqn),
          Metadata.get_desc_by_fqn(field_fqn)
        }
      end)
    end
  end

  defmodule Field do
    @moduledoc ""

    @type t :: %__MODULE__{
            desc: map() | nil,
            fqn: String.t(),
            message: String.t()
          }

    defstruct desc: nil, fqn: "", message: ""
  end
end
