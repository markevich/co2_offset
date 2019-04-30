defmodule Co2Offset.Converters do
  # credo:disable-for-next-line
  alias Co2Offset.Converters.{Beef, Car, Chicken, EtnoVolcano, Human, Petrol, Plane, Train}

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
  end
end
