defmodule StoreWeb.PageController do
  use StoreWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
