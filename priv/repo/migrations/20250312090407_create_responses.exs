defmodule HeadsUp.Repo.Migrations.CreateResponses do
  use Ecto.Migration

  def change do
    create table(:responses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :note, :text
      add :status, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false
      add :incident_id, references(:incidents, on_delete: :delete_all, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:responses, [:user_id])
    create index(:responses, [:incident_id])
  end
end
