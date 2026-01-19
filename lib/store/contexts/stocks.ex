defmodule Store.Stocks do
  import Ecto.Query, warn: false
  alias Store.Repo
  alias Store.Stocks.Stock

  alias Store.Movements.Movement

  def list_stocks do
    Stock
    |> Repo.all()
    |> Repo.preload(:product)
  end

  def get_stock!(id) do
    Repo.get!(Stock, id)
    |> Repo.preload(:product)
  end

  def create_movement(stock, params) do
    %Movement{
      stock_id: stock.id
    }
    |> Ecto.Changeset.cast(params, [:type, :quantity, :acquisition_price])
    |> Repo.insert()
  end
end
