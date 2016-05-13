ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Props.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Props.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Props.Repo)

