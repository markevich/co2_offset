defmodule Co2Offset.Geo.GeoTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo
  alias Co2Offset.Geo.Airport

  describe "#get_airport_by_iata" do
    setup do
      airport = insert(:airport)

      {:ok, airport: airport}
    end

    test "with existing iata", %{airport: airport} do
      iata = airport.iata

      result = Geo.get_airport_by_iata(iata)

      assert(%Airport{iata: ^iata} = result)
    end
  end

  describe "#distance_between_airports" do
    setup do
      airport_from = insert(:airport, lat: -6.08, long: 145.39)
      airport_to = insert(:airport, lat: -5.20, long: 145.78)

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "returns correct result", %{airport_from: airport_from, airport_to: airport_to} do
      assert(Geo.distance_between_airports(airport_from, airport_to) == 107)
    end
  end
end
