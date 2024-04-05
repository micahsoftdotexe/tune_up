defmodule TuneUp.Repo.Migrations.RemoveOldTables do
  use Ecto.Migration

  def change do
    # drop foreign_key(:auth_assignment, name: :auth_assignment_user_id_fkey)
    if Ecto.Adapters.SQL.table_exists?(TuneUp.Repo, "migration") do
      rename table("migration"),  to: table(:yii_migrations)
    end
    drop table(:auth_item), mode: :cascade
    drop table(:auth_assignment), mode: :cascade
    drop table(:auth_item_child), mode: :cascade
    drop table(:auth_rule), mode: :cascade
  end
end
