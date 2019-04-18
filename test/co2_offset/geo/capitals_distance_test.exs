defmodule Co2Offset.Geo.CapitalsDistanceTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.CapitalsDistance

  test "valid factory" do
    assert(%CapitalsDistance{} = insert(:capitals_distance))
  end
end
