defmodule HeadsUpWeb.AdminUsersLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Admin

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Listing Users")
      |> stream(:users, Admin.list_users())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="admin-index">
      <.header>
        {@page_title}
      </.header>
      <.table id="users" rows={@streams.users}>
        <:col :let={{_dom_id, user}} label="Username">
          {user.username}
        </:col>

        <:col :let={{_dom_id, user}} label="Email">
          {user.email}
        </:col>

        <:col :let={{_dom_id, user}} label="Admin">
          {user.is_admin}
        </:col>
      </.table>
    </div>
    """
  end
end
