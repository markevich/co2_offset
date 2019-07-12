defmodule Co2Offset.Repo.Migrations.RenameOriginalDistanceToOriginalDonation do
  use Ecto.Migration

  def change do
    rename table(:calculators), :original_money, to: :original_donation
  end
end
