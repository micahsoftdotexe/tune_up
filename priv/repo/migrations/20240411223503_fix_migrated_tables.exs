defmodule TuneUp.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      modify :date, :date
    end

    alter table(:quantity_types) do
      modify :description, :string
    end

    alter table(:orders) do
      timestamps(type: :utc_datetime, null: true)
    end
  end
end
