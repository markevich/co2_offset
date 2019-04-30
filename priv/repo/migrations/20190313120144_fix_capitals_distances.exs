defmodule Co2Offset.Repo.Migrations.FixDistances do
  use Ecto.Migration

  def change do
    alter table(:distances) do
      modify :distance, :integer
      remove :transport_type
      remove :inserted_at
      remove :updated_at
    end

    create index(:distances, [:distance])
  end
end
