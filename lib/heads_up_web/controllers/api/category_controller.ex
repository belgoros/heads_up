defmodule HeadsUpWeb.Api.CategoryController do
  alias HeadsUp.Categories
  use HeadsUpWeb, :controller

  def show(conn, %{"id" => category_id}) do
    category = Categories.get_category_with_incidents!(category_id)

    render(conn, :show, category: category)
  rescue
    Ecto.NoResultsError ->
      conn
      |> put_status(:not_found)
      |> put_view(json: HeadsUpWeb.ErrorJSON)
      |> render(:"404")
  end
end
