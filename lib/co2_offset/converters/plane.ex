defmodule Co2Offset.Converters.Plane do
  @moduledoc """
  Converter CO2 <-> km for planes
  """

  # The emissions are around 0.18 kg CO2 per km.
  #
  # These CO2 emissions are generally into the high atmosphere,
  # and this is thought to have a greater greenhouse effect than
  # CO2 released at sea level.
  #
  # The emissions are therefore adjusted by multiplication by a factor of 2.00
  # to give 0.36 kg CO2 equivalent per km.
  @co2_per_km 0.18 * 2.0

  @spec convert_and_structure(%{optional(any) => any, co2: co2}) :: %{
          optional(any) => any,
          co2: co2,
          car: %{km: float()}
        }
        when co2: float

  def convert_and_structure(acc) when is_map(acc) do
    acc[:co2]
    |> convert(:km_from_co2)
    |> structure(acc)
  end

  @spec convert(float(), :co2_from_km | :km_from_co2) :: float()
  def convert(km, :co2_from_km) when is_float(km) do
    # credo:disable-for-next-line
    (km * @co2_per_km) |> Float.round(4)
  end

  def convert(co2, :km_from_co2) when is_float(co2) do
    # credo:disable-for-next-line
    (co2 / @co2_per_km) |> Float.round(4)
  end

  defp structure(km, acc) do
    acc
    |> Map.put(:plane, %{km: km})
  end
end
