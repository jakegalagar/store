defmodule Store.Stocks do
  import Ecto.Query, warn: false
  alias Store.Repo
  alias Store.Stocks.Stock

  def list_stocks do
    Stock
    |> Repo.all()
    |> Repo.preload(:product)
  end

  def get_stock!(id) do
    Repo.get!(Stock, id)
    |> Repo.preload(:product)
  end
end
