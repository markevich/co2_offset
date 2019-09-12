defmodule Co2Offset.Donations.DonationSchema do
  use Ecto.Schema

  schema "donations" do
    field :iata_from, :string
    field :iata_to, :string
    field :original_city_from, :string
    field :original_city_to, :string
    field :original_distance, :integer
    field :original_co2, :float
    field :original_donation, :integer

    field :additional_city_from, :string
    field :additional_city_to, :string
    field :additional_distance, :integer
    field :additional_co2, :float
    field :additional_donation, :integer

    timestamps()
  end
end
