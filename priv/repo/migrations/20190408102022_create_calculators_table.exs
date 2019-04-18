defmodule Co2Offset.Repo.Migrations.CreateCalculatorsTable do
  use Ecto.Migration

  def change do
    create table(:calculators) do
      add :iata_from, :string, size: 3
      add :iata_to, :string, size: 3
      add :city_from, :string
      add :city_to, :string
      add :original_distance, :integer

      timestamps()
    end
  end
end
