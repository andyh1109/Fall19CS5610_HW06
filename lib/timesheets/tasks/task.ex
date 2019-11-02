defmodule Timesheets.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :desc, :string
    field :hours, :integer
    field :task_id, :integer
    field :job_code, :id
    field :sheet_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task_id, :hours, :desc])
    |> validate_required([:task_id, :hours, :desc])
  end
end
