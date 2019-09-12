defmodule Co2Offset.Factory do
  use ExMachina.Ecto, repo: Co2Offset.Repo

  def donation_factory do
    %Co2Offset.Donations.DonationSchema{
      iata_from: "MSQ",
      iata_to: "SVO",
      original_city_from: "Minsk",
      original_city_to: "Moscow",
      original_distance: 642,
      original_co2: 231,
      original_donation: 5,
      additional_distance: 0,
      additional_donation: 0,
      additional_city_from: "",
      additional_city_to: "",
      additional_co2: 0
    }
  end

  def airport_factory do
    %Co2Offset.Geo.AirportSchema{
      city: "City",
      name: "Airport Name",
      iata: sequence(:iata, fn n -> generate_unique_string(n, 3) end),
      country: "Country",
      lat: 53.882499694824,
      long: 28.030700683594
    }
  end

  def distance_factory do
    %Co2Offset.Geo.DistanceSchema{
      from: sequence(:iata, fn n -> generate_unique_string(n, 3) end),
      to: sequence(:iata, fn n -> generate_unique_string(n, 4) end),
      distance: 42
    }
  end

  defp generate_unique_string(increment, length) when length < 10 do
    # credo:disable-for-lines:3
    array_generator(increment + 1, length, 25)
    |> Enum.map(fn item -> item + 65 end)
    |> to_string
  end

  defp array_generator(increment, depth, delimeter) when depth < 10 do
    generator(increment, depth, delimeter)
  end

  defp generator(n, 1, delimeter) do
    [rem(div(n, trunc(:math.pow(delimeter, 0))), delimeter)]
  end

  defp generator(n, depth, delimeter) do
    value = rem(div(n, trunc(:math.pow(delimeter, depth - 1))), delimeter)

    [value | generator(n, depth - 1, delimeter)]
  end
end
