defmodule HeadsUpWeb.AdminIncidentLive.Form do
  use HeadsUpWeb, :live_view
  alias HeadsUp.Admin
  alias HeadsUp.Incidents.Incident

  def mount(_params, _session, socket) do
    changeset = Incident.changeset(%Incident{}, %{})

    socket =
      socket
      |> assign(:page_title, "New Incident")
      |> assign(:form, to_form(changeset, as: "incident"))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>
    <.simple_form for={@form} id="incident-form" phx-submit="save">
      <.input field={@form[:name]} label="Name" />
      <.input field={@form[:priority]} label="Priority" />
      <.input
        field={@form[:status]}
        type="select"
        label="Status"
        prompt="Choose a status"
        options={[:pending, :resolved, :canceled]}
      />

      <.input field={@form[:description]} type="textarea" label="Description" />
      <.input field={@form[:image_path]} label="Image path" />
      <:actions>
        <.button phx-disable-with="Saving...">Save Incident</.button>
      </:actions>
    </.simple_form>
    <.back navigate={~p"/admin/incidents"}>
      Back
    </.back>
    """
  end

  def handle_event("save", %{"incident" => incident_params}, socket) do
    case Admin.create_incident(incident_params) do
      {:ok, _incident} ->
        socket =
          socket
          |> put_flash(:info, "Incident saved successfully!")
          |> push_navigate(to: ~p"/admin/incidents")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end
