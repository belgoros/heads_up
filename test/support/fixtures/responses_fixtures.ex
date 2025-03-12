defmodule HeadsUp.ResponsesFixtures do
  import HeadsUp.AccountsFixtures
  import HeadsUp.IncidentsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `HeadsUp.Responses` context.
  """

  @doc """
  Generate a response.
  """
  def response_fixture(attrs \\ %{}) do
    user = user_fixture()
    incident = incident_fixture()

    {:ok, response} =
      attrs
      |> Enum.into(%{
        note: "some note",
        status: :enroute,
        user_id: user.id,
        incident_id: incident.id
      })
      |> HeadsUp.Responses.create_response()

    response
  end
end
