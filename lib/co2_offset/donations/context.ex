defmodule Co2Offset.Donations.Context do
  alias Co2Offset.Donations.{
    AdditionalDonationSchema,
    Calculator,
    DonationCreationSchema,
    DonationSchema
  }

  alias Co2Offset.Repo

  @moduledoc """
  This module is a root Donations context.
  """

  def donation_creation_changeset(donation \\ %DonationCreationSchema{}, attrs \\ %{}) do
    DonationCreationSchema.changeset(donation, attrs)
  end

  def create_donation(attrs \\ %{}) do
    %DonationCreationSchema{}
    |> DonationCreationSchema.changeset(attrs)
    |> Repo.insert()
  end

  def get_donation!(id), do: Repo.get!(DonationSchema, id)

  def increase_donation(donation) do
    %{increased_donation: increased_donation} = Calculator.calculate_new_donations(donation)

    {:ok, new_donation} =
      donation
      |> AdditionalDonationSchema.changeset(%{additional_donation: increased_donation})
      |> Repo.update()

    get_donation!(new_donation.id)
  end

  def decrease_donation(donation) do
    %{decreased_donation: decreased_donation} = Calculator.calculate_new_donations(donation)

    {:ok, new_donation} =
      donation
      |> AdditionalDonationSchema.changeset(%{additional_donation: decreased_donation})
      |> Repo.update()

    get_donation!(new_donation.id)
  end
end
