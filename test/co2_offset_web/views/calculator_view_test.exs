defmodule Co2OffsetWeb.DonationViewTest do
  use Co2OffsetWeb.ConnCase, async: true

  alias Co2OffsetWeb.DonationView

  test "to_float_string/1" do
    assert DonationView.to_float_string(6.666) == "6.67"
  end

  test "to_int/1" do
    assert DonationView.to_int(6.666) == 7
  end
end
