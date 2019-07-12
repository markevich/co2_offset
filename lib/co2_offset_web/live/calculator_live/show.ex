defmodule Co2OffsetWeb.CalculatorLive.Show do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Converters
  alias Co2Offset.Geo
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    Co2OffsetWeb.CalculatorView.render("show.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    new_socket =
      socket
      |> assign(id: id)
      |> assign_calculator()
      |> assign_additional_examples()

    {:noreply, new_socket}
  end

  def handle_event("increase_donation", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("decrease_donation", _params, socket) do
    {:noreply, socket}
  end

  defp assign_calculator(%Socket{assigns: %{id: id}} = socket) do
    calculator = Calculators.get_calculator!(id)

    assign(socket, calculator: calculator)
  end

  defp assign_additional_examples(%Socket{assigns: %{calculator: calculator}} = socket) do
    distance = calculator.original_distance + calculator.additional_distance

    examples =
      distance
      |> Converters.from_plane()
      |> Map.drop([:plane, :co2, :money])
      |> Map.update!(:car, &put_distance_examples/1)
      |> Map.update!(:train, &put_distance_examples/1)

    assign(socket, examples: examples)
  end

  defp put_distance_examples(converter) do
    %{from: location_from, to: location_to} =
      Geo.get_locations_with_similar_distance(converter[:km])

    converter
    |> Map.put(:example_from, location_from)
    |> Map.put(:example_to, location_to)
  end
end
