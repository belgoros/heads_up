defmodule HeadsUpWeb.Api.CategoryJSON do
  def show(%{category: category}) do
    %{
      category: category_data(category),
      incidents: for(incident <- category.incidents, do: incident_data(incident))
    }
  end

  defp category_data(category) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug
    }
  end

  defp incident_data(incident) do
    %{
      id: incident.id,
      name: incident.name,
      priority: incident.priority,
      status: incident.status,
      description: incident.description,
      image_path: incident.image_path
    }
  end
end
