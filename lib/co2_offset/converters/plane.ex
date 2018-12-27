defmodule Co2Offset.Converters.Plane do
  @co2_per_km 0.18

  @spec convert_and_structure({float(), [any()]}) ::
          {float(),
           nonempty_improper_list(
             any(),
             %{co2: float(), km: float(), type: :plane}
           )}
  def convert_and_structure({co2_amount, acc}) do
    km_amount =
      co2_amount
      |> convert(:km_from_co2)

    {
      co2_amount,
      [structured_info(km_amount, co2_amount) | acc]
    }
  end

  @spec convert(float(), :co2_from_km) :: float()
  def convert(value, :co2_from_km) do
    (value * @co2_per_km)
    |> Float.round(4)
  end

  @spec convert(float(), :km_from_co2) :: float()
  def convert(value, :km_from_co2) do
    (value / @co2_per_km)
    |> Float.round(4)
  end

  defp structured_info(km, co2) do
    %{
      type: :plane,
      km: km,
      co2: co2
    }
  end
end
