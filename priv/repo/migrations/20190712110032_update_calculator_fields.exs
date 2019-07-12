defmodule Co2Offset.Repo.Migrations.UpdateCalculatorFields do
  use Ecto.Migration

  def change do
    alter table(:calculators) do
      add :additional_city_from, :string
      add :additional_city_to, :string
      add :additional_distance, :integer, default: 0
      add :additional_co2, :float, default: 0
      add :additional_donation, :integer, default: 0
    end

    rename table(:calculators), :city_from, to: :original_city_from
    rename table(:calculators), :city_to, to: :original_city_to
  end
end
