defmodule Ext.MyPetIs do
  @moduledoc false
  use Protobuf, custom_field_options?: true, enum: true, syntax: :proto3

  option enum: :deprefix

  @type t :: integer | :A_CAT | :A_BIRD | :A_DOG | :A_UNKNOWN

  field :MY_PET_IS_A_CAT, 0
  field :MY_PET_IS_A_BIRD, 1
  field :MY_PET_IS_A_DOG, 2
  field :MY_PET_IS_A_UNKNOWN, 3
end

defmodule Ext.MySetIsA do
  @moduledoc false
  use Protobuf, custom_field_options?: true, enum: true, syntax: :proto3

  option enum: :lowercase

  @type t ::
          integer
          | :my_set_is_a_cat
          | :my_set_is_a_bird
          | :my_set_is_a_dog
          | :my_set_is_a_unknown
          | :set_horse

  field :MY_SET_IS_A_CAT, 0
  field :MY_SET_IS_A_BIRD, 1
  field :MY_SET_IS_A_DOG, 2
  field :MY_SET_IS_A_UNKNOWN, 3
  field :SET_HORSE, 4
end

defmodule Ext.TrafficFlight do
  @moduledoc false
  use Protobuf, custom_field_options?: true, enum: true, syntax: :proto3

  option enum: :atomize

  @type t :: integer | :color_invalid | :color_unset | :color_green | :color_yellow | :color_red

  field :TRAFFIC_FLIGHT_COLOR_INVALID, 0
  field :TRAFFIC_FLIGHT_COLOR_UNSET, 1
  field :TRAFFIC_FLIGHT_COLOR_GREEN, 2
  field :TRAFFIC_FLIGHT_COLOR_YELLOW, 3
  field :TRAFFIC_FLIGHT_COLOR_RED, 4
end

defmodule Ext.EnumTestMessage do
  @moduledoc false
  use Protobuf, custom_field_options?: true, syntax: :proto3

  @type t :: %__MODULE__{
          pet: Ext.MyPetIs.t(),
          set: Ext.MySetIsA.t(),
          flight_color: Ext.TrafficFlight.t(),
          color: Ext.TrafficLightColor.t()
        }
  defstruct [:pet, :set, :flight_color, :color]

  def full_name do
    "ext.EnumTestMessage"
  end

  field :pet, 1, type: Ext.MyPetIs, enum: true
  field :set, 2, type: Ext.MySetIsA, enum: true
  field :flight_color, 3, type: Ext.TrafficFlight, enum: true, json_name: "flightColor"
  field :color, 4, type: Ext.TrafficLightColor, enum: true
end
