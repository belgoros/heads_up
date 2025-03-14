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

    attrs =
      attrs
      |> Enum.into(%{
        note: "some note",
        status: :enroute
      })

    {:ok, response} = HeadsUp.Responses.create_response(incident, user, attrs)

    # Fetch created response so incident and user associations
    # aren't loaded which the tests don't expect.
    HeadsUp.Responses.get_response!(response.id)
  end
end
