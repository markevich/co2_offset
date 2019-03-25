defmodule Co2OffsetWeb.CalculatorChannel do
  use Phoenix.Channel
  alias Co2Offset.Converters

  @moduledoc """
  Calculator channel
  """

  def join("calculator:" <> _calculator_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("value_updated", %{"plane_km" => value}, socket) do
    {float_value, _} = Float.parse(value)

    new_values = Converters.from_plane(float_value)

    broadcast!(socket, "value_updated", %{new_values: new_values})

    {:noreply, socket}
  end
end
