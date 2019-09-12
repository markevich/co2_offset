defmodule Co2Offset.Donations.ContextTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Donations.Context, as: DonationsContext
  alias Co2Offset.Donations.DonationSchema

  describe "#create_donation" do
    setup do
      airport_from = insert(:airport, city: "Minsk")
      airport_to = insert(:airport, city: "Moscow")

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "creates donation", %{airport_from: airport_from, airport_to: airport_to} do
      iata_from = airport_from.iata
      iata_to = airport_to.iata
      original_city_from = airport_from.city
      original_city_to = airport_to.city

      attrs = %{iata_from: iata_from, iata_to: iata_to}

      result = DonationsContext.create_donation(attrs)

      assert(
        {:ok,
         %DonationSchema{
           original_city_from: ^original_city_from,
           original_city_to: ^original_city_to,
           iata_from: ^iata_from,
           iata_to: ^iata_to,
           original_distance: 0
         }} = result
      )
    end
  end

  describe "#change_static_donation" do
    test "returns changeset" do
      assert(%Ecto.Changeset{} = DonationsContext.change_static_donation(%DonationSchema{}))
    end
  end

  describe "#get_donation!" do
    setup do
      donation = insert(:donation)

      {:ok, donation: donation}
    end

    test "returns donation", %{donation: donation} do
      donation_id = donation.id

      result = DonationsContext.get_donation!(donation.id)

      assert(%DonationSchema{id: ^donation_id} = result)
    end
  end

  describe "#increase/decrease_donation" do
    setup do
      donation = insert(:donation, original_donation: 30, additional_donation: 5)
      insert(:capitals_distance)

      {:ok, donation: donation}
    end

    test "correctly increases donation", %{donation: donation} do
      new_donation = DonationsContext.increase_donation(donation)

      assert(%DonationSchema{additional_donation: 9} = new_donation)
    end

    test "correctly decreases donation", %{donation: donation} do
      new_donation = DonationsContext.decrease_donation(donation)

      assert(%DonationSchema{additional_donation: 1} = new_donation)
    end
  end
end
