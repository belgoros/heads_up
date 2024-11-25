defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Incidents
  import HeadsUpWeb.Components.CustomComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> assign(:page_title, "Incidents")
      |> assign(:form, to_form(params))
      |> stream(:incidents, Incidents.filter_incidents(params))

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="incident-index">
      <.headline>
        <.icon name="hero-trophy-mini" /> 25 Incidents Resolved This Month!
        <:tagline :let={vibe}>
          Thanks for pitching in. <%= vibe %>
        </:tagline>
      </.headline>
      <.filter_form form={@form} />
      <div class="incidents" id="incidents" phx-update="stream">
        <.incident_card
          :for={{dom_id, incident} <- @streams.incidents}
          incident={incident}
          id={dom_id}
        />
      </div>
    </div>
    """
  end

  attr :form, Phoenix.HTML.Form, required: true

  def filter_form(assigns) do
    ~H"""
    <.form for={@form} id="filter-form" phx-change="filter" phx-submit="filter">
      <.input field={@form[:q]} placeholder="Search..." autocomplete="off" phx-debounce="500" />
      <.input
        type="select"
        prompt="Status"
        field={@form[:status]}
        options={Ecto.Enum.values(Incidents.Incident, :status)}
      />
      <.input type="select" prompt="Sort By" field={@form[:sort_by]} options={[:name, :priority]} />
      <.link navigate={~p"/incidents"}>
        Reset
      </.link>
    </.form>
    """
  end

  attr :incident, HeadsUp.Incidents.Incident, required: true
  attr :id, :string, required: true

  def incident_card(assigns) do
    ~H"""
    <.link navigate={~p"/incidents/#{@incident}"} id={@id}>
      <div class="card">
        <img src={@incident.image_path} />
        <h2><%= @incident.name %></h2>
        <div class="details">
          <.badge status={@incident.status} />
          <div class="priority">
            <%= @incident.priority %>
          </div>
        </div>
      </div>
    </.link>
    """
  end

  @impl true
  def handle_event("filter", params, socket) do
    params =
      params
      |> Map.take(~w(q status sort_by))
      |> Map.reject(fn {_, v} -> v == "" end)

    socket = push_navigate(socket, to: ~p"/incidents?#{params}")

    {:noreply, socket}
  end
end
