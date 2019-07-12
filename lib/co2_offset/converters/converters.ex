defmodule Co2Offset.Converters do
  # credo:disable-for-next-line
  alias Co2Offset.Converters.{Beef, Car, Chicken, EtnoVolcano, Human, Money, Petrol, Plane, Train}

  @moduledoc """
  This module is a root converter context.
  """

  @spec from_plane(float()) :: %{optional(any) => any}
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

  def money_from_co2(co2) do
    Money.convert(co2 / 1.0, :money_from_co2)
  end
end
