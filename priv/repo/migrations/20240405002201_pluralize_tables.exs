defmodule TuneUp.Repo.Migrations.PluralizeTables do
  use Ecto.Migration

  def change do
      rename table("automobile"), to: table(:automobiles)
      rename table("customer"), to: table(:customers)
      rename table("note"), to: table(:notes)
      rename table("order"), to: table(:orders)
      rename table("part"), to: table(:parts)
      rename table("quantity_type"), to: table(:quantity_types)
      rename table("user"), to: table(:users)

  end
end
