defmodule Co2Offset.Calculators do
  alias Co2Offset.Calculators.{Calculator, Donation}
  alias Co2Offset.Repo

  @moduledoc """
  This module is a root Calculator context.
  """

  def change_static_calculator(calculator, attrs \\ %{}) do
    Calculator.static_changeset(calculator, attrs)
  end

  def create_calculator(attrs \\ %{}) do
    %Calculator{}
    |> Calculator.static_changeset(attrs)
    |> Repo.insert()
  end

  def get_calculator!(id), do: Repo.get!(Calculator, id)

  def increase_donation(calculator) do
    %{increased_donation: increased_donation} = Donation.calculate_new_donations(calculator)

    {:ok, new_calculator} =
      calculator
      |> Calculator.dynamic_changeset(%{additional_donation: increased_donation})
      |> Repo.update()

    new_calculator
  end

  def decrease_donation(calculator) do
    %{decreased_donation: decreased_donation} = Donation.calculate_new_donations(calculator)

    {:ok, new_calculator} =
      calculator
      |> Calculator.dynamic_changeset(%{additional_donation: decreased_donation})
      |> Repo.update()

    new_calculator
  end
end
