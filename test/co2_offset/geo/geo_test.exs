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

  describe "search_airports" do
    setup do
      airport1 =
        insert(:airport,
          name: "Minsk national old",
          city: "Minsk",
          country: "Belarus",
          iata: "MS_"
        )

      airport2 =
        insert(:airport,
          name: "Minsk national",
          city: "Minsk 2",
          country: "Belarus",
          iata: "MR_"
        )

      airport3 =
        insert(:airport,
          name: "Sheremetevo",
          country: "Russia",
          city: "Moscow",
          iata: "SV_"
        )

      name_term = "nation"
      city_term = "mins"
      country_term = "bela"
      iata_term = "ms_"
      search_terms = [name_term, city_term, country_term]

      {:ok,
       airport1: airport1,
       airport2: airport2,
       airport3: airport3,
       search_terms: search_terms,
       iata_term: iata_term}
    end

    test "with different terms types", %{
      airport1: airport1,
      airport2: airport2,
      airport3: airport3,
      search_terms: search_terms
    } do
      for term <- search_terms do
        result = Geo.search_airports(term)

        assert Enum.any?(result, fn airport -> airport.id == airport1.id end)
        assert Enum.any?(result, fn airport -> airport.id == airport2.id end)
        refute Enum.any?(result, fn airport -> airport.id == airport3.id end)
      end
    end

    test "with iata term", %{
      airport1: airport1,
      iata_term: iata_term
    } do
      result = Geo.search_airports(iata_term)

      assert Enum.any?(result, fn airport -> airport.id == airport1.id end)
    end

    test "with empty search term" do
      assert %{} = Geo.search_airports("")
    end
  end
end
