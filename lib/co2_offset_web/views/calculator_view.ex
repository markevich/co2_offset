defmodule Co2OffsetWeb.CalculatorView do
  use Co2OffsetWeb, :view

  def to_float_string(float) do
    float
    |> :erlang.float_to_binary([:compact, {:decimals, 2}])
  end

  def to_int(float) do
    round(float)
  end
end
