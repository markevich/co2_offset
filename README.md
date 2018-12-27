![Travis](https://travis-ci.com/markevich/co2_offset.svg?branch=master)
==========
# CO2 offset

Offset your carbon footpring

- [!Travis](#travis)
- [CO2 offset](#co2-offset)
  - [Install development environment](#install-development-environment)


## Install development environment
- Install Elixir:
  - `brew install elixir`
- Copy example configs:
  - `cp config/dev.secret.exs.example config/dev.secret.exs`
  - `cp config/test.secret.exs.example config/test.secret.exs`
- Install Phoenix 1.4.0.
  - `mix archive.install hex phx_new 1.4.0`
- Install `nodejs` and `npm`.
- Create a db-user for aplication in `psql` console:
  - `CREATE ROLE username LOGIN PASSWORD 'password' SUPERUSER;`
- Configure DB parameters in
  -  `config/dev.secret.exs`
  -  `config/test.secret.exs`
- Run:
  - `mix deps.get`
  - `mix deps.compile`
  - `mix ecto.create`
  - `mix ecto.migrate`
  - `cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development`
- Run the server: `mix phx.server`.
- Go to `localhost:4000` and check working of the application.
