defmodule StoreWeb.StockLive.Show do
  use StoreWeb, :live_view

  alias Store.Movements
  alias Store.Movements.Movement
  alias Store.Stocks

  def mount(%{"id" => id}, _session, socket) do
    stock = Stocks.get_stock!(id)
    movements = Movements.list_movements()

    patch = ~p"/stocks/#{id}"

    socket =
      socket
      |> assign(:stock, stock)
      |> assign(:movements, movements)
      |> assign(:patch, patch)

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

  defp apply_action(socket, :new_movement, _params) do
    socket
    |> assign(:movement, %Movement{})
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1>{@live_action}</h1>

      <hr />

      <%= if @live_action == :new_movement do %>
        <.modal id="new-movement-modal" show on_cancel={JS.patch(@patch)}>
          <.live_component
            id={@stock.id}
            module={StoreWeb.StockLive.MovementFormComponent}
            stock={@stock}
            movement={@movement}
            patch={@patch}
            live_action={@live_action}
          />
        </.modal>
      <% end %>

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

        <h1 class="text-2xl font-bold mb-4">Stock Movements</h1>

        <div class="flex justify-end mb-4">
          <.link navigate={~p"/stocks/#{@stock}/movements/new"}>
            <button class="bg-blue-600 hover:bg-blue-700 text-white text-sm px-4 py-2 rounded-lg shadow">
              Add Stocks
            </button>
          </.link>
        </div>

        <.table id="movements" rows={@movements}>
          <:col :let={movement} label="Stock">
            {movement.stock_id}
          </:col>

          <:col :let={movement} label="Type">
            {movement.type}
          </:col>

          <:col :let={movement} label="Quantity">
            {movement.quantity}
          </:col>

          <:col :let={movement} label="Mfg Date">
            {movement.mfg_date}
          </:col>

          <:col :let={movement} label="Expiry Date">
            {movement.expiry_date}
          </:col>

          <:col :let={movement} label="Acquisition Price">
            {movement.acquisition_price}
          </:col>
        </.table>

        <div class="mt-6">
          <a href="/stocks" class="text-sm text-gray-500 hover:underline">
            ← Back to Stocks
          </a>
        </div>

        <Layouts.app flash={@flash}></Layouts.app>
      </div>
    </Layouts.app>
    """
  end
end
