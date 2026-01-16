defmodule Store.Movements.Movement do
  use Ecto.Schema

  alias Store.Stocks.Stock

  schema "movements" do
    field :type, :string
    field :quantity, :integer
    field :mfg_date, :date
    field :expiry_date, :date
    field :acquisition_price, :decimal

    belongs_to :stock, Stock

    timestamps()
  end
end
