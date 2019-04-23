defmodule Co2OffsetWeb.CalculatorViewTest do
  use Co2OffsetWeb.ConnCase, async: true

  alias Co2OffsetWeb.CalculatorView

  test "to_float_string/1" do
    assert CalculatorView.to_float_string(6.666) == "6.67"
  end

  test "to_int/1" do
    assert CalculatorView.to_int(6.666) == 7
  end
end
