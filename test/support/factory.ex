defmodule Co2Offset.Factory do
  use ExMachina.Ecto, repo: Co2Offset.Repo

  def calculator_factory do
    %Co2Offset.Calculators.Calculator{
      iata_from: "MSQ",
      iata_to: "SVO",
      city_from: "Minsk",
      city_to: "Moscow",
      original_distance: 642
    }
  end

  def airport_factory do
    %Co2Offset.Geo.Airport{
      city: "City",
      name: "Airport Name",
      iata: sequence(:iata, fn n -> generate_unique_string(n, 3) end),
      country: "Country",
      lat: 53.882499694824,
      long: 28.030700683594
    }
  end

  def capitals_distance_factory do
    %Co2Offset.Geo.CapitalsDistance{
      capital_from: sequence(:iata, fn n -> generate_unique_string(n, 3) end),
      capital_to: sequence(:iata, fn n -> generate_unique_string(n, 4) end),
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
