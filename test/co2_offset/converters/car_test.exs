defmodule Co2Offset.Converters.CarTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Car

  describe "convert" do
    test "co2_from_km returns a correct amount of co2 for 1 km" do
      assert(0.132 = Car.convert(1.0, :co2_from_km))
    end

    test "co2_from_km/1 returns a correct amount of co2 for 3km" do
      assert(0.396 = Car.convert(3.0, :co2_from_km))
    end

    test "km_from_co2/1 returns a correct amount of km for 0.132 co2" do
      assert(1.0 = Car.convert(0.132, :km_from_co2))
    end

    test "km_from_co2/1 returns a correct amount of km for 0.396 co2" do
      assert(3.0 = Car.convert(0.396, :km_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 0.132

      expected = %{
        co2: co2,
        car: %{
          km: 1.0
        }
      }

      assert(Car.convert_and_structure(%{co2: co2}) == expected)
    end
  end
end
