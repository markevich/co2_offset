defmodule Co2Offset.Converters.EtnoVolcano do
  @moduledoc """
  Converter CO2 <-> seconds for etno volcano
  """
  @co2_per_second 11.11

  @spec convert_and_structure(%{optional(any) => any, co2: co2}) :: %{
          optional(any) => any,
          co2: co2,
          etno_volcano: %{seconds: float()}
        }
        when co2: float

  def convert_and_structure(acc) when is_map(acc) do
    acc[:co2]
    |> convert(:seconds_from_co2)
    |> structure(acc)
  end

  @spec convert(float(), :co2_from_seconds | :seconds_from_co2) :: float()
  def convert(seconds, :co2_from_seconds) when is_float(seconds) do
    # credo:disable-for-next-line
    (seconds * @co2_per_second) |> Float.round(4)
  end

  def convert(co2, :seconds_from_co2) when is_float(co2) do
    # credo:disable-for-next-line
    (co2 / @co2_per_second) |> Float.round(4)
  end

  defp structure(seconds, acc) do
    acc
    |> Map.put(:etno_volcano, %{seconds: seconds})
  end
end
