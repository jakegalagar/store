defmodule Store.Repo.Migrations.CreateTableProducts do
  use Ecto.Migration

  def change do
    create table("products") do
      add :product_image, :string
      add :product_name, :string
      add :description, :string
    end
  end
end
