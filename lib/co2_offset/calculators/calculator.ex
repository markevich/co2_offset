defmodule Co2Offset.Calculators.Calculator do
  require IEx
  use Ecto.Schema
  import Ecto.Changeset
  alias Co2Offset.Calculators.Calculator
  alias Co2Offset.Geo

  schema "calculators" do
    field :iata_from, :string
    field :iata_to, :string
    field :city_from, :string
    field :city_to, :string
    field :original_distance, :integer

    timestamps()
  end

  @doc false
  def changeset(%Calculator{} = calculator, attrs) do
    calculator
    |> cast(attrs, [:iata_from, :iata_to])
    |> validate_required([:iata_from, :iata_to])
    |> validate_length(:iata_from, is: 3)
    |> validate_length(:iata_to, is: 3)
    |> put_cities_and_distance()
    |> validate_required([:city_from, :city_to, :original_distance])
  end

  defp put_cities_and_distance(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{iata_from: iata_from, iata_to: iata_to}} ->
        airport_from = Geo.get_airport_by_iata(iata_from)
        airport_to = Geo.get_airport_by_iata(iata_to)

        original_distance = Geo.distance_between_airports(airport_from, airport_to)

        changeset
        |> put_change(:city_from, airport_from.city)
        |> put_change(:city_to, airport_to.city)
        |> put_change(:original_distance, original_distance)

      _ ->
        changeset
    end
  end
end
