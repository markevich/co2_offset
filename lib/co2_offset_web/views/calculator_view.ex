defmodule Co2OffsetWeb.CalculatorView do
  use Co2OffsetWeb, :view

  def render("show.html", %{calculator: calculator}) do
    {co2_amount, data} = calculator

    render_template("show.html", co2_amount: co2_amount, data: data)
  end

  def float_to_string(float) do
    float
    |> :erlang.float_to_binary([:compact, {:decimals, 2}])
  end
end
