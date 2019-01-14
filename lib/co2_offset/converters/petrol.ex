defmodule Co2Offset.Converters.Petrol do
  @moduledoc """
  Converter CO2 <-> Liters for cars
  """
  @co2_per_liter 2.34

  @spec convert_and_structure(%{optional(any) => any, co2: co2}) :: %{
          optional(any) => any,
          co2: co2,
          petrol: %{liters: float()}
        }
        when co2: float

  def convert_and_structure(acc) when is_map(acc) do
    acc[:co2]
    |> convert(:liter_from_co2)
    |> structure(acc)
  end

  @spec convert(float(), :co2_from_liter | :liter_from_co2) :: float()
  def convert(liter, :co2_from_liter) when is_float(liter) do
    # credo:disable-for-next-line
    (liter * @co2_per_liter) |> Float.round(4)
  end

  def convert(co2, :liter_from_co2) when is_float(co2) do
    # credo:disable-for-next-line
    (co2 / @co2_per_liter) |> Float.round(4)
  end

  defp structure(liters, acc) do
    acc
    |> Map.put(:petrol, %{liters: liters})
  end
end
