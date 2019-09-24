defmodule Co2Offset.Donations.DonationCreationSchema do
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__
  alias Co2Offset.Converters, as: Converters
  alias Co2Offset.Geo.Context, as: GeoContext

  schema "donations" do
    field :iata_from, :string
    field :iata_to, :string
    field :original_city_from, :string
    field :original_city_to, :string
    field :original_distance, :integer
    field :original_co2, :float
    field :original_donation, :integer

    field :airport_from, :map, virtual: true
    field :airport_to, :map, virtual: true

    timestamps()
  end

  def changeset(%DonationCreationSchema{} = donation_schema, attrs) do
    donation_schema
    |> cast(attrs, [:iata_from, :iata_to])
    |> validate_required([:iata_from, :iata_to])
    |> validate_length(:iata_from, is: 3)
    |> validate_length(:iata_to, is: 3)
    |> put_airports()
    |> validate_required([:airport_from, :airport_to])
    |> put_cities()
    |> validate_required([:original_city_from, :original_city_to])
    |> put_original_distance()
    |> validate_required([:original_distance])
    |> put_original_co2()
    |> put_original_donation()
    |> validate_required([:original_co2, :original_donation])
  end

  defp put_airports(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{iata_from: iata_from, iata_to: iata_to}} ->
        airport_from = GeoContext.get_airport_by_iata(iata_from)
        airport_to = GeoContext.get_airport_by_iata(iata_to)

        changeset
        |> put_change(:airport_from, airport_from)
        |> put_change(:airport_to, airport_to)

      _ ->
        changeset
    end
  end

  defp put_cities(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{airport_from: airport_from, airport_to: airport_to}
      } ->
        changeset
        |> put_change(:original_city_from, airport_from.city)
        |> put_change(:original_city_to, airport_to.city)

      _ ->
        changeset
    end
  end

  defp put_original_distance(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{airport_from: airport_from, airport_to: airport_to}
      } ->
        original_distance = GeoContext.distance_between_airports(airport_from, airport_to)

        changeset
        |> put_change(:original_distance, original_distance)

      _ ->
        changeset
    end
  end

  defp put_original_co2(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{original_distance: distance}
      } ->
        original_co2 = Converters.co2_from_plane_km(distance)

        changeset
        |> put_change(:original_co2, original_co2)

      _ ->
        changeset
    end
  end

  defp put_original_donation(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{original_co2: original_co2}
      } ->
        original_donation = Converters.money_from_co2(original_co2)

        changeset
        |> put_change(:original_donation, original_donation)

      _ ->
        changeset
    end
  end
end
