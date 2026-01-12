defmodule Store.Products.Product do
  use Ecto.Schema

  schema "products" do
    field :product_image, :string
    field :product_name, :string
    field :description, :string
  end
end
