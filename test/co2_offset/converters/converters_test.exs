defmodule Co2Offset.ConvertersTest do
  @moduledoc false

  use Co2Offset.DataCase

  alias Co2Offset.Converters

  describe "converters" do
    test "from_plane/1 returns a correct mapping" do
      # speed of a plane - 700km/h
      km = 700

      expected = %{
        co2: 252.0,
        plane: %{
          km: 700.0
        },
        car: %{
          km: 1909.0909
        },
        train: %{
          km: 11_200.0
        },
        human: %{
          days: 252.0
        },
        petrol: %{
          liters: 107.6923
        },
        chicken: %{
          kg: 53.9615
        },
        beef: %{
          kg: 7.2832
        },
        etno_volcano: %{
          seconds: 0.0227
        }
      }

      assert(Converters.from_plane(km) == expected)
    end
  end
end
