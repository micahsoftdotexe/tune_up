defmodule TuneUp.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    many_to_many :users, TuneUp.Accounts.User, join_through: "users_roles"
    many_to_many :permissions, TuneUp.Accounts.Permission, join_through: "roles_permissions"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> put_assoc(:permissions, Map.get(attrs, :permissions, []))
    |> validate_required([:name])
  end

  def permissions_changeset(role, attrs) do
    role
    |> cast(attrs, [])
    |> put_assoc(:permissions, Map.get(attrs, :permissions, []))
  end
end
