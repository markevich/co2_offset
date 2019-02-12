defmodule Co2Offset.Repo.Migrations.CreateCapitalsDistances do
  use Ecto.Migration

  def change do
    create table(:capitals_distances) do
      add :capital_a, :string
      add :capital_b, :string
      add :distance, :float
      add :transport_type, :string

      timestamps()
    end

    create index(:capitals_distances, [:distance])
  end
end
