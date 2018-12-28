defmodule Co2Offset.Converters.Train do
  @moduledoc """
  Converter CO2 <-> km for trains
  """

  @co2_per_km 0.0225

  @spec convert_and_structure({float(), list()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) when is_float(co2_amount) and is_list(acc) do
    km_amount = co2_amount |> convert(:km_from_co2)

    {
      co2_amount,
      [structured_info(km_amount, co2_amount) | acc]
    }
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

  defp structured_info(km, co2) do
    %{
      type: :train,
      km: km,
      co2: co2
    }
  end
end
