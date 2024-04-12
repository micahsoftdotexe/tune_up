defmodule TuneUp.Orders.Labor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "labor" do
    field :description, :string
    field :notes, :string
    field :price, :float
    belongs_to :order, TuneUp.Orders.Order
  end

  @doc false
  def changeset(labor, attrs) do
    labor
    |> cast(attrs, [:description, :notes, :price])
    |> validate_required([:description, :notes, :price])
  end
end
