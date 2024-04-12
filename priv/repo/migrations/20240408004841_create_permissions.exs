defmodule TuneUp.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :hidden, :boolean, default: false

      timestamps(type: :utc_datetime)
    end
    create unique_index(:permissions, [:name])
    create table(:users_permissions, primary_key: false) do
      add :permission_id, references(:permissions)
      add :user_id, references(:users)
    end
    create unique_index(:users_permissions, [:user_id, :permission_id])
  end

end
