defmodule Co2Offset.ConvertersTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters

  describe "converters" do
    test "from_plane/1 returns a correct mapping" do
      km = 1.0

      expected = {
        0.36,
        [
          %{
            co2: 0.36,
            km: 2.7273,
            type: :car
          },
          %{
            co2: 0.36,
            km: 1.0,
            type: :plane
          }
        ]
      }

      assert(Converters.from_plane(km) == expected)
    end
  end
end
