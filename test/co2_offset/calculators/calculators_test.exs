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
      original_city_from = airport_from.city
      original_city_to = airport_to.city

      attrs = %{iata_from: iata_from, iata_to: iata_to}

      result = Calculators.create_calculator(attrs)

      assert(
        {:ok,
         %Calculator{
           original_city_from: ^original_city_from,
           original_city_to: ^original_city_to,
           iata_from: ^iata_from,
           iata_to: ^iata_to,
           original_distance: 0
         }} = result
      )
    end
  end

  describe "#change_static_calculator" do
    test "returns changeset" do
      assert(%Ecto.Changeset{} = Calculators.change_static_calculator(%Calculator{}))
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

  describe "#increase/decrease_donation" do
    setup do
      calculator = insert(:calculator, original_donation: 30, additional_donation: 5)
      insert(:capitals_distance)

      {:ok, calculator: calculator}
    end

    test "correctly increases donation", %{calculator: calculator} do
      new_calculator = Calculators.increase_donation(calculator)

      assert(%Calculator{additional_donation: 9} = new_calculator)
    end

    test "correctly decreases donation", %{calculator: calculator} do
      new_calculator = Calculators.decrease_donation(calculator)

      assert(%Calculator{additional_donation: 1} = new_calculator)
    end
  end
end
