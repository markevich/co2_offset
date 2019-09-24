defmodule Co2Offset.Geo do
  import Ecto.Query, only: [from: 2]

  alias Co2Offset.Geo.AirportSchema
  alias Co2Offset.Geo.GreatCircleDistance
  alias Co2Offset.Repo

  @moduledoc """
  This module is a root Geo context.
  """

  def get_airport_by_iata(iata) do
    Repo.one(from a in AirportSchema, where: a.iata == ^String.upcase(iata))
  end

  def distance_between_airports(airport_from, airport_to) do
    GreatCircleDistance.call(
      airport_from.lat,
      airport_from.long,
      airport_to.lat,
      airport_to.long
    )
  end

  def get_locations_with_similar_distance(distance) do
    with {:ok, result} <- Repo.query(closest_distance_query(), [round(distance)]),
         %Postgrex.Result{rows: [[_id, from, to, _distance]]} <- result do
      %{from: from, to: to}
    end
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

    from a in AirportSchema,
      where:
        like(fragment("lower(?)", a.city), ^term) or
          like(fragment("lower(?)", a.country), ^term) or
          like(fragment("lower(?)", a.name), ^term) or
          like(fragment("lower(?)", a.iata), ^term),
      limit: 10
  end

  defp closest_distance_query do
    """
     SELECT * FROM
       (
         (SELECT * FROM distances WHERE distance >= $1 ORDER BY distance LIMIT 1)
             UNION ALL
         (SELECT * FROM distances WHERE distance < $1  ORDER BY distance DESC LIMIT 1)
       ) as foo
     ORDER BY abs($1 - distance) LIMIT 1;
    """
  end
end
