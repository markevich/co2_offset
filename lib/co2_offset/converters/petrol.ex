defmodule Co2Offset.Converters.Petrol do
  @moduledoc """
  Converter CO2 <-> Liters for cars
  """
  @co2_per_liter 2.34

  @spec convert_and_structure({float(), list()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) when is_float(co2_amount) and is_list(acc) do
    liter_amount = co2_amount |> convert(:liter_from_co2)

    {
      co2_amount,
      [structured_info(liter_amount, co2_amount) | acc]
    }
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

  defp structured_info(liter, co2) do
    %{
      type: :petrol,
      liters: liter,
      co2: co2
    }
  end
end
