defmodule Co2OffsetWeb.CalculatorController do
  use Co2OffsetWeb, :controller

  alias Co2Offset.Calculators
  alias Co2Offset.Converters

  def show(conn, %{"id" => id}) do
    distance = Calculators.get_calculator!(id).original_distance
    float_distance = distance / 1.0

    calculator = Converters.from_plane(float_distance)

    render(conn, "show.html", calculator: calculator)
  end
end
