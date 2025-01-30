defmodule HeadsUp.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "urls" do
    field :link, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:title, :link])
    |> validate_required([:title, :link])
    |> unique_constraint(:link)
    |> unique_constraint(:title)
  end
end
