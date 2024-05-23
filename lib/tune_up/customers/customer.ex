defmodule TuneUp.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :state, :string
    field :zip, :string
    field :first_name, :string
    field :last_name, :string
    field :street_address, :string
    field :city, :string
    field :phone_number_1, :string
    field :phone_number_2, :string
    has_many :orders, TuneUp.Orders.Order
    many_to_many :automobiles, TuneUp.Customers.Automobile, join_through: TuneUp.Customers.Owns

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :first_name,
      :last_name,
      :street_address,
      :city,
      :zip,
      :state,
      :phone_number_1,
      :phone_number_2
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :street_address,
      :city,
      :zip,
      :state,
      :phone_number_1,
      :phone_number_2
    ])
  end
end
