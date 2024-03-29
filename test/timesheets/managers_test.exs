defmodule Timesheets.ManagersTest do
  use Timesheets.DataCase

  alias Timesheets.Managers

  describe "managers" do
    alias Timesheets.Managers.Manager

    @valid_attrs %{email: "some email", manager_id: "some manager_id", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", manager_id: "some updated manager_id", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, manager_id: nil, name: nil, password: nil}

    def manager_fixture(attrs \\ %{}) do
      {:ok, manager} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Managers.create_manager()

      manager
    end

    test "list_managers/0 returns all managers" do
      manager = manager_fixture()
      assert Managers.list_managers() == [manager]
    end

    test "get_manager!/1 returns the manager with given id" do
      manager = manager_fixture()
      assert Managers.get_manager!(manager.id) == manager
    end

    test "create_manager/1 with valid data creates a manager" do
      assert {:ok, %Manager{} = manager} = Managers.create_manager(@valid_attrs)
      assert manager.email == "some email"
      assert manager.manager_id == "some manager_id"
      assert manager.name == "some name"
      assert manager.password == "some password"
    end

    test "create_manager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Managers.create_manager(@invalid_attrs)
    end

    test "update_manager/2 with valid data updates the manager" do
      manager = manager_fixture()
      assert {:ok, %Manager{} = manager} = Managers.update_manager(manager, @update_attrs)
      assert manager.email == "some updated email"
      assert manager.manager_id == "some updated manager_id"
      assert manager.name == "some updated name"
      assert manager.password == "some updated password"
    end

    test "update_manager/2 with invalid data returns error changeset" do
      manager = manager_fixture()
      assert {:error, %Ecto.Changeset{}} = Managers.update_manager(manager, @invalid_attrs)
      assert manager == Managers.get_manager!(manager.id)
    end

    test "delete_manager/1 deletes the manager" do
      manager = manager_fixture()
      assert {:ok, %Manager{}} = Managers.delete_manager(manager)
      assert_raise Ecto.NoResultsError, fn -> Managers.get_manager!(manager.id) end
    end

    test "change_manager/1 returns a manager changeset" do
      manager = manager_fixture()
      assert %Ecto.Changeset{} = Managers.change_manager(manager)
    end
  end
end
