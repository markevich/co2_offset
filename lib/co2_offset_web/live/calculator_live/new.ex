defmodule Co2OffsetWeb.CalculatorLive.New do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Calculators.Calculator
  alias Co2Offset.Geo
  alias Co2OffsetWeb.CalculatorLive.Show
  alias Co2OffsetWeb.Router.Helpers, as: Routes

  @moduledoc """
  Live view for Flights/new page.
  Dynamic content:
    flight_from, flight_to inputs
    form validation and submition
  """

  def render(assigns) do
    Co2OffsetWeb.CalculatorView.render("new.html", assigns)
  end

  def mount(_session, socket) do
    {:ok,
     assign(socket, %{
       changeset: Calculators.change_static_calculator(%Calculator{}),
       show_iata_from_autocomplete: false,
       show_iata_to_autocomplete: false,
       iata_from_autocomplete: %{},
       iata_to_autocomplete: %{}
     })}
  end

  def handle_event(
        "autocomplete",
        %{"calculator" => %{"iata_from" => iata_from, "iata_to" => iata_to}},
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

  def handle_event("save", %{"calculator" => calculator_params}, socket) do
    case Calculators.create_calculator(calculator_params) do
      {:ok, calculator} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, Show, calculator))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp get_autocomplete_records(term) do
    term
    |> Geo.search_airports()
    |> Enum.group_by(fn a -> a.city end)
  end
end
