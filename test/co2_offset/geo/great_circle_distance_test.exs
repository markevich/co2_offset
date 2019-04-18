defmodule Co2Offset.Geo.GreatCircleDistanceTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.GreatCircleDistance

  test "correct calculations" do
    assert(GreatCircleDistance.call(-6.08, 145.39, -5.20, 145.78) == 107)
    assert(GreatCircleDistance.call(38.15, 21.42, 64.19, -83.35) == 6899)
  end
end
