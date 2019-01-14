defmodule Co2OffsetWeb.CalculatorView do
  use Co2OffsetWeb, :view

  def render("show.html", %{calculator: calculator}) do
    render_template("show.html", data: calculator)
  end

  def float_to_string(float) do
    float
    |> :erlang.float_to_binary([:compact, {:decimals, 2}])
  end
end
