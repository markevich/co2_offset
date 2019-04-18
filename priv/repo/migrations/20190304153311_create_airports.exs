defmodule Co2Offset.Repo.Migrations.CreateAirports do
  use Ecto.Migration

  def change do
    create table(:airports) do
      add :name, :string, size: 65
      add :iata, :char, size: 3
      add :city, :string, size: 50
      add :country, :string, size: 50
      add :lat, :float
      add :long, :float
    end

    create unique_index(:airports, [:iata])
  end
end
