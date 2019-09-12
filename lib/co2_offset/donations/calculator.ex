defmodule Co2Offset.Donations.Calculator do
  alias Co2Offset.Donations.DonationSchema

  def calculate_new_donations(%DonationSchema{
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
