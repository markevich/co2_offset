use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :co2_offset, Co2OffsetWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :co2_offset, Co2Offset.Repo,
  username: "postgres",
  password: "postgres",
  database: "co2_offset_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
