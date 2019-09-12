defmodule Co2Offset.Donations.Context do
  alias Co2Offset.Donations.{Calculator, DonationSchema}
  alias Co2Offset.Repo

  @moduledoc """
  This module is a root Donations context.
  """

  def change_static_donation(donation, attrs \\ %{}) do
    DonationSchema.static_changeset(donation, attrs)
  end

  def create_donation(attrs \\ %{}) do
    %DonationSchema{}
    |> DonationSchema.static_changeset(attrs)
    |> Repo.insert()
  end

  def get_donation!(id), do: Repo.get!(DonationSchema, id)

  def increase_donation(donation) do
    %{increased_donation: increased_donation} = Calculator.calculate_new_donations(donation)

    {:ok, new_donation} =
      donation
      |> DonationSchema.dynamic_changeset(%{additional_donation: increased_donation})
      |> Repo.update()

    new_donation
  end

  def decrease_donation(donation) do
    %{decreased_donation: decreased_donation} = Calculator.calculate_new_donations(donation)

    {:ok, new_donation} =
      donation
      |> DonationSchema.dynamic_changeset(%{additional_donation: decreased_donation})
      |> Repo.update()

    new_donation
  end
end
