defmodule StoreWeb.MovementLive.Index do
  use StoreWeb, :live_view

  alias Store.Movements

  def mount(_params, _session, socket) do
    movements = Movements.list_movements()

    socket =
      socket
      |> assign(:movements, movements)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1 class="text-2xl font-bold mb-4">Movements</h1>

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
    </Layouts.app>
    """
  end
end
