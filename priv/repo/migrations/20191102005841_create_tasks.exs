defmodule Timesheets.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task_id, :integer
      add :hours, :integer
      add :desc, :text
      add :job_code, references(:jobs, on_delete: :nothing)
      add :sheet_id, references(:sheets, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:job_code])
    create index(:tasks, [:sheet_id])
  end
end
