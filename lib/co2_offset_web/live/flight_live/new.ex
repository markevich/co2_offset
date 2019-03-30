defmodule Co2OffsetWeb.FlightLive.New do
  use Phoenix.LiveView

  @moduledoc """
  Live view for Flights/new page.
  Dynamic content:
    flight_from, flight_to inputs
    form validation and submition
  """

  def render(assigns) do
    Co2OffsetWeb.FlightView.render("new.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_event("nav", _path, socket) do
    {:noreply, socket}
  end
end
