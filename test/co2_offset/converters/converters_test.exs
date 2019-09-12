defmodule Co2Offset.ConvertersTest do
  @moduledoc false

  use Co2Offset.DataCase

  alias Co2Offset.Converters

  describe "generate_examples/1" do
    setup do
      insert(:capitals_distance, from: "Minsk", to: "Moscow", distance: 10_000)
      insert(:capitals_distance, from: "Paris", to: "Copenhagen", distance: 2000)

      donation = insert(:donation, original_distance: 700, additional_distance: 1)

      {:ok, %{donation: donation}}
    end

    test "returns correct examples", %{donation: donation} do
      expected = %{
        beef: %{kg: 7.2936},
        car: %{example_from: "Paris", example_to: "Copenhagen", km: 1911.8182},
        chicken: %{kg: 54.0385},
        etno_volcano: %{seconds: 0.0227},
        human: %{days: 252.36},
        petrol: %{liters: 107.8462},
        train: %{example_from: "Minsk", example_to: "Moscow", km: 11_216.0}
      }

      assert(Converters.generate_examples(donation) == expected)
    end
  end

  describe "from_plane/1" do
    test "returns a correct mapping" do
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
        },
        money: %{
          dollar: 5
        }
      }

      assert(Converters.from_plane(km) == expected)
    end
  end

  describe "co2_from_plane_km/1" do
    test "returns correct numbers" do
      assert(252.0 = Converters.co2_from_plane_km(700))
    end
  end

  describe "money_from_co2/1" do
    test "returns correct numbers" do
      assert(10 = Converters.money_from_co2(1000.0))
    end
  end
end
