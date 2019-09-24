import Config

defmodule Helpers do
  def get_env(name) do
    case System.get_env(name) do
      nil -> raise "Environment variable #{name} is not set!"
      val -> val
    end
  end
end

# ensure that env variables exists
erlang_cookie = Helpers.get_env("ERLANG_COOKIE")
secret_key_base = Helpers.get_env("SECRET_KEY_BASE")
database_url = Helpers.get_env("DATABASE_URL")
pool_size = System.get_env("POOL_SIZE") || "10"
app_host = Helpers.get_env("APP_HOST")
ssl_key_path = Helpers.get_env("SSL_KEY_PATH")
ssl_cacert_path = Helpers.get_env("SSL_CACERT_PATH")
ssl_cert_path = Helpers.get_env("SSL_CERT_PATH")

config :co2_offset, Co2Offset.Endpoint, secret_key_base: secret_key_base

config :co2_offset, Co2OffsetWeb.Endpoint,
  url: [host: app_host, port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  force_ssl: [hsts: true],
  https: [
    port: 443,
    cipher_suite: :strong,
    keyfile: ssl_key_path,
    cacertfile: ssl_cacert_path,
    certfile: ssl_cert_path
  ],
  server: true,
  root: ".",
  version: Application.spec(:co2_offset, :vsn)

config :co2_offset, Co2Offset.Repo,
  url: database_url,
  pool_size: pool_size
