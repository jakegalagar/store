defmodule StoreWeb.ProductsLive.FormComponent do
  use StoreWeb, :live_component

  alias Store.Products

  def update(assigns, socket) do
    changeset = Ecto.Changeset.change(assigns.product)
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
      <h2>Edit Product</h2>

      <.simple_form for={@form} phx-target={@myself} phx-submit="save-products">
        <.input type="url" field={@form[:product_image]} label="Product Image" step="0.01" required />
        <.input type="text" field={@form[:product_name]} label="Product Name" step="0.01" required />
        <.input type="textarea" field={@form[:description]} label="Description" step="0.01" required />
        <.button>Save</.button>
      </.simple_form>
    </div>
    """
  end

  def handle_event("save-products", %{"product" => product_params}, socket) do
    socket = save_product(socket, socket.assigns.live_action, product_params)

    {:noreply, socket}
  end

  defp save_product(socket, :new, product_params) do
    case Products.create_products(product_params) do
      {:ok, _changes} ->
        socket
        |> put_flash(:info, "Products was Created Successfully")
        |> push_navigate(to: socket.assigns.patch)

      {:error, _failed_op, changeset, _changes} ->
        form = to_form(changeset)

        socket
        |> assign(:form, form)
    end
  end

  defp save_product(socket, :edit, product_params) do
    product = socket.assigns.product

    case Products.update_products(product, product_params) do
      {:ok, _changes} ->
        socket
        |> put_flash(:info, "Product was Update Successfully.")
        |> push_navigate(to: socket.assigns.patch)

      {:error, _failed_op, changeset, _changes} ->
        form = to_form(changeset)

        socket
        |> assign(:form, form)
    end
  end
end
