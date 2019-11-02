defmodule Timesheets.JobsTest do
  use Timesheets.DataCase

  alias Timesheets.Jobs

  describe "jobs" do
    alias Timesheets.Jobs.Job

    @valid_attrs %{budget: 42, desc: "some desc", job_code: "some job_code", manager_id: "some manager_id"}
    @update_attrs %{budget: 43, desc: "some updated desc", job_code: "some updated job_code", manager_id: "some updated manager_id"}
    @invalid_attrs %{budget: nil, desc: nil, job_code: nil, manager_id: nil}

    def job_fixture(attrs \\ %{}) do
      {:ok, job} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_job()

      job
    end

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Jobs.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Jobs.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      assert {:ok, %Job{} = job} = Jobs.create_job(@valid_attrs)
      assert job.budget == 42
      assert job.desc == "some desc"
      assert job.job_code == "some job_code"
      assert job.manager_id == "some manager_id"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      assert {:ok, %Job{} = job} = Jobs.update_job(job, @update_attrs)
      assert job.budget == 43
      assert job.desc == "some updated desc"
      assert job.job_code == "some updated job_code"
      assert job.manager_id == "some updated manager_id"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end
  end
end
