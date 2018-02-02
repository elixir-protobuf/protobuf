defmodule Protobuf.Protoc.Context do
  defstruct plugins: [],
            # For all files
            # Plugins passed by options
            # Mapping from file name to package name
            pkg_mapping: %{},

            # For a file
            # Package name
            package: nil,
            # Package names a file dependents on, sorting by length of names decreasingly
            dep_pkgs: [],
            syntax: nil,

            # For a message
            # Nested namespace when generating nested messages. It should be joined to get the full namespace
            namespace: []
end
