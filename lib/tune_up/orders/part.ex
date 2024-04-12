defmodule TuneUp.Orders.Part do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts" do
    field :description, :string
    field :price, :float
    field :margin, :float
    field :quantity, :float
    field :part_number, :string
    belongs_to :order, TuneUp.Orders.Order
    belongs_to :quantity_type, TuneUp.Orders.QuantityType

  end

  @doc false
  def changeset(part, attrs) do
    part
    |> cast(attrs, [:price, :margin, :quantity, :description, :part_number])
    |> validate_required([:price, :margin, :quantity, :description, :part_number])
  end
end
