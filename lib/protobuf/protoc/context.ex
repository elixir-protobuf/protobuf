defmodule Protobuf.Protoc.Context do
  defstruct [
    # Package name of a file
    package: nil,
    # Nested namespace when generating nested messages. It should be joined to get the full namespace
    namespace: [],
    # Plugins passed by options
    plugins: [],
    # Mapping from file name to package name for all files
    pkg_mapping: %{},
    # Package names a file dependents on, sorting by length of names decreasingly
    dep_pkgs: []
  ]
end
