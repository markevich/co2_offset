defmodule Co2Offset.Calculators do
  alias Co2Offset.Calculators.Calculator
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
end
