defmodule Protobuf.JSON.RecursionLimitTest do
  use ExUnit.Case, async: true

  defmodule Node.ChildrenEntry do
    use Protobuf, map: true, syntax: :proto3

    field :key, 1, type: :string
    field :value, 2, type: Protobuf.JSON.RecursionLimitTest.Node
  end

  defmodule Node do
    use Protobuf, syntax: :proto3

    oneof :choice, 0

    field :child, 1, type: __MODULE__
    field :children, 2, type: __MODULE__, repeated: true

    field :children_by_name, 3,
      type: Protobuf.JSON.RecursionLimitTest.Node.ChildrenEntry,
      map: true,
      repeated: true,
      json_name: "childrenByName"

    field :chosen_child, 4, type: __MODULE__, oneof: 0, json_name: "chosenChild"
    field :any, 5, type: Google.Protobuf.Any
    field :value, 6, type: Google.Protobuf.Value
    field :struct, 7, type: Google.Protobuf.Struct
    field :list, 8, type: Google.Protobuf.ListValue
  end

  defmodule CycleA do
    use Protobuf, syntax: :proto3
    field :b, 1, type: Protobuf.JSON.RecursionLimitTest.CycleB
  end

  defmodule CycleB do
    use Protobuf, syntax: :proto3
    field :a, 1, type: Protobuf.JSON.RecursionLimitTest.CycleA
  end

  test "ordinary messages count the root and reject depth beyond the default limit" do
    assert_decodes(%{}, Node, recursion_limit: 1)
    assert_decodes(nest(99, &%{"child" => &1}), Node, [])
    assert_depth_error(nest(100, &%{"child" => &1}), Node, [], 100)
  end

  test "the same limit applies to singular, repeated, map and oneof message fields" do
    for wrap <- [
          &%{"child" => &1},
          &%{"children" => [&1]},
          &%{"childrenByName" => %{"key" => &1}},
          &%{"chosenChild" => &1}
        ] do
      data = nest(5, wrap)
      assert_boundary(data, Node, 6)
    end
  end

  test "cycles between distinct message types consume the same depth budget" do
    data = nest(3, &%{"b" => %{"a" => &1}})
    assert_boundary(data, CycleA, 7)
  end

  test "sibling messages do not consume each other's depth budget" do
    data = %{
      "child" => %{},
      "children" => List.duplicate(%{}, 200),
      "childrenByName" => Map.new(1..200, &{Integer.to_string(&1), %{}}),
      "chosenChild" => %{}
    }

    assert_boundary(data, Node, 2)
  end

  test "null fields and empty collections do not consume depth" do
    data = %{"child" => nil, "children" => [], "childrenByName" => %{}, "chosenChild" => nil}
    assert_decodes(data, Node, recursion_limit: 1)
  end

  test "nested Any values consume depth before decoding their contents" do
    data = Enum.reduce(1..5, %{}, fn _, inner -> pack_any(inner, Google.Protobuf.Any) end)
    assert_boundary(data, Google.Protobuf.Any, 6)
  end

  test "nested Any values beyond the default limit are rejected" do
    data = Enum.reduce(1..100, %{}, fn _, inner -> pack_any(inner, Google.Protobuf.Any) end)
    assert_depth_error(data, Google.Protobuf.Any, [], 100)
  end

  test "Any shares the depth budget with ordinary messages in both directions" do
    node = nest(2, &%{"child" => &1})
    data = %{"any" => pack_any(node, Node)}
    assert_boundary(data, Node, 5)
  end

  test "Any shares the depth budget with special JSON types" do
    data = pack_any([[1]], Google.Protobuf.ListValue)
    assert_boundary(data, Google.Protobuf.Any, 3)

    data = pack_any(%{"key" => %{}}, Google.Protobuf.Struct)
    assert_boundary(data, Google.Protobuf.Any, 3)
  end

  test "ordinary messages share the depth budget with Value, Struct and ListValue" do
    for data <- [
          %{"value" => %{"key" => [1]}},
          %{"struct" => %{"key" => [1]}},
          %{"list" => [%{"key" => 1}]}
        ] do
      assert_boundary(data, Node, 3)
    end
  end

  test "Value dispatch and JSON object conversion do not count twice" do
    assert_decodes(%{"key" => 1}, Google.Protobuf.Value, recursion_limit: 1)
    assert_decodes(%{"key" => 1}, Google.Protobuf.Struct, recursion_limit: 1)
    assert_decodes([1], Google.Protobuf.ListValue, recursion_limit: 1)
    assert_decodes(%{"value" => 1}, Node, recursion_limit: 1)
  end

  defp nest(depth, wrap), do: Enum.reduce(1..depth, %{}, fn _, inner -> wrap.(inner) end)

  defp pack_any(data, module) do
    type_url = "type.googleapis.com/" <> Enum.join(Module.split(module), ".")

    if module in [Google.Protobuf.Any, Google.Protobuf.ListValue, Google.Protobuf.Struct] do
      %{"@type" => type_url, "value" => data}
    else
      Map.put(data, "@type", type_url)
    end
  end

  defp assert_boundary(data, module, depth) do
    assert_decodes(data, module, recursion_limit: depth)
    assert_depth_error(data, module, [recursion_limit: depth - 1], depth - 1)
  end

  defp assert_decodes(data, module, opts) do
    assert {:ok, message} = Protobuf.JSON.from_decoded(data, module, opts)
    json = Jason.encode!(data)
    assert Protobuf.JSON.decode(json, module, opts) == {:ok, message}
    assert Protobuf.JSON.decode!(json, module, opts) == message
  end

  defp assert_depth_error(data, module, opts, limit) do
    message = "JSON value exceeds the recursion limit of #{limit}"
    error = {:error, %Protobuf.JSON.DecodeError{message: message}}
    assert Protobuf.JSON.from_decoded(data, module, opts) == error
    json = Jason.encode!(data)
    assert Protobuf.JSON.decode(json, module, opts) == error

    assert_raise Protobuf.JSON.DecodeError, message, fn ->
      Protobuf.JSON.decode!(json, module, opts)
    end
  end
end
