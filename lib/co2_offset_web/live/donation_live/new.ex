defmodule Co2OffsetWeb.DonationLive.New do
  use Phoenix.LiveView

  alias Co2Offset.Donations.Context, as: DonationsContext
  alias Co2Offset.Geo.Context, as: GeoContext
  alias Co2OffsetWeb.DonationLive.Show
  alias Co2OffsetWeb.Router.Helpers, as: Routes

  @moduledoc """
  Live view for Flights/new page.
  Dynamic content:
    flight_from, flight_to inputs
    form validation and submition
  """

  def render(assigns) do
    Co2OffsetWeb.DonationView.render("new.html", assigns)
  end

  def mount(_session, socket) do
    {:ok,
     assign(socket, %{
       changeset: DonationsContext.donation_creation_changeset(),
       show_iata_from_autocomplete: false,
       show_iata_to_autocomplete: false,
       iata_from_autocomplete: %{},
       iata_to_autocomplete: %{}
     })}
  end

  def handle_event(
        "autocomplete",
        %{"donation_creation_schema" => %{"iata_from" => iata_from, "iata_to" => iata_to}},
        socket
      ) do
    iata_from_autocomplete = get_autocomplete_records(iata_from)
    iata_to_autocomplete = get_autocomplete_records(iata_to)

    {:noreply,
     assign(socket,
       iata_from_autocomplete: iata_from_autocomplete,
       iata_to_autocomplete: iata_to_autocomplete
     )}
  end

  def handle_event(
        "set_iata_from",
        value,
        %Phoenix.LiveView.Socket{assigns: %{changeset: changeset}} = socket
      ) do
    new_changeset = Ecto.Changeset.put_change(changeset, :iata_from, value)

    {:noreply, assign(socket, %{changeset: new_changeset, show_iata_from_autocomplete: false})}
  end

  def handle_event(
        "set_iata_to",
        value,
        %Phoenix.LiveView.Socket{assigns: %{changeset: changeset}} = socket
      ) do
    new_changeset = Ecto.Changeset.put_change(changeset, :iata_to, value)

    {:noreply, assign(socket, changeset: new_changeset, show_iata_to_autocomplete: false)}
  end

  def handle_event("show_iata_from_autocomplete", _params, socket) do
    {:noreply,
     assign(socket, show_iata_from_autocomplete: true, show_iata_to_autocomplete: false)}
  end

  def handle_event("show_iata_to_autocomplete", _params, socket) do
    {:noreply,
     assign(socket, show_iata_to_autocomplete: true, show_iata_from_autocomplete: false)}
  end

  def handle_event("save", %{"donation_creation_schema" => donation_params}, socket) do
    case DonationsContext.create_donation(donation_params) do
      {:ok, donation} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, Show, donation))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp get_autocomplete_records(term) do
    term
    |> GeoContext.search_airports()
    |> Enum.group_by(fn a -> a.city end)
  end
end
