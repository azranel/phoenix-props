defmodule Props.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :last_name, :string
      add :first_name, :string
      add :picture, :string

      timestamps
    end

  end
end
