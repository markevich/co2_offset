defmodule Co2Offset.Converters.Human do
  @moduledoc """
  Converter CO2 <-> days for humans
  """
  @co2_per_day 1

  @spec convert_and_structure({float(), list()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) when is_float(co2_amount) and is_list(acc) do
    days = co2_amount |> convert(:days_from_co2)

    {
      co2_amount,
      [structured_info(days, co2_amount) | acc]
    }
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

  defp structured_info(days, co2) do
    %{
      type: :human,
      days: days,
      co2: co2
    }
  end
end
