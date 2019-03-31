defmodule Co2Offset.CapitalsDistances do
  @moduledoc """
  Model which describes distance between all the capitals
  """
  use Ecto.Schema

  schema "capitals_distances" do
    field :capital_a, :string
    field :capital_b, :string
    field :distance, :float
  end
end
