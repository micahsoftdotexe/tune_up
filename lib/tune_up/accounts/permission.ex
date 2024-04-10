defmodule TuneUp.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :name, :string
    field :description, :string
    field :hidden, :boolean, default: false
    many_to_many :roles, TuneUp.Accounts.Role, join_through: "roles_permissions"
    many_to_many :users, TuneUp.Accounts.User, join_through: "users_permissions"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :description, :hidden])
    |> validate_required([:name])
  end
end
