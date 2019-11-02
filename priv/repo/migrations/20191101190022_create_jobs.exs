defmodule Timesheets.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_code, :string
      add :budget, :integer
      add :desc, :string
      add :manager_id, :string

      timestamps()
    end

  end
end
