defmodule Co2OffsetWeb.CalculatorLive.Show do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Converters
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    Co2OffsetWeb.CalculatorView.render("show.html", assigns)
  end

  def mount(%{path_params: %{"id" => id}}, socket) do
    {:ok, fetch(assign(socket, id: id))}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    calculator = Calculators.get_calculator!(id)
    converter = Converters.from_plane(calculator.original_distance)

    assign(socket, calculator: calculator, converter: converter)
  end
end
