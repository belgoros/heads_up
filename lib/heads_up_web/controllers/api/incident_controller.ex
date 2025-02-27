defmodule HeadsUpWeb.Api.IncidentController do
  use HeadsUpWeb, :controller

  alias HeadsUp.Incidents

  def index(conn, _params) do
    incidents = Incidents.list_incidents()
    render(conn, :index, incidents: incidents)
  end
end
