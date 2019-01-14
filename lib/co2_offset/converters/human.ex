defmodule Co2Offset.Converters.Human do
  @moduledoc """
  Converter CO2 <-> days for humans
  """
  @co2_per_day 1

  @spec convert_and_structure(%{optional(any) => any, co2: co2}) :: %{
          optional(any) => any,
          co2: co2,
          humans: %{days: float()}
        }
        when co2: float

  def convert_and_structure(acc) when is_map(acc) do
    acc[:co2]
    |> convert(:days_from_co2)
    |> structure(acc)
  end

  @spec convert(float(), :co2_from_days | :days_from_co2) :: float()
  def convert(days, :co2_from_days) when is_float(days) do
    # credo:disable-for-next-line
    (days * @co2_per_day) |> Float.round(4)
  end

  def convert(co2, :days_from_co2) when is_float(co2) do
    # credo:disable-for-next-line
    (co2 / @co2_per_day) |> Float.round(4)
  end

  defp structure(days, acc) do
    acc
    |> Map.put(:human, %{days: days})
  end
end
