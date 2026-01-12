defmodule StoreWeb.ProductsLive.FormComponent do
  use StoreWeb, :live_component

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
      <h2>New Product</h2>

      <.simple_form for={@form} phx-target={@myself} phx-submit="save-products">
        <.input type="url" field={@form[:product_image]} label="Product Image" />
        <.input type="text" field={@form[:product_name]} label="Product Name" />
        <.input type="textarea" field={@form[:description]} label="Description" />
        <.button>Save</.button>
      </.simple_form>
    </div>
    """
  end
end
