defmodule Co2OffsetWeb.DonationLive.Show do
  use Phoenix.LiveView

  alias Co2Offset.Converters.Context, as: ConvertersContext
  alias Co2Offset.Donations.Context, as: DonationsContext
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    Co2OffsetWeb.DonationView.render("show.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    new_socket =
      socket
      |> assign(id: id)
      |> assign_donation()
      |> assign_additional_examples()

    {:noreply, new_socket}
  end

  def handle_event(
        "increase_donation",
        _params,
        %Socket{assigns: %{donation: donation}} = socket
      ) do
    new_donation = DonationsContext.increase_donation(donation)

    new_socket =
      socket
      |> assign(donation: new_donation)
      |> assign_additional_examples()

    {:noreply, new_socket}
  end

  def handle_event(
        "decrease_donation",
        _params,
        %Socket{assigns: %{donation: donation}} = socket
      ) do
    new_donation = DonationsContext.decrease_donation(donation)

    new_socket =
      socket
      |> assign(donation: new_donation)
      |> assign_additional_examples()

    {:noreply, new_socket}
  end

  defp assign_donation(%Socket{assigns: %{id: id}} = socket) do
    donation = DonationsContext.get_donation!(id)

    assign(socket, donation: donation)
  end

  defp assign_additional_examples(%Socket{assigns: %{donation: donation}} = socket) do
    examples = ConvertersContext.generate_examples(donation)

    assign(socket, examples: examples)
  end
end
