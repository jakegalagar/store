defmodule StoreWeb.ProductsLive.Show do
  use StoreWeb, :live_view

  alias Store.Products

  def mount(%{"id" => id}, _session, socket) do
    product = Products.get_product!(id)

    patch = ~p"/products/#{id}"

    socket =
      socket
      |> assign(:product, product)
      |> assign(:patch, patch)
      |> assign(:show_modal, false)

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :show, _params) do
    socket
  end

  defp apply_action(socket, :edit, _params) do
    socket
    |> assign(:page_title, "Edit Product")
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gray-100 py-10 px-4">
      <div class="max-w-5xl mx-auto bg-white rounded-2xl shadow-lg overflow-hidden">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 p-8">
          
    <!-- LEFT: PRODUCT IMAGE -->
          <div class="flex items-center justify-center bg-gray-50 rounded-xl p-6">
            <img
              src={@product.product_image}
              alt={@product.product_name}
              class="max-h-80 object-contain rounded-lg"
            />
          </div>
          
    <!-- RIGHT: PRODUCT INFO -->
          <div class="flex flex-col justify-between">
            <div>
              <h1 class="text-3xl font-bold text-gray-900 mb-4">
                {@product.product_name}
              </h1>

              <p class="text-gray-600 text-lg leading-relaxed mb-6">
                {@product.description}
              </p>
            </div>
            
    <!-- ACTIONS -->
            <div class="flex justify-end gap-2 mt-6">
              <.link
                navigate={~p"/products"}
                class="px-3 py-2 rounded-xl bg-gray-200 text-gray-800 font-medium hover:bg-gray-300 transition"
              >
                ← Back
              </.link>

              <.link
                patch={~p"/products/#{@product.id}/show/edit"}
                class="px-3 py-2 rounded-md bg-blue-600 text-white font-small hover:bg-blue-700 transition me-2"
              >
                Edit Product
              </.link>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%= if @live_action == :edit do %>
      <.modal id="edit-product-modal" show on_cancel={JS.patch(@patch)}>
        <.live_component
          id={@product.id}
          module={StoreWeb.ProductsLive.FormComponent}
          patch={@patch}
          product={@product}
          page_title={@page_title}
          live_action={@live_action}
        />
      </.modal>
    <% end %>
    """
  end
end
