defmodule Co2Offset.Geo.Airport do
  use Ecto.Schema

  @moduledoc """
  Airports model. Generated from 3rd party data.
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
