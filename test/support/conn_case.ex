defmodule Co2OffsetWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  alias Ecto.Adapters.SQL

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import Phoenix.LiveViewTest
      alias Co2OffsetWeb.Router.Helpers, as: Routes

      import Co2Offset.Factory

      # The default endpoint for testing
      @endpoint Co2OffsetWeb.Endpoint
    end
  end

  setup tags do
    :ok = SQL.Sandbox.checkout(Co2Offset.Repo)

    unless tags[:async] do
      SQL.Sandbox.mode(Co2Offset.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
