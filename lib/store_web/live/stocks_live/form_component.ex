defmodule StoreWeb.StocksLive.FormComponent do
  use StoreWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <h2>Edit Product</h2>

      <.simple_form for={@form} phx-target={@myself} phx-submit="save-products"></.simple_form>
    </div>
    """
  end
end
