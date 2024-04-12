defmodule TuneUp.Customers.Automobile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "automobiles" do
    field :year, :string
    field :make, :string
    field :vin, :string
    field :model, :string
    field :motor_number, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(automobile, attrs) do
    automobile
    |> cast(attrs, [:vin, :make, :model, :year, :motor_number])
    |> validate_required([:vin, :make, :model, :year, :motor_number])
  end
end
