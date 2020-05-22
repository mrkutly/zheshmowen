defmodule Zheshmowen.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :post_id, references(:posts, on_delete: :delete_all), null: false
      add :user_id, references(:users), null: false
      add :body, :text, null: false
      add :num_likes, :integer, null: false, default: 0

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end
