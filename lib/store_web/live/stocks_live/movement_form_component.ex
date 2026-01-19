defmodule StoreWeb.StockLive.MovementFormComponent do
  use StoreWeb, :live_component

  alias Store.Stocks

  def update(assigns, socket) do
    changeset = Ecto.Changeset.change(assigns.movement)
    form = to_form(changeset)

    socket =
      socket
      |> assign(assigns)
      |> assign(:form, form)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <h2>Create Product</h2>

      <.simple_form for={@form} phx-target={@myself} phx-submit="save-stocks">
        <.input type="text" field={@form[:type]} label="Type" />
        <.input type="number" field={@form[:quantity]} label="Quantity" />
        <.input type="text" field={@form[:acquisition_price]} label="Price per Unit" />

        <.button>Save Stock</.button>
      </.simple_form>
    </div>
    """
  end

  def handle_event("save-stocks", %{"movement" => movement_params}, socket) do
    live_action = socket.assigns.live_action
    stock = socket.assigns.stock

    socket = save_stocks(socket, live_action, stock, movement_params)

    {:noreply, socket}
  end

  defp save_stocks(socket, :new_movement, stock, movement_params) do
    case Stocks.create_movement(stock, movement_params) do
      {:ok, _changes} ->
        socket
        |> put_flash(:info, "Stocks was created successfully")
        |> push_navigate(to: socket.assigns.patch)

      {:error, _failed_op, changeset, _changes} ->
        form = to_form(changeset)

        socket
        |> assign(:form, form)
    end
  end
end
