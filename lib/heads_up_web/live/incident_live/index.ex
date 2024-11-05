defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Incidents

  def mount(_params, _session, socket) do
    incidents = Incidents.list_incidents()

    socket =
      assign(socket,
        incidents: incidents
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="incident-index">
      <div class="incidents">
        <.incident_card :for={incident <- @incidents} incident={incident} />
      </div>
    </div>
    """
  end

  attr :incident, HeadsUp.Incident, required: true

  def incident_card(assigns) do
    ~H"""
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
    """
  end

  attr :status, :atom, values: [:pending, :resolved, :canceled], default: :pending

  def badge(assigns) do
    ~H"""
    <div class="inline-block px-2 py-1 text-xs font-medium uppercase border rounded-md">
      <%= @status %>
    </div>
    """
  end
end
