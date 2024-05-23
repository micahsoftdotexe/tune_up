defmodule TuneUp.Repo.Migrations.RenameMigrations do
  use Ecto.Migration

  def change do
    # drop foreign_key(:auth_assignment, name: :auth_assignment_user_id_fkey)
    if Ecto.Adapters.SQL.table_exists?(TuneUp.Repo, "migration") do
      rename table("migration"), to: table(:yii_migrations)
    end
  end
end
