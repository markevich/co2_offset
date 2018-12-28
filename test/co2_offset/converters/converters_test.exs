defmodule Co2Offset.ConvertersTest do
  @moduledoc false

  use Co2Offset.DataCase

  alias Co2Offset.Converters

  describe "converters" do
    test "from_plane/1 returns a correct mapping" do
      # speed of a plane - 700km/h
      km = 700.0

      expected = {
        252.0,
        [
          %{
            co2: 252.0,
            liters: 107.6923,
            type: :petrol
          },
          %{
            co2: 252.0,
            seconds: 22.6823,
            type: :etno_volcano
          },
          %{
            co2: 252.0,
            days: 252.0,
            type: :human
          },
          %{
            co2: 252.0,
            km: 11_200,
            type: :train
          },
          %{
            co2: 252.0,
            km: 1909.0909,
            type: :car
          },
          %{
            co2: 252.0,
            km: 700.0,
            type: :plane
          }
        ]
      }

      assert(Converters.from_plane(km) == expected)
    end
  end
end
