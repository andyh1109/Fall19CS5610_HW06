defmodule Timesheets.Repo.Migrations.AddManagerToJobs do
  use Ecto.Migration

  def change do
    alter table("jobs") do

      add :manager_id,references(:managers, on_delete: :nothing)
end    
  end
end
