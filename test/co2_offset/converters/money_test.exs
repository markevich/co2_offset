defmodule Co2Offset.Converters.MoneyTest do
  use Co2Offset.DataCase

  alias Co2Offset.Converters.Money

  describe "convert" do
    test "co2_from_money returns a correct amount of co2 for 1 dollar" do
      assert(100 = Money.convert(1, :co2_from_money))
    end

    test "co2_from_money/1 returns a correct amount of co2 for 3 dollars" do
      assert(300 = Money.convert(3, :co2_from_money))
    end

    # FYI: Minimum amount of donation is 5
    test "money_from_co2/1 returns a correct amount of dollars for 100 co2" do
      assert(5 = Money.convert(100.0, :money_from_co2))
    end

    test "money_from_co2/1 returns a correct amount of dollars for 300 co2" do
      assert(5 = Money.convert(300.0, :money_from_co2))
    end

    test "money_from_co2/1 returns a correct amount of dollars for 1000 co2" do
      assert(10 = Money.convert(1000.0, :money_from_co2))
    end
  end

  describe "convert_and_structure" do
    test "returns correct struct" do
      co2 = 100.0

      expected = %{
        co2: co2,
        money: %{
          dollar: 5
        }
      }

      assert(Money.convert_and_structure(%{co2: co2}) == expected)
    end
  end
end
