defmodule Timesheets.Repo.Migrations.EditJobsTalbeManager do
  use Ecto.Migration

def change do
    alter table("jobs") do
      remove :manager_id
      # add :manager_id,references(:managers, on_delete: :nothing)

  end
  end

  # def change2 do
  #   alter table("jobs") do
 
  # end
  # end
end
