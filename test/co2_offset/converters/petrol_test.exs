defmodule Co2Offset.Converters.PetrolTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Petrol

  describe "convert" do
    test "co2_from_liter returns a correct amount of co2 for 1 liter" do
      assert(2.34 = Petrol.convert(1.0, :co2_from_liter))
    end

    test "co2_from_liter/1 returns a correct amount of co2 for 3 liter" do
      assert(7.02 = Petrol.convert(3.0, :co2_from_liter))
    end

    test "liter_from_co2/1 returns a correct amount of liter for 0.132 co2" do
      assert(1.0 = Petrol.convert(2.34, :liter_from_co2))
    end

    test "liter_from_co2/1 returns a correct amount of liter for 0.396 co2" do
      assert(3.0 = Petrol.convert(7.02, :liter_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 2.34

      expected = {
        co2,
        [
          %{
            co2: co2,
            liters: 1,
            type: :petrol
          }
        ]
      }

      assert(Petrol.convert_and_structure({co2, []}) == expected)
    end
  end
end
