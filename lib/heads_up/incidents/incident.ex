defmodule HeadsUp.Incidents.Incident do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "incidents" do
    field :name, :string
    field :priority, :integer, default: 1
    field :status, Ecto.Enum, values: [:pending, :resolved, :canceled], default: :pending
    field :description, :string
    field :image_path, :string, default: "/images/placeholder.jpg"

    timestamps(type: :utc_datetime)
  end

  @accepted_attributes [:name, :description, :priority, :status, :image_path]
  @required_attributes [:name, :description, :priority, :status, :image_path]

  @doc false
  def changeset(incident, attrs) do
    incident
    |> cast(attrs, @accepted_attributes)
    |> validate_required(@required_attributes)
    |> validate_length(:description, min: 10)
    |> validate_inclusion(:priority, 1..3)
  end
end
