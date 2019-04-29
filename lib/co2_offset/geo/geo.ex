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

  def search_airports(term) when byte_size(term) <= 2 do
    %{}
  end

  def search_airports(term) do
    term
    |> String.downcase()
    |> form_query()
    |> Repo.all()
  end

  defp form_query(term) do
    term = "%#{term}%"

    from a in Airport,
      where:
        like(fragment("lower(?)", a.city), ^term) or
          like(fragment("lower(?)", a.country), ^term) or
          like(fragment("lower(?)", a.name), ^term) or
          like(fragment("lower(?)", a.iata), ^term),
      limit: 10
  end
end
