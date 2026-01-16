defmodule Store.Stocks.Stock do
  use Ecto.Schema

  import Ecto.Changeset
  alias Store.Products.Product

  schema "stocks" do
    field :quantity, :integer

    belongs_to :product, Product

    timestamps()
  end

  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:quantity, :product_id])
    |> validate_required([:quantity, :product_id])
  end
end
