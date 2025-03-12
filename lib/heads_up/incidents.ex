defmodule HeadsUp.Incidents do
  alias HeadsUp.Incidents.Incident

  alias HeadsUp.Repo
  import Ecto.Query

  def list_incidents do
    Repo.all(Incident)
  end

  @doc """
  Creates an incident.

  ## Examples

      iex> create_incident(%{field: value})
      {:ok, %Incident{}}

      iex> create_incident(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_incident(attrs \\ %{}) do
    %Incident{}
    |> Incident.changeset(attrs)
    |> Repo.insert()
  end

  def filter_incidents(filter) do
    Incident
    |> with_status(filter["status"])
    |> with_category(filter["category"])
    |> search_by(filter["q"])
    |> sort(filter["sort_by"])
    |> preload(:category)
    |> Repo.all()
  end

  defp with_category(query, slug) when slug in ["", nil], do: query

  defp with_category(query, slug) do
    from i in query,
      join: c in assoc(i, :category),
      where: c.slug == ^slug
  end

  defp with_status(query, status) when status in ~w(pending resolved canceled) do
    where(query, status: ^status)
  end

  defp with_status(query, _), do: query

  defp search_by(query, q) when q in ["", nil], do: query

  defp search_by(query, q) do
    where(query, [i], ilike(i.name, ^"%#{q}%"))
  end

  defp sort(query, "name") do
    order_by(query, :name)
  end

  defp sort(query, "priority_desc") do
    order_by(query, desc: :priority)
  end

  defp sort(query, "priority_asc") do
    order_by(query, asc: :priority)
  end

  defp sort(query, "category") do
    from i in query,
      join: c in assoc(i, :category),
      order_by: c.name
  end

  defp sort(query, _) do
    order_by(query, :id)
  end

  def get_incident!(id) do
    case Ecto.UUID.cast(id) do
      {:ok, uuid} -> Repo.get!(Incident, uuid) |> Repo.preload(:category)
      :error -> raise Ecto.NoResultsError, queryable: Incident
    end
  end

  def urgent_incidents(incident) do
    Incident
    |> where([i], i.id != ^incident.id)
    |> where(status: :pending)
    |> order_by(:priority)
    |> limit(3)
    |> Repo.all()
  end
end
