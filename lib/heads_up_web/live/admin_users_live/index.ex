defmodule HeadsUpWeb.AdminUsersLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Admin
  alias HeadsUp.Accounts
  import HeadsUpWeb.CustomComponents

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
          <.admin_badge admin={user.is_admin} />
        </:col>
        <:action :let={{_dom_id, user}}>
          <.link phx-click="promote" phx-value-id={user.id}>
            Promote
          </.link>
        </:action>
      </.table>
    </div>
    """
  end

  def handle_event("promote", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)

    case Accounts.promote_to_admin(user) do
      {:ok, user} ->
        socket =
          socket
          |> put_flash(:info, "User promoted!")
          |> stream_insert(:users, user)

        {:noreply, socket}

      {:error, error} ->
        {:noreply, put_flash(socket, :error, error)}
    end
  end
end
