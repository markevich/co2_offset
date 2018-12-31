defmodule Co2Offset.Converters.Beef do
  @moduledoc """
  Converter CO2 <-> beef kg for humans
  """
  @co2_per_kg 34.6

  @spec convert_and_structure({float(), list()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) when is_float(co2_amount) and is_list(acc) do
    kg = co2_amount |> convert(:kg_from_co2)

    {
      co2_amount,
      [structured_info(kg, co2_amount) | acc]
    }
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

  defp structured_info(kg, co2) do
    %{
      type: :beef,
      kg: kg,
      co2: co2
    }
  end
end
