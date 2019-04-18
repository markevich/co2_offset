defmodule Co2Offset.Geo.AirportTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.Airport

  test "valid factory" do
    assert(%Airport{} = insert(:airport))
  end
end
