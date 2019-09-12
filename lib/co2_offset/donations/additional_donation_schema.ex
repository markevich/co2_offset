defmodule Co2Offset.Donations.AdditionalDonationSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias Co2Offset.Converters
  alias Co2Offset.Geo

  schema "donations" do
    field :additional_city_from, :string
    field :additional_city_to, :string
    field :additional_distance, :integer
    field :additional_co2, :float
    field :additional_donation, :integer

    timestamps()
  end

  def changeset(donation, attrs) do
    donation
    |> cast(attrs, [:additional_donation])
    |> validate_required([:additional_donation])
    |> validate_number(:additional_donation, greater_than_or_equal_to: 0)
    |> put_additional_co2()
    |> put_additional_distance()
    |> put_additional_cities()
  end

  defp put_additional_co2(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{additional_donation: additional_donation}} ->
        additional_co2 = Converters.co2_from_money(additional_donation)

        changeset
        |> put_change(:additional_co2, additional_co2 / 1.0)

      _ ->
        changeset
    end
  end

  defp put_additional_distance(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{additional_co2: additional_co2}} ->
        additional_distance = Converters.plane_km_from_co2(additional_co2)

        changeset
        |> put_change(:additional_distance, round(additional_distance))

      _ ->
        changeset
    end
  end

  defp put_additional_cities(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{additional_distance: additional_distance}} ->
        %{
          from: additional_city_from,
          to: additional_city_to
        } = Geo.get_locations_with_similar_distance(additional_distance)

        changeset
        |> put_change(:additional_city_from, additional_city_from)
        |> put_change(:additional_city_to, additional_city_to)

      _ ->
        changeset
    end
  end
end
