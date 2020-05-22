defmodule Zheshmowen.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, references(:users), null: false
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :body, :text, null: false
      add :num_likes, :integer, default: 0

      timestamps()
    end

    create index(:posts, [:group_id])
    create index(:posts, [:user_id])
  end
end
