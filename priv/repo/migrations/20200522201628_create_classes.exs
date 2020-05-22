defmodule Zheshmowen.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :start_time, :naive_datetime, null: false
      add :end_time, :naive_datetime, null: false
      add :admin_user_id, references(:users), null: false

      timestamps()
    end

    create index(:classes, [:group_id])
    create index(:classes, [:admin_user_id])
  end
end
