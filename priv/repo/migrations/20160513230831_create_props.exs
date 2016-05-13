defmodule Props.Repo.Migrations.CreateProps do
  use Ecto.Migration

  def change do
    create table(:props) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :propser_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:props, [:user_id])
    create index(:props, [:propser_id])

  end
end
