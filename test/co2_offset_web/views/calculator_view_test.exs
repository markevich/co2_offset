defmodule Co2OffsetWeb.CalculatorViewTest do
  use Co2OffsetWeb.ConnCase, async: true

  alias Co2OffsetWeb.CalculatorView

  test "float_to_string/1" do
    assert CalculatorView.float_to_string(6.666) == "6.67"
  end
end
