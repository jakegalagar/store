defmodule Store.Repo.Migrations.CreateTableStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :quantity, :integer, default: 0, null: false
      add :product_id, references(:products, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end
