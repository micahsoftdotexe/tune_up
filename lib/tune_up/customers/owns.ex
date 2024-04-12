defmodule TuneUp.Customers.Owns do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key false
  schema "owns" do
    belongs_to :customer, TuneUp.Customers.Customer
    belongs_to :automobile, TuneUp.Customers.Automobile
  end

  @doc false
  def changeset(owns, attrs) do
    owns
    |> cast(attrs, [])
    |> validate_required([])
  end
end
