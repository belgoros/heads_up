defmodule HeadsUp.ResponsesTest do
  use HeadsUp.DataCase

  alias HeadsUp.Responses

  describe "responses" do
    alias HeadsUp.Responses.Response
    alias HeadsUp.Incidents.Incident
    alias HeadsUp.Accounts.User

    import HeadsUp.ResponsesFixtures
    import HeadsUp.AccountsFixtures
    import HeadsUp.IncidentsFixtures

    @invalid_attrs %{status: nil, note: nil}

    test "list_responses/0 returns all responses" do
      response = response_fixture()
      assert Responses.list_responses() == [response]
    end

    test "get_response!/1 returns the response with given id" do
      response = response_fixture()
      assert Responses.get_response!(response.id) == response
    end

    test "create_response/1 with valid data creates a response" do
      user = user_fixture()
      incident = incident_fixture()

      valid_attrs = %{
        status: :enroute,
        note: "some note",
        user_id: user.id,
        incident_id: incident.id
      }

      assert {:ok, %Response{} = response} =
               Responses.create_response(incident, user, valid_attrs)

      assert response.status == :enroute
      assert response.note == "some note"
    end

    test "create_response/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Responses.create_response(%Incident{}, %User{}, @invalid_attrs)
    end

    test "update_response/2 with valid data updates the response" do
      response = response_fixture()
      update_attrs = %{status: :arrived, note: "some updated note"}

      assert {:ok, %Response{} = response} = Responses.update_response(response, update_attrs)
      assert response.status == :arrived
      assert response.note == "some updated note"
    end

    test "update_response/2 with invalid data returns error changeset" do
      response = response_fixture()
      assert {:error, %Ecto.Changeset{}} = Responses.update_response(response, @invalid_attrs)
      assert response == Responses.get_response!(response.id)
    end

    test "delete_response/1 deletes the response" do
      response = response_fixture()
      assert {:ok, %Response{}} = Responses.delete_response(response)
      assert_raise Ecto.NoResultsError, fn -> Responses.get_response!(response.id) end
    end

    test "change_response/1 returns a response changeset" do
      response = response_fixture()
      assert %Ecto.Changeset{} = Responses.change_response(response)
    end
  end
end
