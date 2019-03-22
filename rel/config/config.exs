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
Helpers.get_env("PORT")

config :co2_offset, Co2Offset.Endpoint,
  secret_key_base: Helpers.get_env("SECRET_KEY_BASE")

config :co2_offset, Co2Offset.Repo,
  username: Helpers.get_env("DATABASE_USER"),
  password: Helpers.get_env("DATABASE_PASS"),
  database: Helpers.get_env("DATABASE_NAME"),
  hostname: "localhost",
  pool_size: 15
