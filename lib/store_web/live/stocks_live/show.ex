defmodule StoreWeb.StockLive.Show do
  use StoreWeb, :live_view

  alias Store.Stocks

  def mount(%{"id" => id}, _session, socket) do
    stock = Stocks.get_stock!(id)

    socket =
      socket
      |> assign(:stock, stock)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="max-w-xl mx-auto">
        <h1 class="text-3xl font-bold mb-4">
          {@stock.product.product_name}
        </h1>

        <p class="text-gray-600 mb-2">
          Quantity Available:
          <span class="font-semibold">
            {@stock.quantity}
          </span>
        </p>

        <div class="mt-6">
          <a href="/stocks" class="text-sm text-gray-500 hover:underline">
            ← Back to Stocks
          </a>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
