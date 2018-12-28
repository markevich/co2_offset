defmodule Co2Offset.Converters.EtnoVolcano do
  @moduledoc """
  Converter CO2 <-> seconds for etno volcano
  """
  @co2_per_second 11.11

  @spec convert_and_structure({float(), list()}) :: {float(), nonempty_maybe_improper_list()}
  def convert_and_structure({co2_amount, acc}) when is_float(co2_amount) and is_list(acc) do
    seconds = co2_amount |> convert(:seconds_from_co2)

    {
      co2_amount,
      [structured_info(seconds, co2_amount) | acc]
    }
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

  defp structured_info(seconds, co2) do
    %{
      type: :etno_volcano,
      seconds: seconds,
      co2: co2
    }
  end
end
