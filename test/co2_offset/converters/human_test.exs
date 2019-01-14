defmodule Co2Offset.Converters.HumanTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Human

  describe "convert" do
    test "co2_from_days returns a correct amount of co2 for 1 km" do
      assert(1.0 = Human.convert(1.0, :co2_from_days))
    end

    test "co2_from_days/1 returns a correct amount of co2 for 3km" do
      assert(3.0 = Human.convert(3.0, :co2_from_days))
    end

    test "days_from_co2/1 returns a correct amount of km for 0.132 co2" do
      assert(1.0 = Human.convert(1.0, :days_from_co2))
    end

    test "days_from_co2/1 returns a correct amount of km for 0.396 co2" do
      assert(3.0 = Human.convert(3.0, :days_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 1.0

      expected = %{
        co2: co2,
        human: %{
          days: 1.0
        }
      }

      assert(Human.convert_and_structure(%{co2: co2}) == expected)
    end
  end
end
