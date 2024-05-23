defmodule TuneUp.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:roles, [:name])

    create table(:users_roles) do
      add :role_id, references(:roles)
      add :user_id, references(:users)
    end

    create unique_index(:users_roles, [:user_id, :role_id])

    create table(:roles_permissions) do
      add :role_id, references(:roles)
      add :permission_id, references(:permissions)
    end

    create unique_index(:roles_permissions, [:role_id, :permission_id])
  end
end
