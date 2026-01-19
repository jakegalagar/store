defmodule StoreWeb.MovementLive.FormComponent do
  use StoreWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <h2>Stock</h2>
    </div>
    """
  end
end
