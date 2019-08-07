defmodule Co2Offset.Calculators.Donation do
  alias Co2Offset.Calculators.Calculator

  def calculate_new_donations(%Calculator{
        original_donation: original_donation,
        additional_donation: additional_donation
      }) do
    full_donation = original_donation + additional_donation

    delta = max(1, round(full_donation / 10))

    %{
      decreased_donation: max(0, additional_donation - delta),
      increased_donation: additional_donation + delta
    }
  end
end
