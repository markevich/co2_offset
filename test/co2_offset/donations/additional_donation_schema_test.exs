defmodule Co2Offset.Donations.AdditionalDonationSchemaTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Donations.AdditionalDonationSchema

  describe "dynamic changeset" do
    setup do
      donation = build(:donation, original_donation: 5)
      additional_donation = %AdditionalDonationSchema{id: donation.id}

      distance = insert(:capitals_distance, distance: 4167)

      {:ok, donation: additional_donation, distance: distance}
    end

    test "updates donation with new values", %{donation: donation, distance: distance} do
      attrs = %{additional_donation: 15}

      changeset = AdditionalDonationSchema.changeset(donation, attrs)
      city_from = distance.from
      city_to = distance.to

      assert(
        %Ecto.Changeset{
          valid?: true,
          changes: %{
            additional_donation: 15,
            additional_co2: 1.5e3,
            additional_city_from: ^city_from,
            additional_city_to: ^city_to,
            additional_distance: 4167
          }
        } = changeset
      )
    end

    test "invalid with incorrect additional donation", %{donation: donation} do
      attrs = %{additional_donation: -5}

      changeset = AdditionalDonationSchema.changeset(donation, attrs)

      assert(
        %{
          additional_donation: ["must be greater than or equal to 0"]
        } = errors_on(changeset)
      )
    end
  end
end
