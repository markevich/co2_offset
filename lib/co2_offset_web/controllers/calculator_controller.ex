defmodule Co2OffsetWeb.CalculatorController do
  use Co2OffsetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
