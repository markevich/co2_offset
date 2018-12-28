defmodule Co2Offset.Converters.EtnoVolcanoTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.EtnoVolcano

  describe "convert" do
    test "co2_from_seconds returns a correct amount of co2 for 1 second" do
      assert(11.11 = EtnoVolcano.convert(1.0, :co2_from_seconds))
    end

    test "co2_from_seconds/1 returns a correct amount of co2 for 3 seconds" do
      assert(33.33 = EtnoVolcano.convert(3.0, :co2_from_seconds))
    end

    test "seconds_from_co2/1 returns a correct amount of seconds for 0.132 co2" do
      assert(1.0 = EtnoVolcano.convert(11.11, :seconds_from_co2))
    end

    test "seconds_from_co2/1 returns a correct amount of seconds for 0.396 co2" do
      assert(3.0 = EtnoVolcano.convert(33.33, :seconds_from_co2))
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
            seconds: 0.09,
            type: :etno_volcano
          }
        ]
      }

      assert(EtnoVolcano.convert_and_structure({co2, []}) == expected)
    end
  end
end
