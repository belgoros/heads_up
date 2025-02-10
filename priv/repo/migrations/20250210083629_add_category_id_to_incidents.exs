defmodule HeadsUp.Repo.Migrations.AddCategoryIdToIncidents do
  use Ecto.Migration

  def change do
    alter table(:incidents) do
      add :category_id, references(:categories, type: :binary_id)
    end

    create index(:incidents, [:category_id])
  end
end
