defmodule Zheshmowen.Repo.Migrations.CreateGroupsUsers do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :is_admin, :boolean, default: false

      timestamps()
    end

    create unique_index(:groups_users, [:group_id, :user_id])
  end
end
