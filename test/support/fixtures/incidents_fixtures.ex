defmodule HeadsUp.IncidentsFixtures do
  import HeadsUp.CategoriesFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `HeadsUp.Incidents` context.
  """

  @doc """
  Generate an incident.
  """
  def incident_fixture(attrs \\ %{}) do
    category = category_fixture()

    {:ok, incident} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description",
        priority: 1,
        status: :pending,
        image_path: "some/path_to/image.png",
        category_id: category.id
      })
      |> HeadsUp.Incidents.create_incident()

    incident
  end
end
