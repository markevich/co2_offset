defmodule Co2Offset.Repo.Migrations.CreateCapitalsDistances do
  use Ecto.Migration

  def change do
    create table(:capitals_distances) do
      add :capital_from, :string
      add :capital_to, :string
      add :distance, :float
      add :transport_type, :string

      timestamps()
    end
  end
end
