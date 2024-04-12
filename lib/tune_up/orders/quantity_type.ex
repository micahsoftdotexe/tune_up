defmodule TuneUp.Orders.QuantityType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quantity_types" do
    field :description, :string
    has_many :parts, TuneUp.Orders.Part
  end

  @doc false
  def changeset(quantity_type, attrs) do
    quantity_type
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
