defmodule AmigoBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do

    create table(:users) do
      add :username, :string, null: false
      add :name, :string
      add :last_name, :string
      add :password, :string, null: false
      add :email, :string, null: false

      timestamps()
    end
  end
end
