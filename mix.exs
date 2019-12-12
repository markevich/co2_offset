defmodule Co2Offset.MixProject do
  use Mix.Project

  def project do
    [
      app: :co2_offset,
      version: "0.4.1",
      elixir: "~> 1.9.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Co2Offset.Application, []},
      extra_applications: app_list(Mix.env())
    ]
  end

  def app_list(_), do: app_list()
  def app_list, do: [:logger, :runtime_tools]

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.1", override: true},
      {:phoenix_pubsub, "~> 1.1.1"},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:floki, "~> 0.23.0", only: :test},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.13.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:ecto_sql, "~> 3.3.0"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 2.0"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.3", only: :test},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
