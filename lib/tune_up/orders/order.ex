defmodule TuneUp.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :date, :date
    field :odometer_reading, :integer
    field :stage, :integer
    field :tax, :decimal
    field :amount_paid, :float
    field :paid_in_full, :boolean, default: false
    belongs_to :customer, TuneUp.Customers.Customer
    belongs_to :automobile, TuneUp.Customers.Automobile
    has_many :labor, TuneUp.Orders.Labor

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:odometer_reading, :stage, :date, :tax, :amount_paid, :paid_in_full])
    |> validate_required([:odometer_reading, :stage])
  end
end
