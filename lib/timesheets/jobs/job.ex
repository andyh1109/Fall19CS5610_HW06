defmodule Timesheets.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :budget, :integer
    field :desc, :string
    field :job_code, :string
    field :manager_id, :string

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_code, :budget, :desc, :manager_id])
    |> validate_required([:job_code, :budget, :desc, :manager_id])
  end
end
