defmodule Co2Offset.DonationTest do
  use Co2Offset.DataCase, async: true

  alias Co2Offset.Calculators.Donation

  describe "when additional donation is 0" do
    test "when original donation is 3" do
      calculator = build(:calculator, original_donation: 3)

      expected = %{
        increased_donation: 1,
        decreased_donation: 0
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end

    test "when original donation is 30" do
      calculator = build(:calculator, original_donation: 30)

      expected = %{
        increased_donation: 3,
        decreased_donation: 0
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end

    test "when original donation is 182" do
      calculator = build(:calculator, original_donation: 182)

      expected = %{
        increased_donation: 18,
        decreased_donation: 0
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end
  end

  describe "when additional donation is not 0" do
    test "when additional donation is 3" do
      calculator = build(:calculator, original_donation: 3, additional_donation: 3)

      expected = %{
        increased_donation: 4,
        decreased_donation: 2
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end

    test "when additional donation is 30" do
      calculator = build(:calculator, original_donation: 3, additional_donation: 30)

      expected = %{
        increased_donation: 33,
        decreased_donation: 27
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end

    test "when additional donation is 182" do
      calculator = build(:calculator, original_donation: 3, additional_donation: 127)

      expected = %{
        increased_donation: 140,
        decreased_donation: 114
      }

      assert(Donation.calculate_new_donations(calculator) == expected)
    end
  end
end
