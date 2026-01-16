defmodule Store.Repo.Migrations.CreateTableMovements do
  use Ecto.Migration

  def change do
    create table("movements") do
      add :type, :string
      add :quantity, :integer
      add :mfg_date, :date
      add :expiry_date, :date
      add :acquisition_price, :decimal
      add :stock_id, references(:stocks, on_delete: :delete_all)

      timestamps()
    end
  end
end
