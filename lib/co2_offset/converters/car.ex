defmodule Co2Offset.Converters.Car do
  @moduledoc """
  Converter CO2 <-> KM for cars
  """
  @co2_per_km 0.132

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
    |> Map.put(:car, %{km: km})
  end
end
