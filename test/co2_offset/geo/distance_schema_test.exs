defmodule Co2Offset.Geo.DistanceSchemaTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Geo.DistanceSchema

  test "valid factory" do
    assert(%DistanceSchema{} = insert(:distance))
  end
end
