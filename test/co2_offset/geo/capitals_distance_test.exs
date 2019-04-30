defmodule Co2Offset.Geo.DistanceTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.Distance

  test "valid factory" do
    assert(%Distance{} = insert(:capitals_distance))
  end
end
