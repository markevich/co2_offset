# CO2 offset

Offset your carbon footpring

- [CO2 offset](#co2-offset)
  - [Install development environment](#install-development-environment)


## Install development environment
- Install Elixir:
  - `brew install elixir`
- Install Phoenix 14.0.
  - `mix archive.install hex phx_new 1.4.0`
- Install `nodejs` and `npm`.
- Create a db-user for aplication in `psql` console:
  - `CREATE ROLE co2_offset LOGIN PASSWORD 'password' SUPERUSER;`
- Copy example config:
  - `cp config/dev.secret.exs.example config/dev.secret.exs`
- Configure DB and other parameters in `config/dev.secret.exs`
- Run:
  - `mix deps.get`
  - `mix deps.compile`
  - `mix ecto.create`
  - `mix ecto.migrate`
  - `cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development`
- Run the server: `mix phx.server`.
- Go to `localhost:4000` and check working of the application.
