defmodule HeadsUp.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :link, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:urls, [:link])
    create unique_index(:urls, [:title])
  end
end
