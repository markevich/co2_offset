defmodule Co2Offset.Geo.AirportSchemaTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.AirportSchema

  test "valid factory" do
    assert(%AirportSchema{} = insert(:airport))
  end
end
