defmodule Co2Offset.Donations.DonationSchemaTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Donations.DonationSchema

  test "valid factory" do
    assert(%DonationSchema{} = insert(:donation))
  end
end
