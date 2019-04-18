defmodule Co2Offset.CalculatorsTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Calculators
  alias Co2Offset.Calculators.Calculator

  describe "#create_calculator" do
    setup do
      airport_from = insert(:airport, city: "Minsk")
      airport_to = insert(:airport, city: "Moscow")

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "creates calculator", %{airport_from: airport_from, airport_to: airport_to} do
      iata_from = airport_from.iata
      iata_to = airport_to.iata
      city_from = airport_from.city
      city_to = airport_to.city

      attrs = %{iata_from: iata_from, iata_to: iata_to}

      result = Calculators.create_calculator(attrs)

      assert(
        {:ok,
         %Calculator{
           city_from: ^city_from,
           city_to: ^city_to,
           iata_from: ^iata_from,
           iata_to: ^iata_to,
           original_distance: 0
         }} = result
      )
    end
  end

  describe "#change_calculator" do
    test "returns changeset" do
      assert(%Ecto.Changeset{} = Calculators.change_calculator(%Calculator{}))
    end
  end

  describe "#get_calculator!" do
    setup do
      calculator = insert(:calculator)

      {:ok, calculator: calculator}
    end

    test "returns calculator", %{calculator: calculator} do
      calculator_id = calculator.id

      result = Calculators.get_calculator!(calculator.id)

      assert(%Calculator{id: ^calculator_id} = result)
    end
  end
end
