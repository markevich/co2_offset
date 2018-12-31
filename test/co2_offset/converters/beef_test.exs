defmodule Co2Offset.Converters.BeefTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Beef

  describe "convert" do
    test "co2_from_kg returns a correct amount of co2 for 1 kg" do
      assert(34.6 = Beef.convert(1.0, :co2_from_kg))
    end

    test "co2_from_kg/1 returns a correct amount of co2 for 3km" do
      assert(103.8 = Beef.convert(3.0, :co2_from_kg))
    end

    test "kg_from_co2/1 returns a correct amount of kg for 0.132 co2" do
      assert(0.0289 = Beef.convert(1.0, :kg_from_co2))
    end

    test "kg_from_co2/1 returns a correct amount of kg for 0.396 co2" do
      assert(0.0867 = Beef.convert(3.0, :kg_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 1.0

      expected = {
        co2,
        [
          %{
            co2: 1.0,
            kg: 0.0289,
            type: :beef
          }
        ]
      }

      assert(Beef.convert_and_structure({co2, []}) == expected)
    end
  end
end
