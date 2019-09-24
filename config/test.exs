import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :co2_offset, Co2OffsetWeb.Endpoint,
  http: [port: 4002],
  server: false,
  live_view: [
    signing_salt: "SECRET_TEST_SALT"
  ]

# Print only warnings and errors during test
config :logger, level: :warn

import_config "test.secret.exs"
