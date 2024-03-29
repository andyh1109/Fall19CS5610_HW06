# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheets.Repo.insert!(%Timesheets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Timesheets.Repo
alias Timesheets.Users.User

Repo.insert!(%User{name: "Alice", email: "alice@example.com", password: "123"})
Repo.insert!(%User{name: "Bob", email: "bob@example.com", password: "123"})