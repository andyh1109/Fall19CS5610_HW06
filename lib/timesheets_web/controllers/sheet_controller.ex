import Ecto.Query
defmodule TimesheetsWeb.SheetController do
  use TimesheetsWeb, :controller

  alias Timesheets.Sheets
  alias Timesheets.Sheets.Sheet
  alias Timesheet.Jobs.Job
  alias Timesheet.Repo
  alias Timesheet.Users

  def index(conn, _params) do
    sheets = Sheets.get_sheet_by_user(conn.assigns[:current_user].id)

    
    render(conn, "index.html", sheets: sheets)
  end

  def new(conn, _params) do
    changeset = Sheets.change_sheet(%Sheet{tasks: List.duplicate(%Timesheets.Tasks.Task{}, 8)})
    query = from job in Timesheets.Jobs.Job, select: job.job_code
    jobs_list = Repo.all(query)
    render(conn, "new.html", changeset: changeset, jobs_list: jobs_list)
  end

  def create(conn, %{"sheet" => sheet_params}) do
    sheet_params = Map.put(sheet_params, "user_id", conn.assigns[:current_user].id)
    query = from job in Timesheets.Jobs.Job, select: job.job_code
    jobs_list = Repo.all(query)
    case Sheets.create_sheet(sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, jobs_list: jobs_list)
    end
  end

  def show(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    sheet_id = sheet.id
    tasks = Timesheets.Tasks.get_tasks_by_sheet_id(sheet_id)
    render(conn, "show.html", sheet: sheet, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    query = from job in Timesheets.Jobs.Job, select: job.job_code
    jobs_list = Repo.all(query)
    changeset = Sheets.change_sheet(sheet)
    render(conn, "edit.html", sheet: sheet, changeset: changeset, jobs_list: jobs_list)
  end

  def update(conn, %{"id" => id, "sheet" => sheet_params}) do
    sheet = Sheets.get_sheet!(id)

    case Sheets.update_sheet(sheet, sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    {:ok, _sheet} = Sheets.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
