defmodule TuneUp.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
    create table(:users_roles) do
      add :role_id, references(:roles, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end
    create unique_index(:users_roles, [:user_id, :role_id])
    create table(:roles_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all)
      add :permission_id, references(:permissions, on_delete: :delete_all)
    end
    create unique_index(:roles_permissions, [:role_id, :permission_id])
  end
end
