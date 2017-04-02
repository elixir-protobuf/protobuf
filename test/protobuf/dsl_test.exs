defmodule Protobuf.DSLTest do
  use ExUnit.Case, async: true

  defmodule User do
    use Protobuf

    defstruct [:major, :minor, :patch, :suffix]

    field :id, 1, required: true, type: :integer
    field :name, 2, optional: true, type: :string
    field :addrs, 4, repeated: true, type: :string
  end

  test "works" do
    msg_props = User.__message_props__
    assert msg_props.tags_map == %{1 => 1, 2 => 2, 4 => 4}
    field_props = msg_props.field_props
    assert %Protobuf.FieldProps{fnum: 1, name: "id", name_atom: :id,
      required: true, type: :integer, wire_type: :integer} = field_props[1]
    assert %Protobuf.FieldProps{fnum: 2, name: "name", name_atom: :name,
      optional: true, type: :string, wire_type: :string} = field_props[2]
    assert %Protobuf.FieldProps{fnum: 4, name: "addrs", name_atom: :addrs,
      repeated: true, type: :string, wire_type: :string} = field_props[4]
  end
end
