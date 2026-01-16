defmodule Store.Movements do
  import Ecto.Query, warn: false
  alias Store.Repo
  alias Store.Movements.Movement

  def list_movements() do
    Repo.all(Movement)
  end
end
