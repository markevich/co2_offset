defmodule Co2Offset.Converters do
  alias Co2Offset.Converters.{Plane, Car, Human, Train, EtnoVolcano}

  @moduledoc """
  This module is a root converter context.
  """

  @spec from_plane(float()) :: {float(), nonempty_maybe_improper_list()}
  def from_plane(plane_km) when is_float(plane_km) do
    co2 = Plane.convert(plane_km, :co2_from_km)

    {co2, []}
    |> Plane.convert_and_structure
    |> Car.convert_and_structure
    |> Train.convert_and_structure
    |> Human.convert_and_structure
    |> EtnoVolcano.convert_and_structure
  end
end
