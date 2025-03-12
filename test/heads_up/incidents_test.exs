defmodule HeadsUp.IncidentsTest do
  use HeadsUp.DataCase

  alias HeadsUp.Incidents

  describe "incidents" do
    alias HeadsUp.Incidents.Incident

    import HeadsUp.IncidentsFixtures
    import HeadsUp.CategoriesFixtures

    @invalid_attrs %{
      name: nil,
      description: nil,
      priority: nil,
      status: nil,
      image_path: nil,
      category_id: nil
    }

    test "list_incidents/0 returns all incidents" do
      incident = incident_fixture()
      assert Incidents.list_incidents() == [incident]
    end

    test "create_incident/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Incidents.create_incident(@invalid_attrs)
    end

    test "create_incident/1 with valid data creates an incident" do
      category = category_fixture()

      valid_attrs = %{
        name: "some name",
        description: "some description",
        priority: 1,
        status: :pending,
        image_path: "some/path_to/image.png",
        category_id: category.id
      }

      assert {:ok, %Incident{} = incident} = Incidents.create_incident(valid_attrs)
      assert incident.name == "some name"
      assert incident.description == "some description"
      assert incident.category_id == category.id
    end
  end
end
