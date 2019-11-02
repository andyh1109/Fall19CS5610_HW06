defmodule Timesheets.Managers.Manager do
  use Ecto.Schema
  import Ecto.Changeset

  schema "managers" do
    field :email, :string
    field :manager_id, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(manager, attrs) do
    manager
    |> cast(attrs, [:email, :name, :password, :manager_id])
    |> validate_required([:email, :name, :password, :manager_id])
  end
end
