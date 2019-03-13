defmodule Co2Offset.Repo.Migrations.FixCapitalsDistances do
  use Ecto.Migration

  def change do
    alter table(:capitals_distances) do
      modify :distance, :integer
      remove :transport_type
      remove :inserted_at
      remove :updated_at
    end
  end
end
