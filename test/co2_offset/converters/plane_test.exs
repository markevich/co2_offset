defmodule Co2Offset.Converters.PlaneTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Plane

  describe "convert" do
    test "co2_from_km returns a correct amount of co2 for 1 km" do
      assert(0.36 = Plane.convert(1.0, :co2_from_km))
    end

    test "co2_from_km/1 returns a correct amount of co2 for 3km" do
      assert(1.08 = Plane.convert(3.0, :co2_from_km))
    end

    test "km_from_co2/1 returns a correct amount of km for 0.18 co2" do
      assert(1.0 = Plane.convert(0.36, :km_from_co2))
    end

    test "km_from_co2/1 returns a correct amount of km for 0.54 co2" do
      assert(3.0 = Plane.convert(1.08, :km_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 0.36

      expected = %{
        co2: co2,
        plane: %{
          km: 1
        }
      }

      assert(Plane.convert_and_structure(%{co2: co2}) == expected)
    end
  end
end
