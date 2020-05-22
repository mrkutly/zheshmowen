defmodule Zheshmowen.Repo.Migrations.CreateClassParticipants do
  use Ecto.Migration

  def change do
    create table(:class_participants) do
      add :class_id, references(:classes, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
    end

    create index(:class_participants, [:class_id])
    create index(:class_participants, [:user_id])
    create unique_index(:class_participants, [:class_id, :user_id])
  end
end
