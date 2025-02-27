defmodule HeadsUpWeb.Api.IncidentJSON do
  def index(%{incidents: incidents}) do
    %{
      incidents:
        for incident <- incidents do
          %{
            id: incident.id,
            name: incident.name,
            priority: incident.priority,
            status: incident.status,
            description: incident.description,
            image_path: incident.image_path,
            category_id: incident.category_id
          }
        end
    }
  end
end
