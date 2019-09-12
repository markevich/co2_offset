defmodule Co2Offset.Geo.AirportSchema do
  use Ecto.Schema

  @moduledoc """
  Airports schema. Generated from 3rd party data.
  Used for airports autocompletion.
  """

  schema "airports" do
    field :city, :string
    field :name, :string
    field :iata, :string
    field :country, :string
    field :lat, :float
    field :long, :float
  end
end
