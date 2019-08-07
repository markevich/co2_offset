defmodule Co2Offset.Converters do
  # credo:disable-for-next-line
  alias Co2Offset.Calculators.Calculator
  alias Co2Offset.Converters.{Beef, Car, Chicken, EtnoVolcano, Human, Money, Petrol, Plane, Train}
  alias Co2Offset.Geo

  @moduledoc """
  This module is a root converter context.
  """

  @spec generate_examples(Co2Offset.Calculators.Calculator.t()) :: map
  def generate_examples(%Calculator{} = calculator) do
    distance = calculator.original_distance + calculator.additional_distance

    distance
    |> from_plane()
    |> Map.drop([:plane, :co2, :money])
    |> Map.update!(:car, &put_distance_examples/1)
    |> Map.update!(:train, &put_distance_examples/1)
  end

  @spec from_plane(integer()) :: %{optional(any) => any}
  def from_plane(plane_km) when is_integer(plane_km) do
    co2 = Plane.convert(plane_km / 1.0, :co2_from_km)

    %{co2: co2}
    |> EtnoVolcano.convert_and_structure()
    |> Beef.convert_and_structure()
    |> Chicken.convert_and_structure()
    |> Petrol.convert_and_structure()
    |> Human.convert_and_structure()
    |> Train.convert_and_structure()
    |> Car.convert_and_structure()
    |> Plane.convert_and_structure()
    |> Money.convert_and_structure()
  end

  def co2_from_plane_km(km) do
    Plane.convert(km / 1.0, :co2_from_km)
  end

  def plane_km_from_co2(co2) do
    Plane.convert(co2 / 1.0, :km_from_co2)
  end

  def money_from_co2(co2) do
    Money.convert(co2, :money_from_co2)
  end

  def co2_from_money(money) do
    Money.convert(money, :co2_from_money)
  end

  defp put_distance_examples(converter) do
    %{from: location_from, to: location_to} =
      Geo.get_locations_with_similar_distance(converter[:km])

    converter
    |> Map.put(:example_from, location_from)
    |> Map.put(:example_to, location_to)
  end
end
