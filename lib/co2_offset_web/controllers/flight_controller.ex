defmodule Co2OffsetWeb.FlightController do
  use Co2OffsetWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
