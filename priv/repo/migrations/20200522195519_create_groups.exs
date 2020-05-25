defmodule Zheshmowen.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:groups, [:name])
    create unique_index(:groups, [:slug])
  end
end
