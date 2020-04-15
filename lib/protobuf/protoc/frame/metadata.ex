defmodule Protobuf.Protoc.Metadata do
  @moduledoc """
  Most of functions read data from ETS.
  """

  defmodule Package do
    @moduledoc ""

    defstruct fqn: "", files: []

    def files(_pkg) do
    end
  end

  defmodule File do
    @moduledoc ""
    defstruct desc: nil, fqn: "", package: "", messages: []

    @doc """
    Read all direct messages and nested messages
    """
    def all_messages(_file) do
    end

    @doc """
    Read direct messages
    """
    def messages(_file) do
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
    defstruct desc: nil, fqn: "", namespace: "", file: "", parent_msg: "", fields: []

    @doc """
    Return all nested messages
    """
    def all_messages(_msg) do
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
    end
  end

  defmodule Field do
    @moduledoc ""
    defstruct desc: nil, fqn: "", message: ""
  end
end
