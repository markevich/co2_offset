# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :co2_offset,
  ecto_repos: [Co2Offset.Repo]

# Configures the endpoint
config :co2_offset, Co2OffsetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lFArEsZPzVvzHroi08W20yEYqBOYCP8qPNnrAe97TkN7JZ7BqfeplsRRWPJ/JIjA",
  render_errors: [view: Co2OffsetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Co2Offset.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
