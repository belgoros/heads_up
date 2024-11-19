defmodule HeadsUp.Incidents do
  alias HeadsUp.Incidents.Incident

  alias HeadsUp.Repo
  import Ecto.Query

  def list_incidents do
    Repo.all(Incident)
  end

  def get_incident!(id) do
    Repo.get!(Incident, id)
  end

  def urgent_incidents(incident) do
    Incident
    |> where([i], i.id != ^incident.id)
    |> where(status: :pending)
    |> order_by(:priority)
    |> limit(3)
    |> Repo.all()
  end

  def filter_incidents(filter) do
    Incident
    |> where(status: ^filter["status"])
    |> where([i], ilike(i.name, ^"%#{filter["q"]}%"))
    |> order_by(desc: :name)
    |> Repo.all()
  end
end
