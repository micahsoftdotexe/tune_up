defmodule TuneUp.Orders.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :text, :string
    belongs_to :users, TuneUp.Users.User, foreign_key: :created_by

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
