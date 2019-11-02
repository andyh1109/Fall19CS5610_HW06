defmodule Timesheets.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :email, :string
      add :name, :string
      add :password, :string
      add :manager_id, :string

      timestamps()
    end

  end
end
