defmodule Co2Offset.Repo.Migrations.AddOriginalValuesToCalculators do
  use Ecto.Migration

  def change do
    alter table(:calculators) do
      add :original_money, :integer
      add :original_co2, :float
    end
  end
end
