defmodule Co2Offset.Converters.EtnoVolcano do
  @co2_per_second 11.11

  @spec convert_and_structure({float(), any()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) do
    seconds = co2_amount |> convert(:seconds_from_co2)

    {
      co2_amount,
      [structured_info(seconds, co2_amount) | acc]
    }
  end

  @spec convert(float(), :co2_from_seconds | :seconds_from_co2) :: float()
  def convert(value, :co2_from_seconds) do
    (value * @co2_per_second) |> Float.round(4)
  end

  def convert(value, :seconds_from_co2) do
    (value / @co2_per_second) |> Float.round(4)
  end

  defp structured_info(seconds, co2) do
    %{
      type: :etno_volcano,
      seconds: seconds,
      co2: co2
    }
  end
end
