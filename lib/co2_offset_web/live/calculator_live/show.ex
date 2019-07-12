defmodule Co2OffsetWeb.CalculatorLive.Show do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Converters
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
    examples = Converters.generate_examples(calculator)

    assign(socket, examples: examples)
  end
end
