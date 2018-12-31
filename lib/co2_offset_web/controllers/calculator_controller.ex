defmodule Co2OffsetWeb.CalculatorController do
  use Co2OffsetWeb, :controller

  alias Co2Offset.Converters

  def show(conn, _params) do
    calculator = Converters.from_plane(700.0)

    render(conn, "show.html", calculator: calculator)
  end
end
