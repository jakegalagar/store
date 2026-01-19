defmodule StoreWeb.StockLive.Index do
  use StoreWeb, :live_view

  alias Store.Stocks

  def mount(_params, _session, socket) do
    stocks = Stocks.list_stocks()

    patch = ~p"/stocks"

    socket =
      socket
      |> assign(:stocks, stocks)
      |> assign(:patch, patch)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1 class="text-4xl font-bold mb-6">Stocks</h1>

      <.table id="stocks" rows={@stocks}>
        <:col :let={stock} label="ID">{stock.id}</:col>

        <:col :let={stock} label="Product ID">
          {stock.product.product_name}
        </:col>

        <:col :let={stock} label="Quantity Available">
          <span class="font-semibold">
            {stock.quantity}
          </span>
        </:col>

        <:action :let={stock}>
          <.link
            navigate={~p"/stocks/#{stock}"}
            class="rounded-lg bg-zinc-50 px-2 py-2 hover:bg-zinc-200/100"
          >
            show
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end
end
