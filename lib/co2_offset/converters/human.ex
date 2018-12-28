defmodule Co2Offset.Converters.Human do
  @co2_per_day 1

  def convert_and_structure({co2_amount, acc}) do
    days = co2_amount |> convert(:days_from_co2)

    {
      co2_amount,
      [structured_info(days, co2_amount) | acc]
    }
  end

  @spec convert(float(), :co2_from_days) :: float()
  def convert(value, :co2_from_days) do
    (value * @co2_per_day) |> Float.round(4)
  end

  @spec convert(float(), :days_from_co2) :: float()
  def convert(value, :days_from_co2) do
    (value / @co2_per_day) |> Float.round(4)
  end

  defp structured_info(days, co2) do
    %{
      type: :human,
      days: days,
      co2: co2
    }
  end
end
