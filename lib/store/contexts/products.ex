defmodule Store.Products do
  alias Store.Repo
  alias Store.Products.Product

  def list_products() do
    Repo.all(Product)
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def delete_product(id) do
    product = get_product!(id)

    Repo.delete(product)
  end

  def create_products(params) do
    %Product{}
    |> Ecto.Changeset.cast(params, [:product_image, :product_name, :description])
    |> Repo.insert()
  end

  def update_products(product, params) do
    product
    |> Ecto.Changeset.cast(params, [:product_image, :product_name, :description])
    |> Repo.update()
  end
end
