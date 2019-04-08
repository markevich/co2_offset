use Mix.Config

defmodule Helpers do
  def get_env(name) do
    case System.get_env(name) do
      nil -> raise "Environment variable #{name} is not set!"
      val -> val
    end
  end
end

# ensure that other env variables exists
Helpers.get_env("ERLANG_COOKIE")

config :co2_offset, Co2Offset.Endpoint, secret_key_base: Helpers.get_env("SECRET_KEY_BASE")

config :co2_offset, Co2OffsetWeb.Endpoint,
  live_view: [signing_salt: Helpers.get_env("LIVE_VIEW_SALT")],
  https: [
    port: 443,
    cipher_suite: :strong,
    keyfile: Helpers.get_env("CO2_OFFSET_SSL_KEY_PATH"),
    cacertfile: Helpers.get_env("CO2_OFFSET_SSL_CACERT_PATH"),
    certfile: Helpers.get_env("CO2_OFFSET_SSL_CERT_PATH")
  ]

config :co2_offset, Co2Offset.Repo,
  username: Helpers.get_env("DATABASE_USER"),
  password: Helpers.get_env("DATABASE_PASS"),
  database: Helpers.get_env("DATABASE_NAME"),
  hostname: "localhost",
  pool_size: 15
