defmodule Co2Offset.Donations.DonationCreationSchemaTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Donations.DonationCreationSchema

  @valid_attrs params_for(:donation)

  @required_attributes [
    :iata_from,
    :iata_to,
    :original_city_from,
    :original_city_to,
    :original_distance
  ]
  test "validates required attributes" do
    attrs = Map.drop(@valid_attrs, @required_attributes)

    changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

    for attribute <- @required_attributes do
      assert %{^attribute => ["can't be blank"]} = errors_on(changeset)
    end
  end

  @attributes_with_length [:iata_from, :iata_to]
  test "validate length of attributes" do
    attrs =
      for attribute <- @attributes_with_length, into: @valid_attrs do
        {attribute, "LongLongString"}
      end

    changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

    for attribute <- @attributes_with_length do
      assert %{^attribute => ["should be 3 character(s)"]} = errors_on(changeset)
    end
  end

  @protected_attributes [
    :original_city_from,
    :original_city_to,
    :original_distance,
    :airport_from,
    :airport_to
  ]
  test "refuse protected attributes" do
    attrs =
      for attribute <- @protected_attributes, into: @valid_attrs do
        {attribute, "You shall not pass"}
      end

    changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

    for attribute <- @protected_attributes do
      assert %{^attribute => ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "when input is correct" do
    setup do
      airport_from = insert(:airport, city: "Minsk", lat: 53.882499694824, long: 28.030700683594)
      airport_to = insert(:airport, city: "Moscow", lat: 55.972599, long: 37.4146)

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "returns valid changeset", %{airport_from: airport_from, airport_to: airport_to} do
      original_city_from = airport_from.city
      original_city_to = airport_to.city
      iata_from = airport_from.iata
      iata_to = airport_to.iata

      attrs = %{iata_from: iata_from, iata_to: iata_to}

      changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

      assert(
        %Ecto.Changeset{
          valid?: true,
          changes: %{
            original_city_from: ^original_city_from,
            original_city_to: ^original_city_to,
            iata_from: ^iata_from,
            iata_to: ^iata_to,
            airport_from: ^airport_from,
            airport_to: ^airport_to,
            original_distance: 642,
            original_donation: 5,
            original_co2: 231.12
          }
        } = changeset
      )
    end
  end

  describe "when input iata_from is incorrect" do
    setup do
      airport_from = insert(:airport)
      airport_to = insert(:airport)

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "with invalid iata_from", %{airport_to: airport_to} do
      iata_from = "🤷‍♀️🤷‍♀️🤷‍♀️"
      iata_to = airport_to.iata

      attrs = %{iata_from: iata_from, iata_to: iata_to}
      changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

      assert(
        %{
          airport_from: ["can't be blank"],
          original_city_from: ["can't be blank"],
          original_city_to: ["can't be blank"],
          original_distance: ["can't be blank"]
        } = errors_on(changeset)
      )

      refute(errors_on(changeset)[:airport_to] == ["can't be blank"])
    end

    test "with invalid iata_to", %{airport_from: airport_from} do
      iata_from = airport_from.iata
      iata_to = "🤷‍♂️🤷‍♂️🤷‍♂️"

      attrs = %{iata_from: iata_from, iata_to: iata_to}
      changeset = DonationCreationSchema.changeset(%DonationCreationSchema{}, attrs)

      assert(
        %{
          airport_to: ["can't be blank"],
          original_city_from: ["can't be blank"],
          original_city_to: ["can't be blank"],
          original_distance: ["can't be blank"]
        } = errors_on(changeset)
      )

      refute(errors_on(changeset)[:airport_from] == ["can't be blank"])
    end
  end
end
