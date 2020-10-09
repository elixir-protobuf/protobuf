defmodule Protobuf.EnumOptionsProcessorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Protobuf.EnumOptionsProcessor

  test "get transformers" do
    assert [:deprefix, :lowercase] ==
             EnumOptionsProcessor.get_transformers(
               enum: :atomize,
               enum: :deprefix,
               enum: :lowercase,
               enum: :atomize
             )

    assert [:deprefix] == EnumOptionsProcessor.get_transformers(enum: :deprefix)

    # doesn't validate
    assert [] == EnumOptionsProcessor.get_transformers(bad: "val")
  end

  test "validate opts!" do
    assert [enum: :lowercase] ==
             %Brex.Elixirpb.EnumOptions{
               lowercase: true,
               deprefix: nil,
               atomize: false
             }
             |> EnumOptionsProcessor.validate_opts!()

    assert [enum: :atomize, enum: :deprefix, enum: :lowercase] ==
             %Brex.Elixirpb.EnumOptions{
               lowercase: true,
               deprefix: true,
               atomize: true
             }
             |> EnumOptionsProcessor.validate_opts!()

    assert_raise RuntimeError,
                 "Unknown Enum Option {:lowercase, \"true\"}! " <>
                   "Possible Enum Options are atomize, deprefix, and lowercase.",
                 fn ->
                   %Brex.Elixirpb.EnumOptions{
                     lowercase: "true"
                   }
                   |> EnumOptionsProcessor.validate_opts!()
                 end

    assert_raise RuntimeError, "Unknown Custom Enum Option: %{lowercase: true}", fn ->
      %{
        lowercase: true
      }
      |> EnumOptionsProcessor.validate_opts!()
    end
  end

  test "cal prefix!" do
    fields = [
      %{name: "MY_PREFIX_CAN_SEE"},
      %{name: "MY_PREFIX_CAN_BEE"},
      %{name: "MY_PREFIX_CAN_KNEE"}
    ]

    assert "MY_PREFIX_" ==
             EnumOptionsProcessor.cal_prefix!("MyPrefix", fields, [:deprefix, :lowercase])

    assert "" == EnumOptionsProcessor.cal_prefix!("MyPrefix", fields, [:lowercase])

    assert "MY_PREFIX_CAN_" ==
             EnumOptionsProcessor.cal_prefix!("MyPrefixCan", fields, [:deprefix])

    assert_raise RuntimeError,
                 "Atomize or Deprefix custom enum option present, " <>
                   "but no consistent prefix found for \"MyPrefixBan\"!",
                 fn ->
                   EnumOptionsProcessor.cal_prefix!("MyPrefixBan", fields, [:deprefix])
                 end

    assert_raise RuntimeError,
                 "Atomize or Deprefix custom enum option present, " <>
                   "but no consistent prefix found for \"MyPrefixCan\"!",
                 fn ->
                   EnumOptionsProcessor.cal_prefix!("MyPrefixCan", fields ++ [%{name: "KEY"}], [
                     :deprefix
                   ])
                 end

    # Doesn't raise
    assert "" == EnumOptionsProcessor.cal_prefix!("my_prefix_ban", fields, [:lowercase])
  end

  test "generate types" do
    fields = [
      %{name: "MY_PREFIX_CAN_SEE"},
      %{name: "MY_PREFIX_CAN_BEE"},
      %{name: "MY_PREFIX_CAN_KNEE"}
    ]

    assert ":can_see | :can_bee | :can_knee" ==
             EnumOptionsProcessor.generate_types("MyPrefix", fields, %Brex.Elixirpb.EnumOptions{
               atomize: true
             })

    assert ":my_prefix_can_see | :my_prefix_can_bee | :my_prefix_can_knee" ==
             EnumOptionsProcessor.generate_types("MyPrefix", fields, %Brex.Elixirpb.EnumOptions{
               lowercase: true
             })

    assert ":CAN_SEE | :CAN_BEE | :CAN_KNEE" ==
             EnumOptionsProcessor.generate_types("MyPrefix", fields, %Brex.Elixirpb.EnumOptions{
               deprefix: true
             })

    assert_raise RuntimeError,
                 "Atomize or Deprefix custom enum option present, " <>
                   "but no consistent prefix found for \"MyPrefix\"!",
                 fn ->
                   EnumOptionsProcessor.generate_types(
                     "MyPrefix",
                     fields ++ [%{name: "Y"}],
                     %Brex.Elixirpb.EnumOptions{
                       deprefix: true
                     }
                   )
                 end
  end

  test "options str" do
    assert ["enum: :atomize", "enum: :deprefix", "enum: :lowercase"] ==
             EnumOptionsProcessor.options_str(%Brex.Elixirpb.EnumOptions{
               lowercase: true,
               deprefix: true,
               atomize: true
             })

    assert ["enum: :lowercase"] ==
             EnumOptionsProcessor.options_str(%Brex.Elixirpb.EnumOptions{
               lowercase: true,
               deprefix: nil,
               atomize: false
             })
  end

  test "generate mappings" do
    props = [
      {0,
       %Protobuf.FieldProps{
         fnum: 0,
         name: "MY_PREFIX_CAN_SEE",
         name_atom: :MY_PREFIX_CAN_SEE
       }},
      {1,
       %Protobuf.FieldProps{
         fnum: 1,
         name: "MY_PREFIX_CAN_BEE",
         name_atom: :MY_PREFIX_CAN_BEE
       }},
      {2,
       %Protobuf.FieldProps{
         fnum: 2,
         name: "MY_PREFIX_CAN_KNEE",
         name_atom: :MY_PREFIX_CAN_KNEE
       }},
      {3,
       %Protobuf.FieldProps{
         fnum: 3,
         name: "MY_PREFIX_CAN_TREE",
         name_atom: :MY_PREFIX_CAN_TREE
       }}
    ]

    fields = [
      {:MY_PREFIX_CAN_SEE, 0, []},
      {:MY_PREFIX_CAN_BEE, 1, []},
      {:MY_PREFIX_CAN_KNEE, 2, []},
      {:MY_PREFIX_CAN_TREE, 3, []},
      {:MY_PREFIX_CAN_TEE, 3, []}
    ]

    {atom_to_num, num_to_atom, string_or_num_to_atom, _accessor_funs} =
      EnumOptionsProcessor.generate_mappings(A.B.MyPrefix, props, fields,
        enum: :atomize,
        enum: :deprefix,
        enum: :lowercase
      )

    assert %{
             can_bee: 1,
             can_knee: 2,
             can_see: 0,
             can_tee: 3,
             can_tree: 3
           } == atom_to_num

    assert [
             {1, :can_bee},
             {2, :can_knee},
             {0, :can_see},
             {3, :can_tee},
             {3, :can_tree}
           ] == num_to_atom

    assert %{
             0 => :can_see,
             1 => :can_bee,
             2 => :can_knee,
             3 => :can_tree,
             "can_bee" => :can_bee,
             "can_knee" => :can_knee,
             "can_see" => :can_see,
             "can_tree" => :can_tree
           } == string_or_num_to_atom
  end
end
