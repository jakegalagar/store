defmodule StoreWeb.ProductsLive.Index do
  use StoreWeb, :live_view

  alias Store.Products
  alias Store.Products.Product

  def mount(_params, _session, socket) do
    products = Products.list_products()

    patch = ~p"/products"

    socket =
      socket
      |> assign(:products, products)
      |> assign(:patch, patch)

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Products")
    |> assign(:product, %Product{})
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h2>Listing Product</h2>

      <div class="flex justify-end mb-4">
        <.link patch={~p"/products/new"}>
          <button class="bg-blue-600 hover:bg-blue-700 text-white text-sm px-4 py-2 rounded-lg shadow">
            Add Products
          </button>
        </.link>
      </div>

      <%= if @live_action == :new do %>
        <.modal id="new-modal" show on_cancel={JS.patch(@patch)}>
          <.live_component
            id={:new}
            module={StoreWeb.ProductsLive.FormComponent}
            product={@product}
          />
        </.modal>
      <% end %>

      <.table id="products" rows={@products}>
        <:col :let={product} label="ID">{product.id}</:col>
        <:col :let={product} label="Product Image">
          <img src={product.product_image} width="100" />
        </:col>
        <:col :let={product} label="Product Name">{product.product_name}</:col>
        <:col :let={product} label="Description">{product.description}</:col>
      </.table>
    </Layouts.app>
    """
  end
end
