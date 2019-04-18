defmodule Co2Offset.Geo do
  alias Co2Offset.Geo.Airport
  alias Co2Offset.Geo.GreatCircleDistance
  alias Co2Offset.Repo
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  This module is a root Geo context.
  """

  def get_airport_by_iata(iata) do
    Repo.one(from a in Airport, where: a.iata == ^String.upcase(iata))
  end

  def distance_between_airports(airport_from, airport_to) do
    GreatCircleDistance.call(
      airport_from.lat,
      airport_from.long,
      airport_to.lat,
      airport_to.long
    )
  end
end
