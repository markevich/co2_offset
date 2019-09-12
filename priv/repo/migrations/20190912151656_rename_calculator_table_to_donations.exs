defmodule Co2Offset.Repo.Migrations.RenameCalculatorTableToDonations do
  use Ecto.Migration

  def change do
    rename table(:calculators), to: table(:donations)
  end
end
