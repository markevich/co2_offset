defmodule Co2Offset.Repo.Migrations.CreateDistances do
  use Ecto.Migration

  def change do
    create table(:distances) do
      add :from, :string
      add :to, :string
      add :distance, :float
      add :transport_type, :string

      timestamps()
    end
  end
end
