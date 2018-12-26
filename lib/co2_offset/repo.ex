defmodule Co2Offset.Repo do
  use Ecto.Repo,
    otp_app: :co2_offset,
    adapter: Ecto.Adapters.Postgres
end
