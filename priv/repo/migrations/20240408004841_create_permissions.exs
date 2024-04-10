defmodule TuneUp.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string
      add :description, :string
      add :hidden, :boolean, default: false

      timestamps(type: :utc_datetime)
    end
    create table(:users_permissions, primary_key: false) do
      add :permission_id, references(:permissions, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end
    create unique_index(:users_permissions, [:user_id, :permission_id])
  end

end
