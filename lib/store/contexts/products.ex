defmodule Store.Products do
  alias Store.Repo
  alias Store.Products.Product

  def list_products() do
    Repo.all(Product)
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def create_products(params) do
    %Product{}
    |> Ecto.Changeset.cast(params, [:product_image, :product_name, :decription])
    |> Repo.insert()
  end
end
