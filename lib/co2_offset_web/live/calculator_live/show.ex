defmodule Co2OffsetWeb.CalculatorLive.Show do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Converters
  alias Co2Offset.Geo
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    Co2OffsetWeb.CalculatorView.render("show.html", assigns)
  end

  def mount(%{path_params: %{"id" => id}}, socket) do
    new_socket =
      socket
      |> assign(id: id)
      |> assign_converters
      |> assign_similar_distances

    {:ok, new_socket}
  end

  defp assign_converters(%Socket{assigns: %{id: id}} = socket) do
    calculator = Calculators.get_calculator!(id)
    converters = Converters.from_plane(calculator.original_distance)

    assign(socket, calculator: calculator, converters: converters)
  end

  defp assign_similar_distances(%Socket{assigns: %{converters: converters}} = socket) do
    new_converters =
      converters
      |> Map.update!(:car, &put_distance_examples/1)
      |> Map.update!(:train, &put_distance_examples/1)

    assign(socket, converters: new_converters)
  end

  defp put_distance_examples(converter) do
    %{from: location_from, to: location_to} =
      Geo.get_locations_with_similar_distance(converter[:km])

    converter
    |> Map.put(:example_from, location_from)
    |> Map.put(:example_to, location_to)
  end
end
