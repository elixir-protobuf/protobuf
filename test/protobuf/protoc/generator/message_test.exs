defmodule Protobuf.Protoc.Generator.MessageTest do
  use ExUnit.Case, async: true

  alias Protobuf.Protoc.Context
  alias Protobuf.Protoc.Generator.Comment
  alias Protobuf.Protoc.Generator.Message, as: Generator
  alias Protobuf.Protoc.Generator.Util
  alias Protobuf.TestHelpers

  test "generate/2 has right name" do
    ctx = %Context{}
    desc = %Google.Protobuf.DescriptorProto{name: "Foo"}
    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo do\n"
    assert msg =~ "use Protobuf, protoc_gen_elixir_version: \"#{Util.version()}\"\n"

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ]
                   }
               )
             )
  after
    TestHelpers.purge_modules([Foo])
  end

  test "generate/2 has right syntax" do
    ctx = %Context{syntax: :proto3}
    desc = %Google.Protobuf.DescriptorProto{name: "Foo"}
    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo do\n"

    assert msg =~
             "use Protobuf, protoc_gen_elixir_version: \"#{Util.version()}\", syntax: :proto3\n"

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ]
                   }
               )
             )
  after
    TestHelpers.purge_modules([Foo])
  end

  test "generate/2 has right name with package" do
    ctx = %Context{package: "pkg.name", module_prefix: "Pkg.Name"}
    desc = %Google.Protobuf.DescriptorProto{name: "Foo"}
    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Pkg.Name.Foo do\n"
  end

  test "generate/2 adds transform_module/1" do
    ctx = %Context{}
    desc = %Google.Protobuf.DescriptorProto{name: "Foo"}
    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    refute msg =~ "def transform_module()"

    ctx = %Context{transform_module: My.Transform.Module}
    desc = %Google.Protobuf.DescriptorProto{name: "Foo"}
    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "def transform_module(), do: My.Transform.Module\n"
  end

  test "generate/2 has right options" do
    ctx = %Context{package: "pkg.name"}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      options: %Google.Protobuf.MessageOptions{map_entry: true}
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "use Protobuf, map: true, protoc_gen_elixir_version: \"#{Util.version()}\"\n"
  end

  test "generate/2 has right fields" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "b",
          json_name: "b",
          number: 2,
          type: :TYPE_STRING,
          label: :LABEL_REQUIRED
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert msg =~ "field :a, 1, optional: true, type: :int32\n"
    assert msg =~ "field :b, 2, required: true, type: :string\n"
  end

  test "generate/2 has right fields with right defaults" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_BOOL,
          label: :LABEL_REQUIRED
        }
      ]
    }

    {[], [{_mod, _msg}]} = Generator.generate(ctx, desc)
  end

  test "generate/2 has right fields for proto3" do
    ctx = %Context{syntax: :proto3}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "b",
          json_name: "b",
          number: 2,
          type: :TYPE_STRING,
          label: :LABEL_REQUIRED
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "c",
          json_name: "c",
          number: 3,
          type: :TYPE_INT32,
          label: :LABEL_REPEATED
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     a: integer(),
                     b: String.t(),
                     c: [integer()]
                   }
               )
             )

    assert msg =~ "field :a, 1, type: :int32\n"
    assert msg =~ "field :b, 2, type: :string\n"
    assert msg =~ "field :c, 3, repeated: true, type: :int32\n"
  after
    TestHelpers.purge_modules([Foo])
  end

  test "generate/2 supports option :default" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          default_value: "42"
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "b",
          json_name: "b",
          number: 2,
          type: :TYPE_BOOL,
          label: :LABEL_OPTIONAL,
          default_value: "false"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, default: 42\n"
    assert msg =~ "field :b, 2, optional: true, type: :bool, default: false\n"
  end

  test "generate/2 supports option :default and uses right default if field is required" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_REQUIRED,
          default_value: "42"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, required: true, type: :int32, default: 42\n"
  end

  test "generate/2 supports option :packed" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          options: %Google.Protobuf.FieldOptions{packed: true}
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, packed: true, deprecated: false\n"
  end

  test "generated supports explicit option [packed = false] in proto3" do
    ctx = %Context{syntax: :proto3}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_BOOL,
          label: :LABEL_REQUIRED,
          options: %Google.Protobuf.FieldOptions{packed: false}
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert msg =~ "field :a, 1, type: :bool, packed: false"
  end

  test "generated supports [proto3_optional = true] in proto3" do
    ctx = %Context{syntax: :proto3}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          proto3_optional: true
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert msg =~ "field :a, 1, proto3_optional: true, type: :int32"
  end

  test "generate/2 supports option :deprecated" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          options: %Google.Protobuf.FieldOptions{deprecated: true}
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: :int32, deprecated: true\n"
  end

  test "generete/2 supports message type field" do
    ctx = %Context{
      dep_type_mapping: %{
        ".Bar" => %{type_name: "Bar"},
        ".Baz" => %{type_name: "Baz"}
      }
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "bar",
          json_name: "bar",
          number: 1,
          type: :TYPE_MESSAGE,
          label: :LABEL_OPTIONAL,
          type_name: ".Bar"
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "baz",
          json_name: "baz",
          number: 2,
          type: :TYPE_MESSAGE,
          label: :LABEL_REPEATED,
          type_name: ".Baz"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     bar: Bar.t() | nil,
                     baz: [Baz.t()]
                   }
               )
             )
  after
    TestHelpers.purge_modules([Foo])
  end

  test "generate/2 supports map field" do
    ctx = %Context{
      package: "foo_bar.ab_cd",
      dep_type_mapping: %{
        ".foo_bar.ab_cd.Foo.ProjectsEntry" => %{type_name: "FooBar.AbCd.Foo.ProjectsEntry"},
        ".foo_bar.ab_cd.Bar" => %{type_name: "FooBar.AbCd.Bar"}
      },
      module_prefix: "FooBar.AbCd"
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_MESSAGE,
          label: :LABEL_REPEATED,
          type_name: ".foo_bar.ab_cd.Foo.ProjectsEntry"
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ProjectsEntry",
          options: %Google.Protobuf.MessageOptions{map_entry: true},
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              json_name: "key",
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "value",
              json_name: "value",
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".foo_bar.ab_cd.Bar"
            }
          ]
        }
      ]
    }

    {[[]], [[{_, nested_msg}], {_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, repeated: true, type: FooBar.AbCd.Foo.ProjectsEntry, map: true\n"

    assert [{_mod, _bytecode}] = Code.compile_string(nested_msg)

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %FooBar.AbCd.Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     a: %{optional(integer()) => FooBar.AbCd.Bar.t() | nil}
                   }
               )
             )
  after
    TestHelpers.purge_modules([FooBar.AbCd.Foo])
  end

  test "generate/2 supports enum field" do
    ctx = %Context{
      package: "foo_bar.ab_cd",
      dep_type_mapping: %{
        ".foo_bar.ab_cd.EnumFoo" => %{type_name: "FooBar.AbCd.EnumFoo"}
      }
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_ENUM,
          label: :LABEL_OPTIONAL,
          type_name: ".foo_bar.ab_cd.EnumFoo"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: FooBar.AbCd.EnumFoo, enum: true\n"
  end

  test "generate/2 generate right enum type name with different package" do
    ctx = %Context{
      package: "foo_bar.ab_cd",
      dep_type_mapping: %{".other_pkg.EnumFoo" => %{type_name: "OtherPkg.EnumFoo"}}
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_ENUM,
          label: :LABEL_OPTIONAL,
          type_name: ".other_pkg.EnumFoo"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.EnumFoo, enum: true\n"
  end

  test "generate/2 generate right message type name with different package" do
    ctx = %Context{
      package: "foo_bar.ab_cd",
      dep_type_mapping: %{".other_pkg.MsgFoo" => %{type_name: "OtherPkg.MsgFoo"}}
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_MESSAGE,
          label: :LABEL_OPTIONAL,
          type_name: ".other_pkg.MsgFoo"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)
    assert msg =~ "field :a, 1, optional: true, type: OtherPkg.MsgFoo\n"

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %FooBar.AbCd.Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     a: OtherPkg.MsgFoo.t() | nil
                   }
               )
             )
  after
    TestHelpers.purge_modules([FooBar.AbCd.Foo])
  end

  test "generate/2 supports nested messages" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      nested_type: [
        %Google.Protobuf.DescriptorProto{name: "Nested"}
      ]
    }

    {[[]], [[{_mod, msg}], _]} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.Nested do\n"
  end

  test "generate/2 supports nested messages with right defaults" do
    ctx = %Context{
      package: "my_pkg",
      dep_type_mapping: %{".my_pkg.Nested" => %{type_name: "MyPkg.Foo.Nested"}}
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_MESSAGE,
          label: :LABEL_REQUIRED,
          type_name: ".my_pkg.Nested"
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{name: "Nested"}
      ]
    }

    {[[]], [[{_, nested_msg}], {_, main_msg}]} = Generator.generate(ctx, desc)
    assert nested_msg =~ "defmodule MyPkg.Foo.Nested do\n"

    assert main_msg =~ "defmodule MyPkg.Foo do"

    assert main_msg =~ "field :a, 1, required: true, type: MyPkg.Foo.Nested"

    assert [{compiled_mod, bytecode}] = Code.compile_string(main_msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %MyPkg.Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     a: MyPkg.Foo.Nested.t() | nil
                   }
               )
             )
  after
    TestHelpers.purge_modules([MyPkg.Foo])
  end

  test "generate/2 supports nested enum messages" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "EnumFoo",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{name: "a", number: 0},
                %Google.Protobuf.EnumValueDescriptorProto{name: "b", number: 1}
              ]
            }
          ],
          name: "Nested"
        }
      ]
    }

    {[[{_mod, msg}]], _} = Generator.generate(ctx, desc)
    assert msg =~ "defmodule Foo.Nested.EnumFoo do\n"
    assert msg =~ "use Protobuf, enum: true, protoc_gen_elixir_version: \"#{Util.version()}\"\n"

    assert msg =~ """
             field :a, 0
             field :b, 1
           """
  end

  test "generate/2 supports oneof" do
    ctx = %Context{}

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{name: "first"},
        %Google.Protobuf.OneofDescriptorProto{name: "second"}
      ],
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          oneof_index: 0
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "b",
          json_name: "b",
          number: 2,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          oneof_index: 0
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "c",
          json_name: "c",
          number: 3,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          oneof_index: 1
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "d",
          json_name: "d",
          number: 4,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL,
          oneof_index: 1
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "other",
          json_name: "other",
          number: 5,
          type: :TYPE_INT32,
          label: :LABEL_OPTIONAL
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     first: {:a, integer()} | {:b, integer()} | nil,
                     other: integer() | nil,
                     second: {:c, integer()} | {:d, integer()} | nil
                   }
               )
             )

    refute msg =~ "a: integer,\n"

    assert msg =~ "oneof :first, 0\n"
    assert msg =~ "oneof :second, 1\n"
    assert msg =~ "field :a, 1, optional: true, type: :int32, oneof: 0\n"
    assert msg =~ "field :b, 2, optional: true, type: :int32, oneof: 0\n"
    assert msg =~ "field :c, 3, optional: true, type: :int32, oneof: 1\n"
    assert msg =~ "field :d, 4, optional: true, type: :int32, oneof: 1\n"
    assert msg =~ "field :other, 5, optional: true, type: :int32\n"
  after
    TestHelpers.purge_modules([Foo])
  end

  describe "generate/2 json_name" do
    test "is added when it differs from the original field name" do
      ctx = %Context{syntax: :proto3}

      desc = %Google.Protobuf.DescriptorProto{
        name: "Foo",
        field: [
          %Google.Protobuf.FieldDescriptorProto{
            name: "simple",
            json_name: "simple",
            number: 1,
            type: :TYPE_INT32,
            label: :LABEL_OPTIONAL
          },
          %Google.Protobuf.FieldDescriptorProto{
            name: "the_field_name",
            json_name: "theFieldName",
            number: 2,
            type: :TYPE_STRING,
            label: :LABEL_OPTIONAL
          }
        ]
      }

      {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

      assert msg =~ "field :simple, 1, type: :int32\n"
      assert msg =~ "field :the_field_name, 2, type: :string, json_name: \"theFieldName\"\n"
    end

    test "is omitted when syntax is not proto3" do
      ctx = %Context{}

      desc = %Google.Protobuf.DescriptorProto{
        name: "Foo",
        field: [
          %Google.Protobuf.FieldDescriptorProto{
            name: "the_field_name",
            json_name: "theFieldName",
            number: 1,
            type: :TYPE_STRING,
            label: :LABEL_REQUIRED
          }
        ]
      }

      {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

      assert msg =~ "field :the_field_name, 1, required: true, type: :string\n"
    end
  end

  test "generate/2 repeated enum field" do
    ctx = %Context{
      package: "foo_bar.ab_cd",
      dep_type_mapping: %{
        ".foo_bar.ab_cd.EnumFoo" => %{type_name: "FooBar.AbCd.EnumFoo"}
      }
    }

    desc = %Google.Protobuf.DescriptorProto{
      name: "Foo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "a",
          json_name: "a",
          number: 1,
          type: :TYPE_ENUM,
          label: :LABEL_REPEATED,
          type_name: ".foo_bar.ab_cd.EnumFoo"
        }
      ]
    }

    {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

    assert [{compiled_mod, bytecode}] = Code.compile_string(msg)

    assert TestHelpers.get_type_spec_as_string(compiled_mod, bytecode, :t) ==
             Macro.to_string(
               quote(
                 do:
                   t() :: %FooBar.AbCd.Foo{
                     __unknown_fields__: [
                       {field_number :: integer(), Protobuf.Wire.Types.wire_type(),
                        value :: term()}
                     ],
                     a: [FooBar.AbCd.EnumFoo.t()]
                   }
               )
             )
  after
    TestHelpers.purge_modules([FooBar.AbCd.Foo])
  end

  describe "generate/2 include_docs" do
    test "includes message comment for `@moduledoc` when flag is true" do
      ctx = %Context{
        comments: [%Comment{leading: "testing comment", path: []}],
        include_docs?: true
      }

      desc = %Google.Protobuf.DescriptorProto{name: "Foo"}

      {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

      assert msg =~ """
               @moduledoc \"\"\"
               testing comment
               \"\"\"
             """
    end

    test "includes `@moduledoc false` by default" do
      ctx = %Context{}
      desc = %Google.Protobuf.DescriptorProto{name: "Foo"}

      {[], [{_mod, msg}]} = Generator.generate(ctx, desc)

      assert msg =~ "@moduledoc false\n"
    end
  end
end
