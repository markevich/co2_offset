defmodule Co2Offset.Converters.Chicken do
  @moduledoc """
  Converter CO2 <-> chicken kg for humans
  """
  @co2_per_kg 4.67

  @spec convert_and_structure(%{optional(any) => any, co2: co2}) :: %{
          optional(any) => any,
          co2: co2,
          chicken: %{kg: float()}
        }
        when co2: float

  def convert_and_structure(acc) when is_map(acc) do
    acc[:co2]
    |> convert(:kg_from_co2)
    |> structure(acc)
  end

  @spec convert(float(), :co2_from_kg | :kg_from_co2) :: float()
  def convert(kg, :co2_from_kg) when is_float(kg) do
    # credo:disable-for-next-line
    (kg * @co2_per_kg) |> Float.round(4)
  end

  def convert(co2, :kg_from_co2) when is_float(co2) do
    # credo:disable-for-next-line
    (co2 / @co2_per_kg) |> Float.round(4)
  end
  defp structure(kg, acc) do
    acc
    |> Map.put(:chicken, %{kg: kg})
  end
end
